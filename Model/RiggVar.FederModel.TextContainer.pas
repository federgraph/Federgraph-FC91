unit RiggVar.FederModel.TextContainer;

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
  System.UITypes,
  FMX.Types,
  FMX.Objects,
  RiggVar.FederModel.TouchBase;

type
  TTextContainer = class
  private
    FText: TText;
    FMinWidth: single;
    procedure SetText(const Value: string);
    function GetText: string;
    procedure SetVisible(const Value: Boolean);
    function GetVisible: Boolean;
  public
    Docked: Boolean;
    Shape: TRectangle;
    constructor Create;
    procedure Init;
    procedure UpdateShape;
    property Text: string read GetText write SetText;
    property Visible: Boolean read GetVisible write SetVisible;
    property TextComponent: TText read FText;
  end;

implementation

uses
  RiggVar.App.Main;

{ TTextContainer }

constructor TTextContainer.Create;
begin
  FMinWidth := 380;
end;

function TTextContainer.GetText: string;
begin
  if Assigned(FText) then
    result := FText.Text
  else
    result := '';
end;

function TTextContainer.GetVisible: Boolean;
begin
  if Assigned(Shape) then
    result := Shape.Visible
  else
    result := False;
end;

procedure TTextContainer.Init;
begin
  Shape := TRectangle.Create(TFederTouchBase.OwnerComponent);
  Shape.Parent := TFederTouchBase.ParentObject;
  Shape.CornerType := TCornerType.Round;

  UpdateShape;

  Shape.XRadius := BtnBorderRadius;
  Shape.YRadius := BtnBorderRadius;
  Shape.Opacity := 1.0;
  Shape.HitTest := False;
  Shape.Fill.Color := MainVar.ColorScheme.claEquationFill;
  Shape.Stroke.Color := BtnBorderColor;
  Shape.Stroke.Thickness := BtnBorderWidth;

  FText := TText.Create(TFederTouchBase.OwnerComponent);
  FText.Parent := Shape;
  FText.WordWrap := False;
  FText.Align := TAlignLayout.Client;
//  FText.HorzTextAlign := TTextAlign.Leading;
  FText.VertTextAlign := TTextAlign.Leading;
  FText.Font.Size := 16;
{$ifdef MSWINDOWS}
  FText.Font.Family := 'Courier New';
  FText.Font.Style := FText.Font.Style + [TFontStyle.fsBold];
{$endif}
{$ifdef OSX}
  FText.Font.Family := 'CourierNewPSMT';
{$endif}
{$ifdef IOS}
  FText.Font.Family := 'Courier';
{$endif}
{$ifdef ANDROID}
  FText.Font.Family := 'monospace';
{$endif}

  FText.Opacity := 0.5;
  FText.Color := MainVar.ColorScheme.claEquationText;
  FText.Text := '';
  FText.HitTest := False;
end;

procedure TTextContainer.SetText(const Value: string);
begin
  if Assigned(FText) then
    FText.Text := Value;
end;

procedure TTextContainer.SetVisible(const Value: Boolean);
begin
  if Assigned(Shape) then
    Shape.Visible := Value;
end;

procedure TTextContainer.UpdateShape;
begin
  if Assigned(Shape) then
  begin
    if MainVar.ClientHeight < 6 * MainVar.Raster then
    begin
      Shape.Position.Y := 2 * MainVar.Raster;
      Shape.Height := 5 * MainVar.Raster;
      Shape.Visible := False;
      Docked := False;
    end
    else
    begin
      Shape.Position.Y := 2 * MainVar.Raster;
      Shape.Height := 7 * MainVar.Raster;
      if Main.IsLandscape then
      begin
        Shape.Width := MainVar.ClientWidth - (2 + 5) * MainVar.Raster;
        if Shape.Width > FMinWidth then
        begin
          Shape.Visible := True;
          Shape.Position.X := MainVar.ClientWidth - MainVar.Raster - FMinWidth;
          Shape.Width := FMinWidth;
          Docked := False; // show top-right-corner Buttons in TouchMenu
        end
        else if Shape.Width > FMinWidth - (5 - DockStartX) * MainVar.Raster then
        begin
          Shape.Visible := True;
          Shape.Position.X := (1 + DockStartX) * MainVar.Raster;
          Shape.Width := MainVar.ClientWidth - (2 + DockStartX) * MainVar.Raster;
          Docked := True; // hide top-right-corner Buttons in TouchMenu
        end
        else
        begin
          Shape.Visible := False;
          Docked := False;
        end;
      end
      else // if IsPortrait then
      begin
        if Main.ViewportSizeX = 1 then
          Shape.Position.Y := 7 * MainVar.Raster;
        Shape.Width := MainVar.ClientWidth - (1 + DockStartX) * MainVar.Raster;
        if Shape.Width < FMinWidth then
        begin
          Shape.Visible := False;
          Docked := False;
        end
        else
        begin
          Shape.Visible := True;
          Docked := True;
          Shape.Position.X := (1 + DockStartX) * MainVar.Raster;
          Shape.Width := MainVar.ClientWidth - (2 + DockStartX) * MainVar.Raster;
        end;
      end;
    end;
  end;
end;

end.
