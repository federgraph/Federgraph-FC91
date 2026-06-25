unit RiggVar.FB.ActionGroups;

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
  System.Generics.Collections,
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionGroup;

type
  TActionGroupList = class(TList<TActionGroup>)
  public
    GroupNames: TStrings;
    constructor Create;
    destructor Destroy; override;
    procedure AddSpecial(const Value: TActionGroup; AName: string);
    function ActionCount: Integer;
    function GetUsage: string;
    function GetGroup(fa: TFederAction): Integer;
    function GetGroupName(i: Integer): string;
  end;

implementation

{ TActionGroupList }

destructor TActionGroupList.Destroy;
begin
  GroupNames.Free;
  inherited;
end;

function TActionGroupList.ActionCount: Integer;
var
  i: Integer;
  j: Integer;
  cr: TActionGroup;
begin
  j := 0;
  for i := 0 to Count-1 do
  begin
    cr := self[i];
    j := j + Length(cr);
  end;
  result := j;
end;

procedure TActionGroupList.AddSpecial(const Value: TActionGroup; AName: string);
var
  AG: TActionGroup;
begin
  AG := Value; { because of RSP-16471, a bug in 10.1 }
  GroupNames.Add(AName);
  Add(AG);
end;

constructor TActionGroupList.Create;
begin
  inherited;

  GroupNames := TStringList.Create;

  { App }
  AddSpecial(ActionGroupEmptyAction, 'EmptyAction');
  AddSpecial(ActionGroupPages, 'Pages');
  AddSpecial(ActionGroupForms, 'Forms');
  AddSpecial(ActionGroupTouchLayout, 'TouchLayout');
  AddSpecial(ActionGroupActionMapping, 'ActionMapping');

  { Combo }
  AddSpecial(ActionGroupScene, 'Scene');
  AddSpecial(ActionGroupPlot, 'Plot');
  AddSpecial(ActionGroupFigure, 'Figure');
  AddSpecial(ActionGroupGraph, 'Graph');
  AddSpecial(ActionGroupColor, 'Color');

  { Params }
  AddSpecial(ActionGroupParam, 'Param');
  AddSpecial(ActionGroupSystemParam, 'SystemParam');
  AddSpecial(ActionGroupOffsetParam, 'OffsetParam');
  AddSpecial(ActionGroupCoordParam, 'CoordParam');
  AddSpecial(ActionGroupLuxParam, 'LuxParam');
  AddSpecial(ActionGroupParamCycle, 'ParamCycle');
  AddSpecial(ActionGroupModelParams, 'ModelParams');

  { Model }
  AddSpecial(ActionGroupModelOptions, 'ModelOptions');
  AddSpecial(ActionGroupOptionCycle, 'OptionCycle');
  AddSpecial(ActionGroupForceMode, 'ForceMode');
  AddSpecial(ActionGroupFederMode, 'FederMode');

  { Ring }
  AddSpecial(ActionGroupRingActions, 'RingActions');
  AddSpecial(ActionGroupParamBand, 'ParamBand');
  AddSpecial(ActionGroupBlindRingSelection, 'BlindRingSelection');
  AddSpecial(ActionGroupCurrentBand, 'CurrentBand');
  AddSpecial(ActionGroupBandSelection, 'BandSelection');

  { Mesh }
  AddSpecial(ActionGroupMeshMode, 'MeshMode');
  AddSpecial(ActionGroupMeshSize, 'MeshSize');
  AddSpecial(ActionGroupMeshExport, 'MeshExport');
  AddSpecial(ActionGroupMeshExportCoords, 'MeshExportCoords');
  AddSpecial(ActionGroupExporterOBJ, 'ExporterOBJ');
  AddSpecial(ActionGroupMeshFigures, 'MeshFigures');
  AddSpecial(ActionGroupVertexPulling, 'VertexPulling');
  AddSpecial(ActionGroupMeshBuilderOptions, 'MeshBuilderOptions');

  { Texture }
  AddSpecial(ActionGroupColorMix, 'ColorMix');
  AddSpecial(ActionGroupColorSwat, 'ColorSwat');

  { Light }
  AddSpecial(ActionGroupLux, 'Lux');
  AddSpecial(ActionGroupLuxMarker, 'LuxMarker');
  AddSpecial(ActionGroupLightMode, 'LightMode');
  AddSpecial(ActionGroupResetLight, 'ResetLight');

   { UI }
  AddSpecial(ActionGroupWheel, 'Wheel');
  AddSpecial(ActionGroupWheelFrequency, 'WheelFrequency');
  AddSpecial(ActionGroupColorScheme, 'ColorScheme');
  AddSpecial(ActionGroupStep, 'Step');
  AddSpecial(ActionGroupUI, 'UI');
  AddSpecial(ActionGroupLocks, 'Locks');
  AddSpecial(ActionGroupOpacity, 'Opacity');

  { View }
  AddSpecial(ActionGroupFederText, 'FederText');
  AddSpecial(ActionGroupViewParams, 'ViewParams');
  AddSpecial(ActionGroupViewParamsFC, 'ViewParamsFC');
  AddSpecial(ActionGroupParamT, 'ParamT');
  AddSpecial(ActionGroupViewFlags, 'ViewFlags');

  { Report }
  AddSpecial(ActionGroupReport, 'Report');
  AddSpecial(ActionGroupReportOptions, 'ReportOptions');

  { Copy }
  AddSpecial(ActionGroupCopyImage, 'CopyImage');
  AddSpecial(ActionGroupCopyOptions, 'CopyOptions');

  { 2D }
  AddSpecial(ActionGroupGraphOptions, 'GraphOptions');
  AddSpecial(ActionGroupBahn, 'Bahn');

  { DB }
  AddSpecial(ActionGroupExampleData, 'ExampleData');
  AddSpecial(ActionGroupRepo, 'Repo');
  AddSpecial(ActionGroupSampleNavigation, 'SampleNavigation');

  { App }
  AddSpecial(ActionGroupHelp, 'Help');

  { TouchFrame Buttons }
  AddSpecial(ActionGroupBtnLegendTablet, 'BtnLegendTablet');
  AddSpecial(ActionGroupBtnLegendPhone, 'BtnLegendPhone');
  AddSpecial(ActionGroupTouchBarLegend, 'TouchBarLegend');

  AddSpecial(ActionGroupReset, 'Reset');
  AddSpecial(ActionGroupLanguage, 'Language');
  AddSpecial(ActionGroupCopyPaste, 'CopyPaste');

  AddSpecial(ActionGroupViewOptions, 'ViewOptions');
  AddSpecial(ActionGroupBitmapCycle, 'BitmapCycle');

  { Layout }
  AddSpecial(ActionGroupLayout0, 'Layout0');
  AddSpecial(ActionGroupLayout1, 'Layout1');
  AddSpecial(ActionGroupLayout2, 'Layout2');
  AddSpecial(ActionGroupLayout3, 'Layout3');
  AddSpecial(ActionGroupLayout4, 'Layout4');
  AddSpecial(ActionGroupLayout5, 'Layout5');
  AddSpecial(ActionGroupLayout6, 'Layout6');
  AddSpecial(ActionGroupLayout7, 'Layout7');
  AddSpecial(ActionGroupLayout8, 'Layout8');
  AddSpecial(ActionGroupLayout9, 'Layout9');

  { Nav }
  AddSpecial(ActionGroupMenuNav, 'MenuNav');

  { Bambu }
  AddSpecial(ActionGroupFigureSize, 'FigureSize');
  AddSpecial(ActionGroupEyeSize, 'EyeSize');
  AddSpecial(ActionGroupLayerSelection, 'LayerSelection');
  AddSpecial(ActionGroupColorSelection, 'ColorSelection');
  AddSpecial(ActionGroupColorMapping, 'ColorMapping');
end;

function TActionGroupList.GetGroup(fa: TFederAction): Integer;
var
  i: Integer;
  j: Integer;
  l: Integer;
  cr: TActionGroup;
begin
  result := -1;
  for i := 0 to Count-1 do
  begin
    cr := Self.Items[i];
    l := Length(cr);
    for j := 0 to l-1 do
    begin
      if cr[j] = fa then
      begin
        result := i;
        Exit;
      end;
    end;
  end;
end;

function TActionGroupList.GetGroupName(i: Integer): string;
begin
  if (i >= 0) and (i < GroupNames.Count) and (i < Count) then
    result := GroupNames[i]
  else
    result := '';
end;

function TActionGroupList.GetUsage: string;
var
  fa: TFederAction;
  i: Integer;
  j: Integer;
  l: Integer;
  cr: TActionGroup;
  SL: TStringList;
  s1: string;
begin
  SL := TStringList.Create;
  for fa := 0 to faMax-1 do
    SL.Add(Format('%d=0', [fa]));

  s1 := '1';
  for i := 0 to Count-1 do
  begin
    cr := Self.Items[i];
    l := Length(cr);
    for j := 0 to l - 1 do
    begin
      SL.Values[IntToStr(cr[j])] := s1;
    end;
  end;

  for i := SL.Count - 1 downto 0 do
    if (SL.Values[IntToStr(i)] = '1') then
      SL.Delete(i);

  result := SL.Text;
  SL.Free;
end;

end.
