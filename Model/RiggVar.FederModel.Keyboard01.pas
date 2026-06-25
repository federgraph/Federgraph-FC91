unit RiggVar.FederModel.Keyboard01;

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
  System.Classes,
  System.UITypes,
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionKeys;

type
  TFederKeyboard01 = class(TFederKeyboard)
  public
    constructor Create;
    function KeyDownAction(var Key: Word; var KeyChar: WideChar; Shift: TShiftState): TFederAction; override;
    function KeyUpAction(var Key: Word; var KeyChar: WideChar; Shift: TShiftState): TFederAction; override;
  end;

implementation

{ TFederKeyboard01 }

constructor TFederKeyboard01.Create;
begin
  inherited;
  TestName := 'Keyboard';
end;

function TFederKeyboard01.KeyDownAction(var Key: Word; var KeyChar: WideChar; Shift: TShiftState): TFederAction;
begin
  result := faNoop;
end;

function TFederKeyboard01.KeyUpAction(var Key: Word; var KeyChar: WideChar; Shift: TShiftState): TFederAction;
begin
  { ok, only one mapping can be shown, there may be several }

  result := faNoop;

  if ssCtrl in Shift then
  begin
    if Key = vkC then
      result := faCopy
    else if Key = vkD then
      result := faCopyScreenshot
    else if Key = vkV then
      result := faPaste
    else if Key = vkL then
      result := faLoad
    else if Key = vkS then
      result := faSave
    else if Key = vkO then
      result := faOpen

    else if Key = vkLeft then
//      result := faRotYP
    else if Key = vkRight then
//      result := faRotYM
    else if Key = vkUp then
//      result := faRotXP
    else if Key = vkDown then
//      result := faRotXM
    else if KeyChar = ' ' then
      result := faLabelBatchM
    else if Key = vkSpace then
      result := faLabelBatchM
    else if Key = vkEscape then
    begin
      result := faNoop;
      { this is a Windows 8 shortcut (toggle between Startscreen and Desktop) }
    end
  end

  else
  begin

    if Key = vkLeft then
    begin
      if ssShift in Shift then
        result := faWheelLeft
      else
        result := faSampleM
    end
    else if Key = vkRight then
    begin
      if ssShift in Shift then
        result := faWheelRight
      else
        result := faSampleP
    end

    else if Key = vkUp then
    begin
      if ssShift in Shift then
        result := faWheelUp
      else
        result := faHubP
    end
    else if Key = vkDown then
    begin
      if ssShift in Shift then
        result := faWheelDown
      else
        result := faHubM
    end

    else if Key = vkPrior then
      result := faHubP
    else if Key = vkNext then
      result := faHubM

    else if Key = vkHome then
      result := faHelpHome
    else if Key = vkEnd then

    else if Key = vkEscape then
    begin
      if ssShift in Shift then
        result := faReset
      else
        result := faResetRotation;
    end

    else if KeyChar = '1' then
      result := faPlot1
    else if KeyChar = '2' then
      result := faPlot2
    else if KeyChar = '3' then
      result := faPlot3
    else if KeyChar = '4' then
      result := faPlot4
    else if KeyChar = '5' then
      result := faPlot5
    else if KeyChar = '6' then
      result := faPlot6
    else if KeyChar = '7' then
      result := faPlot7
    else if KeyChar = '8' then
      result := faPlot8
    else if KeyChar = '9' then
      result := faPlot9
    else if KeyChar = '0' then
      result := faPlot0

    else if KeyChar = '!' then
      result := faParamT1
    else if KeyChar = '"' then
      result := faParamT2
    else if KeyChar = '§' then
      result := faParamT3
    else if KeyChar = '$' then
      result := faParamT4
    else if KeyChar = '%' then
      result := faLabelBatchM
    else if KeyChar = '&' then
      result := faLabelBatchP

    else if KeyChar = '*' then
      result := faActionPageM
    else if KeyChar = '+' then
      result := faActionPageP
    else if KeyChar = '#' then
      result := faBitmapEscape
    else if KeyChar = '=' then
      result := faToggleGleich
    else if KeyChar = '?' then
      result := faHelpHome
    else if KeyChar = '/' then
//      result := faNextSlice
    else if KeyChar = '°' then
//      result := faSliceOff

    else if KeyChar = '~' then
      result := faOpenMesh
    else if KeyChar = 'µ' then
      result := faPolarMesh
    else if KeyChar = '@' then
      result := faParamT1
    else if KeyChar = '€' then
      result := faParamT2
    else if KeyChar = '£' then
      result := faParamT3
    else if KeyChar = '¥' then
      result := faParamT4

    else if KeyChar = '²' then
      result := faResetPosition
    else if KeyChar = '³' then
      result := faResetZoom

    else if KeyChar = '^' then
      result := faActionPageE
    else if KeyChar = '`' then
       result := faParamBahnAngle
    else if KeyChar = '´' then
      result := faParamBahnRadius
    else if KeyChar = '''' then
      result := faCycleT
    else if KeyChar = '|' then
//      result := faParamSliceHeight

    else if KeyChar = '{' then
      result := faMeshSize32
    else if KeyChar = '}' then
      result := faMeshSize256
    else if KeyChar = '[' then
      result := faMeshSize512
    else if KeyChar = ']' then
//      result := faMeshSize1024
    else if KeyChar = '(' then
      result := faMeshSize64
    else if KeyChar = ')' then
      result := faMeshSize128
    else if KeyChar = 'ß' then
      result := faMeshSize256

    else if KeyChar = 'a' then
      result := faActionPageS
    else if KeyChar = 'A' then
      result := faParamA

    else if KeyChar = 'b' then
      result := faCycleBitmapP
    else if KeyChar = 'B' then
      result := faCycleBitmapM

    else if KeyChar = 'c' then
      result := faCycleColorSchemeP
    else if KeyChar = 'C' then
      result := faCycleColorSchemeM

    else if KeyChar = 'd' then

    else if KeyChar = 'D' then
      result := faParamTRT

    else if KeyChar = 'e' then
      result := faCyclePlotP
    else if KeyChar = 'E' then
      result := faCyclePlotM

{$ifdef debug}
    else if KeyChar = 'f' then
//      result := faFormatIPhonePortrait
    else if KeyChar = 'F' then
//      result := faFormatLandscape
{$else}
    else if KeyChar = 'f' then
      result := faToggleMoveMode
    else if KeyChar = 'F' then
      result := faPlot10
{$endif}

    else if KeyChar = 'g' then
      result := faLinearMove
    else if KeyChar = 'G' then
      result  := faParamG

    else if KeyChar = 'h' then
      result := faBlindRingP
    else if KeyChar = 'H' then
      result := faBlindRingM

    else if KeyChar = 'i' then
      result := faWheelRight
    else if KeyChar = 'I' then
      result := faWheelUp

    else if KeyChar = 'j' then
      result := faWheelLeft
    else if KeyChar = 'J' then
      result := faWheelDown

    else if KeyChar = 'k' then
      result := faCycleK
    else if KeyChar = 'K' then
      result := faParamK

    else if KeyChar = 'l' then
      result := faCycleL
    else if KeyChar = 'L' then
      result := faParamL

    else if KeyChar = 'm' then
      result := faToggleMCap
    else if KeyChar = 'M' then
      result := faReset

    else if KeyChar = 'n' then
      result := faRandomBlack
    else if KeyChar = 'N' then
      result := faRandomWhite

    else if KeyChar = 'o' then
      result := faCycleO
    else if KeyChar = 'O' then
      result := faToggleProbe

    else if KeyChar = 'p' then
      result := faTogglePCap
    else if KeyChar = 'P' then
      result := faPolarMesh

    else if KeyChar = 'q' then
      result := faParamTRX
    else if KeyChar = 'Q' then
      result := faParamTRY

    else if KeyChar = 'r' then
      result := faReducedMesh
    else if KeyChar = 'R' then
      result := faParamR

    else if KeyChar = 's' then
      result := faCycleRingP
    else if KeyChar = 'S' then
      result := faCycleRingM

    else if KeyChar = 't' then
      result := faCycleT
    else if KeyChar = 'T' then
      result := faParamT

    else if KeyChar = 'u' then
      result := faCycleU
    else if KeyChar = 'U' then
      result := faToggleLux

    else if KeyChar = 'v' then
      result := faLabelBatchM
    else if KeyChar = 'V' then
//      result := faToggleViewType

    else if KeyChar = 'w' then
//      result := faCycleWP
    else if KeyChar = 'W' then
//      result := faCycleWM

    else if KeyChar = 'x' then
      result := faCycleX
    else if KeyChar = 'X' then
//      result := faPlotFigureP

    else if KeyChar = 'y' then
      result := faCycleY
    else if KeyChar = 'Y' then
//      result := faPlotFigureM

    else if KeyChar = 'z' then
      result := faCycleZ
    else if KeyChar = 'Z' then
      result := faParamZ

    else if KeyChar = ' ' then
      result := faLabelBatchP
    else if Key = vkSpace then
        result := faLabelBatchP

    else if Key = vkDelete then
      result := faTextureClear

    else if Key = vkReturn then
      result := faToggleShowEdges

    else if Key = vkF1 then
      result := faScene1
    else if Key = vkF2 then
      result := faScene2
    else if Key = vkF3 then
      result := faScene3
    else if Key = vkF4 then
      result := faScene4
    else if Key = vkF5 then
      result := faToggleMarker

    else if KeyChar = ';' then
      result := faLevelM
    else if KeyChar = ':' then
      result := faLevelP
    else if KeyChar = '_' then
      result := faParamCapValue

    else if KeyChar = ',' then
//      result := faParamSliceHeight
    else if KeyChar = '.' then
      result := faParamCapValue
    else if KeyChar = '-' then
      result := faToggleShirtColor

    else if KeyChar = 'ä' then
      result := faStepRXM
    else if KeyChar = 'Ä' then
      result := faStepRXP

    else if KeyChar = 'ö' then
      result := faStepRYM
    else if KeyChar = 'Ö' then
      result := faStepRYP

    else if KeyChar = 'ü' then
      result := faStepRZM
    else if KeyChar = 'Ü' then
      result := faStepRZP

    else if KeyChar = '<' then
      result := faStepCZM
    else if KeyChar = '>' then
      result := faStepCZP

  end;
end;

end.
