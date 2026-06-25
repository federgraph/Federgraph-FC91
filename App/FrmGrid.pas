unit FrmGrid;

(*
-
-     F
-    * * *
-   *   *   G
-  *     * *   *
- E - - - H - - - I
-  *     * *         *
-   *   *   *           *
-    * *     *             *
-     D-------A---------------B
-              *
-              (C) federgraph.de
-
*)

interface

uses
  System.SysUtils,
  System.Classes,
  System.Math.Vectors,
  FMX.Types,
  FMX.Types3D,
  FMX.StdCtrls,
  FMX.Controls,
  FMX.Forms,
  FMX.Layouts,
  RiggVar.Grid.ColGrid,
  RiggVar.Grid.Block,
  RiggVar.Col.Animation,
  RiggVar.FB.Def,
  FMX.Controls.Presentation;

type
  TFormGrid = class(TForm)
    ToolBar: TPanel;
    AddBtn: TButton;
    UpdateBtn: TButton;
    ClearBtn: TButton;
    Layout: TLayout;
    procedure LoadBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure UpdateBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
    procedure TrackBtnClick(Sender: TObject);
  private
    AngleValue: Integer;
    AngleDiff: Integer;
    AngleChanged: Boolean;
    FRotation: TPoint3D;

    FParam: Integer;
    FStopValue: Integer;
    FOnProductionEvent: TRecorderEvent;
    FIsTracking: Boolean;
    procedure SetOnProductionEvent(const Value: TRecorderEvent);
    procedure ToggleTracking;
    procedure SetIsTracking(const Value: Boolean);
    procedure UpdateTracking;
    function NormalizeAngle(const Angle: Integer): Integer;
    procedure Rotate(p, s, ad: Integer);
    function GetCollection: TAnimationRowCollection;
    procedure TrackAngle(p, t: Integer);
    function ShowRotation: string;
    procedure LocalGO;
  protected
    procedure OnFinishEdit(cr: TBaseRowCollectionItem);
  public
    Memo: TStrings; //Reference

    ColBO: TAnimationBO;
    Node: TAnimationNode;

    GB: TGridBlock;
    ColGrid: TColGrid;

    Main_FederMousepad_ModelRotation: TPoint3D;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitGrid;
    procedure DisposeGrid;
    procedure UpdateGrid;

    procedure OnTrackEvent(fp: TFederParam; pv: Integer); overload;
    procedure OnTrackEvent(fmk: TFederMessageKind; mv: Integer); overload;
    procedure OnTrackEvent(p, start, stop: Integer); overload;

    property OnProductionEvent: TRecorderEvent read FOnProductionEvent write SetOnProductionEvent;
    property IsTracking: Boolean read FIsTracking write SetIsTracking;
    property Collection: TAnimationRowCollection read GetCollection;
  end;

var
  FormGrid: TFormGrid;

implementation

{$R *.fmx}

uses
 RiggVar.App.Main;

constructor TFormGrid.Create(AOwner: TComponent);
begin
  inherited;
  GB := TGridBlock.Create;
  GB.Name := 'AnimationEntries';
  GB.Parent := Layout;
  ColBO := Main.AnimationData;
  Node := ColBO.CurrentNode as TAnimationNode;
  Layout.Align := TAlignLayout.Client;
end;

destructor TFormGrid.Destroy;
begin
  GB.Free;
  inherited;
end;

procedure TFormGrid.InitGrid;
begin
  GB.Node := ColBO.CurrentNode;
  GB.ColBO := ColBO;

  GB.BeginInitGrid;

  ColGrid := GB.ColGrid;
  ColGrid.AutoDelete := True;
  ColGrid.AutoInsert := True;
  ColGrid.ExcelStyle := True;
  //ColGrid.OnFinishEditCR := OnFinishEdit;
  GB.EndInitGrid;
end;

procedure TFormGrid.DisposeGrid;
begin
  GB.DisposeGrid;
  ColBO := nil;
  Node := nil;
  ColGrid := nil;
end;

procedure TFormGrid.LoadBtnClick(Sender: TObject);
var
  fn: string;
  SL: TStringList;
begin
  fn := Main.FolderInfo.TracePath + '_AnimationData.txt';
  if FileExists(fn) then
begin
    ColBO.CurrentRow := nil;
    SL := TStringList.Create;
    SL.LoadFromFile(fn);
//    BO.RestoreFromSL(SL);
    SL.Free;
    ColGrid.ShowData;
  end;
end;

procedure TFormGrid.SaveBtnClick(Sender: TObject);
//var
//  b: TBackup;
//  fn: string;
begin
//  fn := Main.FolderInfo.TracePath + '_AnimationData.txt';
//  b := TBackup.Create;
//  b.OnBackup := BO.BackupAthletes;
//  try
//    b.Backup(fn);
//  finally
//    b.Free;
//  end;
end;

procedure TFormGrid.SetIsTracking(const Value: Boolean);
begin
  FIsTracking := Value;
  UpdateTracking;
end;

procedure TFormGrid.SetOnProductionEvent(const Value: TRecorderEvent);
begin
  FOnProductionEvent := Value;
end;

procedure TFormGrid.TrackBtnClick(Sender: TObject);
begin
  ToggleTracking;
end;

procedure TFormGrid.AddBtnClick(Sender: TObject);
var
  cl: TAnimationRowCollection;
begin
  cl := Node.AnimationRowCollection;
  cl.Add;
  UpdateGrid;
end;

procedure TFormGrid.DelBtnClick(Sender: TObject);
begin
  ColGrid.DeleteRowCollectionItem;
end;

procedure TFormGrid.RemoveBtnClick(Sender: TObject);
var
  cl: TAnimationRowCollection;
begin
  cl := Node.AnimationRowCollection;
  if cl.Count > 0 then
  begin
    cl.Delete(cl.Count-1);
    UpdateGrid;
  end;
end;

procedure TFormGrid.UpdateBtnClick(Sender: TObject);
begin
  if Assigned(ColGrid) then
    ColGrid.UpdateAll;
end;

procedure TFormGrid.ClearBtnClick(Sender: TObject);
begin
  if Assigned(ColGrid) then
  begin
    Node.AnimationRowCollection.Clear;
    ColGrid.UpdateAll;
  end;
end;

procedure TFormGrid.UpdateGrid;
begin
  if Assigned(ColGrid) then
    ColGrid.UpdateAll;
end;

function TFormGrid.GetCollection: TAnimationRowCollection;
begin
  result := Node.AnimationRowCollection;
end;

procedure TFormGrid.ToggleTracking;
begin
  IsTracking := not IsTracking;
end;

procedure TFormGrid.UpdateTracking;
begin
//  if IsTracking then
//    TrackBtn.Text := 'Tracking'
//  else
//    TrackBtn.Text := 'Tracking Off';
end;

procedure TFormGrid.GoBtnClick(Sender: TObject);
begin
  //Main.WriteScript0(Memo);
  LocalGO;
end;

procedure TFormGrid.LocalGO;
var
  i: Integer;
  cl: TAnimationRowCollection;
  cr: TAnimationRowCollectionItem;
begin
  Memo.BeginUpdate;
  Memo.Clear;
  if Assigned(OnProductionEvent) then
  begin
    cl := Node.AnimationRowCollection;
    if cl.Count > 0 then
    begin
      OnProductionEvent('NS', 0);
      for i := 0 to cl.Count-1 do
      begin
        cr := cl.Items[i];
        OnProductionEvent('NE', 0);
        OnProductionEvent('PA', cr.Param);

        if cr.StartValue <> StartValueDefault then
          OnProductionEvent('VA', cr.StartValue);
        if cr.StopValue <> StopValueDefault then
          OnProductionEvent('VE', cr.StopValue);
        if cr.Duration <> DurationDefault then
          OnProductionEvent('DU', cr.Duration);
        if cr.AutoReverse <> AutoReverseDefault then
          OnProductionEvent('AR', cr.AutoReverse);
        if cr.Loop <> LoopDefault then
          OnProductionEvent('LP', cr.Loop);
        if cr.FromCurrent <> FromCurrentDefault then
          OnProductionEvent('FC', cr.FromCurrent);
        if cr.AnimationType <> AnimationTypeDefault then
          OnProductionEvent('AT', cr.AnimationType);
        if cr.InterpolationType <> InterpolationTypeDefault then
          OnProductionEvent('IT', cr.InterpolationType);
      end;
      OnProductionEvent('GO', 0);
    end;
  end;
  Memo.EndUpdate;
end;

procedure TFormGrid.OnFinishEdit(cr: TBaseRowCollectionItem);
var
  t: TAnimationRowCollectionItem;
  cp: TBaseColProp;
  c, r: Integer;
begin
  t := cr as TAnimationRowCollectionItem;
  if t <> nil then
  begin
    if (t.Param = FParam)
      and (t.StopValue <> FStopValue) then
    begin
      if t.ru.AnimationRowCollection.Count = 1 then
        GoBtnClick(nil);
    end;
    FParam := t.Param;
    FStopValue := t.StopValue;
    cp := ColGrid.ColsActive.ByName['col_Stop'];
    if cp <> nil then
    begin
      c := cp.Index;
      r := t.Index + 1;
      GB.Grid.Cells[c, r] := IntToStr(t.StopValue);
    end;
  end;
end;

procedure TFormGrid.OnTrackEvent(fp: TFederParam; pv: Integer);
var
  param, start, stop: Integer;
begin
  param := TFederUtils.GetParamInt(fp);
  stop := pv;
  start := 1;
  OnTrackEvent(param, start, stop);
end;

procedure TFormGrid.OnTrackEvent(fmk: TFederMessageKind; mv: Integer);
var
  param, start, stop: Integer;
begin
  param := 0;
  stop := Integer(fmk);
  start := mv;
  OnTrackEvent(param, start, stop);
end;

procedure TFormGrid.OnTrackEvent(p, start, stop: Integer);
var
  cl: TAnimationRowCollection;
  cr: TAnimationRowCollectionItem;
begin
  cl := Collection;
  if IsTracking then
  begin
    if (p = 0) and (stop = 12) then
    begin
      cl.Clear;
      FRotation := Main_FederMousepad_ModelRotation;
    end;

    if p in [24..26] then
    begin
      TrackAngle(p, stop);
    end
    else
    begin
      cr := cl.Add;
      cr.Param := p;
      cr.StopValue := stop;
      cr.StartValue := start;
    end;
    UpdateGrid;
  end;
end;

function TFormGrid.NormalizeAngle(const Angle: Integer): Integer;
begin
  result := Angle - (Angle div 360) * 360;
  if result < -180 then
    result := Result + 360;
end;

procedure TFormGrid.Rotate(p, s, ad: Integer);
var
  t: Integer;
  Stop1, Start2: Integer;
  cr: TAnimationRowCollectionItem;
  RotationSplitNeeded: Boolean;
begin
  t := NormalizeAngle(s);
  if ad < 0 then
  begin
    RotationSplitNeeded := t <> s;
    Stop1 := -180;
    Start2 := 180;
  end
  else
  begin
    RotationSplitNeeded := t <> s;
    Stop1 := 360;
    Start2 := 180;
  end;

  if RotationSplitNeeded then
  begin
    cr := Collection.Add;
    cr.Param := p;
    cr.AutoReverse := 0;
    cr.FromCurrent := 0;
    cr.StartValue := s;
    cr.StopValue := Stop1;
    cr.InterpolationType := Integer(TInterpolationType.Linear);

    cr := Collection.Add;
    cr.Param := p;
    cr.AutoReverse := 0;
    cr.FromCurrent := 0;
    cr.StartValue := Start2;
    cr.StopValue := Round(t);
    cr.InterpolationType := Integer(TInterpolationType.Linear);
  end
  else
  begin
    cr := Collection.Add;
    cr.Param := p;
    cr.StopValue := Round(t);
    cr.InterpolationType := Integer(TInterpolationType.Linear);
  end;
end;

procedure TFormGrid.TrackAngle(p, t: Integer);
var
  d: single;
  p2: Integer;
begin
  case p of
    24:
    begin
      d := FRotation.X-t;
      FRotation.X := t;
      p2 := 25;
    end;
    25:
    begin
      d := FRotation.Y-t;
      FRotation.Y := t;
      p2 := 24;
   end;
    26:
    begin
      d := FRotation.Z-t;
      FRotation.Z := t;
      p2 := 26;
    end
    else
    begin
      d := 0;
      p2 := 0;
    end;
  end;

  AngleDiff := Round(d);
  AngleChanged := Abs(AngleDiff) > 1;
  AngleValue := NormalizeAngle(t);

  if AngleChanged then
    Rotate(p2, AngleValue, AngleDiff);

  ShowRotation;
end;

function TFormGrid.ShowRotation: string;
var
  ft: string;
  fs: string;
begin
  ft := '%.2f';
  fs := Format('RX %s RY %s RZ %s', [ft, ft, ft]);
  result := Format(fs, [
  FRotation.X,
  FRotation.Y,
  FRotation.Z
  ]);
  //Label1.Caption := result;
end;

end.
