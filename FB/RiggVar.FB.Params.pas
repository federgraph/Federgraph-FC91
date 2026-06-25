unit RiggVar.FB.Params;

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
  RiggVar.FB.Classes,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Model;

type
  TParamManager = class;

  TParamCycle = class
  private
    FParam: TFederParam;
    FCount: Integer;
    FChar: Char;
    FIndex: Integer;
    function GetCurrent: TFederParam;
    function GetParamManager: TParamManager;
  protected
    procedure ChangeParam(Value: Integer);
  public
    constructor Create(AParam: TFederParam; ACount: Integer; AChar: Char);
    procedure Previous;
    procedure Next;
    property Current: TFederParam read GetCurrent;
    property ParamManager: TParamManager read GetParamManager;
  end;

  TParamManager = class
  private
    FCycleI: TParamCycle;
    FCycleJ: TParamCycle;
    FCycleK: TParamCycle;
    FCycleL: TParamCycle;
    FCycleO: TParamCycle;
    FCycleR: TParamCycle;
    FCycleT: TParamCycle;
    FCycleU: TParamCycle;
    FCycleW: TParamCycle;
    FCycleX: TParamCycle;
    FCycleY: TParamCycle;
    FCycleZ: TParamCycle;

    FSavedParam: TFederParam;
    FParam: TFederParam;
    FCurrentCycle: char;

    IndexF: Integer;
    IndexC: Integer;
    IndexG: Integer;
    IndexW: Integer;

    FOnChangeParam: TNotifyEvent;

    procedure CycleParam;

    procedure SetOnChangeParam(const Value: TNotifyEvent);
    function GetCurrentIndex: Integer;
    function GetCurrentCaption: string;
    function GetIsPseudoParam: Boolean;
    function GetFederModel: TFederModel;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ResetCycle;

    procedure CycleC;
    procedure CycleG;
    procedure CycleIP;
    procedure CycleIM;
    procedure CycleJP;
    procedure CycleJM;
    procedure CycleK;
    procedure CycleL;
    procedure CycleO;
    procedure CycleR;
    procedure CycleT;
    procedure CycleU;
    procedure CycleWM;
    procedure CycleWP;
    procedure CycleX;
    procedure CycleY;
    procedure CycleZ;

    procedure CycleParamPlus;
    procedure CycleParamMinus;

    procedure ToggleFlag;

    function GetItemCaption(fp: TFederParam): string;
    procedure ChangeParam(fp: TFederParam);

    property OnChangeParam: TNotifyEvent read FOnChangeParam write SetOnChangeParam;

    property CurrentIndex: Integer read GetCurrentIndex;
    property CurrentParam: TFederParam read FParam write FParam;
    property CurrentCaption: string read GetCurrentCaption;
    property CurrentCycle: char read FCurrentCycle write FCurrentCycle;

    property IsPseudoParam: Boolean read GetIsPseudoParam;

    property FederModel: TFederModel read GetFederModel;
  end;

implementation

uses
  RiggVar.FB.Equation,
  RiggVar.App.Main;

constructor TParamManager.Create;
begin
  FCycleI := TParamCycle.Create(fp0, 10, 'i');
  FCycleJ := TParamCycle.Create(fpbpa, 2, 'j');
  FCycleK := TParamCycle.Create(fpk1, 4, 'k');
  FCycleL := TParamCycle.Create(fpl1, 4, 'l');
  FCycleO := TParamCycle.Create(fpox, 3, 'o');
  FCycleR := TParamCycle.Create(fprx, 3, 'r');
  FCycleT := TParamCycle.Create(fpt1, 2, 't');
  FCycleU := TParamCycle.Create(fpbcd, 2, 'u');
  FCycleW := TParamCycle.Create(fpbpx, 2, 'w');
  FCycleX := TParamCycle.Create(fpx1, 4, 'x');
  FCycleY := TParamCycle.Create(fpy1, 4, 'y');
  FCycleZ := TParamCycle.Create(fpz1, 4, 'z');

  FParam := fpL;
  FSavedParam := FParam;
end;

destructor TParamManager.Destroy;
begin
  FCycleI.Free;
  FCycleJ.Free;
  FCycleK.Free;
  FCycleL.Free;
  FCycleO.Free;
  FCycleR.Free;
  FCycleT.Free;
  FCycleU.Free;
  FCycleW.Free;
  FCycleX.Free;
  FCycleY.Free;
  FCycleZ.Free;

  inherited;
end;

procedure TParamManager.CycleIP;
begin
  FCycleI.Next;
end;

procedure TParamManager.CycleIM;
begin
  FCycleI.Previous;
end;

procedure TParamManager.CycleJP;
begin
  FCycleJ.Next;
end;

procedure TParamManager.CycleJM;
begin
  FCycleJ.Previous;
end;

procedure TParamManager.CycleK;
begin
  FCycleK.Next;
end;

procedure TParamManager.CycleL;
begin
  FCycleL.Next;
end;

procedure TParamManager.CycleO;
begin
  FCycleO.Next;
end;

procedure TParamManager.CycleU;
begin
  FCycleU.Next;
end;

procedure TParamManager.CycleWP;
begin
  FCycleW.Next;
end;

procedure TParamManager.CycleWM;
begin
  FCycleW.Previous;
end;

procedure TParamManager.CycleX;
begin
  FCycleX.Next;
end;

procedure TParamManager.CycleY;
begin
  FCycleY.Next;
end;

procedure TParamManager.CycleZ;
begin
  FCycleZ.Next;
end;

procedure TParamManager.CycleT;
begin
  FCycleT.Next;
end;

procedure TParamManager.CycleR;
begin
  FCycleR.Next;
end;

procedure TParamManager.CycleC;
begin
  if CurrentCycle = 'c' then
    Inc(IndexC);
  if (IndexC < 1) then
    IndexC := 1;
  if IndexC > 3 then
    IndexC := 1;
  case IndexC of
    1: ChangeParam(fptx);
    2: ChangeParam(fpty);
    3: ChangeParam(fpcz);
  end;
  CurrentCycle := 'c';
end;

procedure TParamManager.CycleG;
begin
  if CurrentCycle = 'g' then
    Inc(IndexG);
  if (IndexG < 1) then
    IndexG := 1;
  if IndexG > 3 then
    IndexG := 1;
  case IndexG of
    1: ChangeParam(fpAttenuation);
    2: ChangeParam(fpGrenze);
    3: ChangeParam(fpRange);
  end;
  CurrentCycle := 'g';
end;

procedure TParamManager.CycleParamPlus;
begin
  Inc(IndexW);
  if IndexW > 9 then
    IndexW := 1;
  CycleParam;
  CurrentCycle := ' ';
end;

procedure TParamManager.CycleParamMinus;
begin
  Dec(IndexW);
  if IndexW < 1 then
    IndexW := 9;
  CycleParam;
  CurrentCycle := ' ';
end;

procedure TParamManager.CycleParam;
begin
  case IndexW of
    1: ChangeParam(fpt1);
    2: ChangeParam(fpt2);
    3: ChangeParam(fpl3);
    4: ChangeParam(fpk3);
    5: ChangeParam(fpox);
    6: ChangeParam(fpoy);
    7: ChangeParam(fpAttenuation);
    8: ChangeParam(fpGrenze);
    9: ChangeParam(fpRange);
  end;
end;

function TParamManager.GetCurrentCaption: string;
begin
  result := GetItemCaption(FParam);
end;

function TParamManager.GetCurrentIndex: Integer;
begin
  result := TFederUtils.GetParamIndex(FParam);
end;

function TParamManager.GetFederModel: TFederModel;
begin
  result := Main.FederModel;
end;

procedure TParamManager.SetOnChangeParam(const Value: TNotifyEvent);
begin
  FOnChangeParam := Value;
end;

function TParamManager.GetIsPseudoParam: Boolean;
begin
  result := false;
  case FParam of
    fps: result := True;
  end;
end;

function TParamManager.GetItemCaption(fp: TFederParam): string;
begin
  case fp of
    fpL: result := 'L';
    fpK: result := 'K';
    fpox: result := 'ox';
    fpoy: result := 'oy';
    fpoz: result := 'oz';
    fpz: result := 'Z';
    fpAttenuation: result := 'A';
    fpGrenze: result := 'G';
    fpRange: result := 'R';
    fpT: result := 'T';
    fps: result := 's';
    fpt1: result := 't1';
    fpt2: result := 't2';
    fpt3: result := 't3';
    fpt4: result := 't4';
    fptrt: result := 'trt';
    fptrx: result := 'trx';
    fptry: result := 'try';

    fpBandWidth:
    begin
      case Main.BandWidthOption of
        bwAbsolute: result := cParamBandWidthA;
        bwRelative: result := cParamBandWidthR;
        bwContour: result := cParamBandWidthC;
        else
          result := cParamBandWidth;
      end;
    end;

    else
      result := TFederUtils.GetParamCaption(fp);
  end;
end;

procedure TParamManager.ChangeParam(fp: TFederParam);
begin
  if (fp = fpPan) and (FParam = fpPan) then
  begin
    fp := FSavedParam;
  end;

  if fp <> fpPan then
   FSavedParam := fp;

  FParam := fp;
  Main.CurrentLight := 0;
  Main.CurrentCoord := 0;
  Main.FederModel.ChangingParam := True;
  if Assigned(OnChangeParam) then
    OnChangeParam(nil);
  Main.FederModel.ChangingParam := False;
end;

procedure TParamManager.ToggleFlag;
var
  M: TMain;
begin
  M := Main;
  if FCurrentCycle = 'f' then
  begin
    if M <> nil then
    case IndexF of
      1: M.PlusCap := not M.PlusCap;
      2: M.MinusCap := not M.MinusCap;
      3: M.Bigmap := not M.Bigmap;
      4: M.Gleich := not M.Gleich;
      5: M.Vorzeichen := not M.Vorzeichen;
      6: M.OpenMesh := not M.OpenMesh;
      7: M.PolarMesh := not M.PolarMesh;
      8: M.SolutionMode := not M.SolutionMode;
    end;
  end;
end;

procedure TParamManager.ResetCycle;
begin
  if CurrentParam <> fpt1 then
    FCycleT.FIndex := FCycleT.FCount
  else
    FCycleT.FIndex := 1;
end;

{ TParamCycle }

function TParamCycle.GetParamManager: TParamManager;
begin
  result := Main.ParamManager;
end;

procedure TParamCycle.ChangeParam(Value: Integer);
begin
  ParamManager.ChangeParam(Current);
end;

constructor TParamCycle.Create(AParam: TFederParam; ACount: Integer; AChar: Char);
begin
  FIndex := 1;
  FCount := 1;
  FParam := AParam;
  if ACount > 1 then
    FCount := ACount;
  FChar := AChar;
end;

function TParamCycle.GetCurrent: TFederParam;
begin
  result := TFederParam(Integer(FParam) + FIndex - 1);
end;

procedure TParamCycle.Next;
begin
  if ParamManager.CurrentCycle = FChar then
    Inc(FIndex);
  if (FIndex < 1) then
    FIndex := 1;
  if FIndex > FCount then
    FIndex := 1;
  ChangeParam(FIndex);
  ParamManager.CurrentCycle := FChar;
end;

procedure TParamCycle.Previous;
begin
  if ParamManager.CurrentCycle = FChar then
    Dec(FIndex);
  if (FIndex < 1) then
    FIndex := FCount;
  if FIndex > FCount then
    FIndex := FCount;
  ChangeParam(FIndex);
  ParamManager.CurrentCycle := FChar;
end;

end.

