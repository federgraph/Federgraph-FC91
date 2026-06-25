unit RiggVar.FederModel.Binding;

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
  System.Classes;

type
  TFederBinding = class
  private
    FOnChangeHelp: TNotifyEvent;
    function GetCurrentHelp: string;
    procedure SetOnChangeHelp(const Value: TNotifyEvent);
  protected
    IndexH: Integer;
    SLHelp: TStringList;
    SLKeyInfo: TStringList;
    function GetLowerKeyInfo: string;
    function GetUpperKeyInfo: string;
    function GetSpecialKeyInfo: string;
    function GetMeshKeyInfo: string;
  public
    procedure InitInfoText(SL: TStrings);

    constructor Create;
    destructor Destroy; override;

    procedure GoHome;
    procedure CycleHelpPlus;
    procedure CycleHelpMinus;

    function InitGeneralScreen(SL: TStrings): string;
    function InitTouchHelp(SL: TStrings): string;
    function InitKeyboardHelp(SL: TStrings): string;
    function InitAbstract(SL: TStrings): string;

    function InitHelpStrings(SL: TStrings): string;
    function InitLowerKeys(SL: TStrings): string;
    function InitUpperKeys(SL: TStrings): string;
    function InitSpecialKeys(SL: TStrings): string;
    function InitMeshKeys(SL: TStrings): string;

    function InitAllText(SL: TStrings): string;

    property LowerKeyInfo: string read GetLowerKeyInfo;
    property UpperKeyInfo: string read GetUpperKeyInfo;
    property SpecialKeyInfo: string read GetSpecialKeyInfo;
    property MeshKeyInfo: string read GetMeshKeyInfo;

    property CurrentHelp: string read GetCurrentHelp;
    property OnChangeHelp: TNotifyEvent read FOnChangeHelp write SetOnChangeHelp;
  end;

implementation

uses
  RiggVar.App.Main;

constructor TFederBinding.Create;
begin
  SLHelp := TStringList.Create;
  SLKeyInfo := TStringList.Create;
end;

destructor TFederBinding.Destroy;
begin
  SLHelp.Free;
  SLKeyInfo.Free;
  inherited;
end;

function TFederBinding.InitAllText(SL: TStrings): string;
begin
  SL.Add('--- General Help:');
  InitGeneralScreen(SL);

  SL.Add('--- Touch Help:');
  InitTouchHelp(SL);

  SL.Add('--- Keyboard and Mouse Help:');
  InitKeyboardHelp(SL);

  SL.Add('--- Abstract:');
  InitAbstract(SL);
end;

procedure TFederBinding.InitInfoText(SL: TStrings);
begin
  SL.Add('Info about FR App');
  SL.Add('');
  SL.Add('see www.federgraph.de');

//{$ifdef MSWINDOWS}
  SL.Add('');
  SL.Add('');
  SL.Add('-     F');
  SL.Add('-    * * *');
  SL.Add('-   *   *   G');
  SL.Add('-  *     * *   *');
  SL.Add('- E - - - H - - - I');
  SL.Add('-  *     * *         *');
  SL.Add('-   *   *   *           *');
  SL.Add('-    * *     *             *');
  SL.Add('-     D-------A---------------B');
  SL.Add('-              *');
  SL.Add('-              (C) federgraph.de');
  SL.Add('-');
//{$endif}
end;

function TFederBinding.InitGeneralScreen(SL: TStrings): string;
begin
  SL.Add('');
  SL.Add('when within phone or tablet app:');
  SL.Add('');
  SL.Add('Zurück zum Hauptformular immer mit Back button !!');
  SL.Add('Back to the Main form always with back button  !!');
  SL.Add('=================================================');
  SL.Add('');
  SL.Add('Bedienkonzept, bzw. grundlegende Operationen:');
  SL.Add('- Beispiel auswählen.');
  SL.Add('- Modell ansehen: Rotation, Zoom, Panning.');
  SL.Add('- Aktuellen Parameter auswählen.');
  SL.Add('- Wert des aktuellen Parameters ändern.');
  SL.Add('- Option umschalten.');
  SL.Add('- Aktion ausführen.');
  SL.Add('');
end;

function TFederBinding.InitAbstract(SL: TStrings): string;
begin
  SL.Add('');
  if Main.IsMobile then
  begin
  SL.Add('Dies ist die mobile Variante für Phone und Tablet.');
  end;
  SL.Add('Die Applikation speichert nichts automatisch.');
  SL.Add('Nach jedem Programmstart ist alles wie vorher.');
  SL.Add('Datenaustausch kann über Zwischenablage erfolgen.');
  if Main.IsMobile then
  begin
  SL.Add('Export von Mesh-Daten für 3D-Druck nicht in dieser Version.');
  SL.Add('Mehr ist verfügbar in speziellen Versionen für Desktop.');
  end;
  SL.Add('');
  SL.Add('Weiterführende Info:');
  SL.Add('');
  SL.Add('    https://federgraph.de/FC');
  SL.Add('');
  SL.Add('    https://www.tiktok.com/@federgraph');
  SL.Add('');
end;

function TFederBinding.InitTouchHelp(SL: TStrings): string;
begin
  SL.Add('');
  SL.Add('Rotation x und y mit TouchDrag über Mitte (Bild).');
  SL.Add('Rotation z mit Touchbar oben.');
  SL.Add('Zoom mit Touchbar unten.');
  SL.Add('Panning nur in Pan-Mode (Pseudo-Parameter Pan)');
  SL.Add('- mit Touchbar links und rechts.');
  SL.Add('');
  SL.Add('Parameter-Wert NORMAL ändern mit Touchbar rechts.');
  SL.Add('Parameter-Wert GROB ändern mit Touchbar links.');
  SL.Add('');
  SL.Add('Mit tap auf button in button frame:');
  SL.Add('- Button-Frame Seite wechseln');
  SL.Add('- Sample wechseln');
  SL.Add('- Parameter auswählen');
  SL.Add('- Option umschalten');
  SL.Add('- Aktion ausführen');
  SL.Add('');
end;

function TFederBinding.InitKeyboardHelp(SL: TStrings): string;
begin
  SL.Add('');
  SL.Add('Rotation mit MouseDrag über Bild (Mitte).');
  SL.Add('- um x und y mit linker Maustaste (zwei Achsen)');
  SL.Add('- um z-Achse mit rechter Maustaste');
  SL.Add('Zoom mit Ctrl-Mausrad.');
  SL.Add('Panning mit Ctrl-MouseDrag über Mitte.');
  SL.Add('- mit touchbar links und rechts');
  SL.Add('');
  SL.Add('Parameter Wert NORMAL ändern mit Mausrad.');
  SL.Add('Parameter Wert GROB ändern mit Shift + Mausrad.');
  SL.Add('Option umschalten mit click auf button.');
  SL.Add('Aktion umschalten mit click auf button.');
  SL.Add('');
  SL.Add('Button-Frame Seite wechseln mit + oder *');
  SL.Add('Sample wechseln mit Pfeil (rechts/links)');
  SL.Add('Parameter auswählen mit "Keyboard shortcut".');
  SL.Add('Option umschalten mit "Keyboard shortcut".');
  SL.Add('("Keyboard shortcuts" werden extra aufgelistet.)');
  SL.Add('');
end;

function TFederBinding.InitHelpStrings(SL: TStrings): string;
begin
  { dies ist für sehr alte versionen von Federgraph }
  SL.Add('Rollen durch Bedienhilfe mit Tasten h/H');
  SL.Add('Text an/aus mit Leertaste');
  SL.Add('Zoom mit Ctrl Mausrad');
  SL.Add('Drehen mit linker Maustaste (zwei Achsen)');
  SL.Add('Drehen um z-Achse mit rechter Maustaste');
  SL.Add('Parameter Wert NORMAL ändern mit Mausrad');
  SL.Add('Parameter Wert GROB ändern mit Shift + Mausrad');
  SL.Add('Parameter ändern über Tastatur mit Shift + Pfeiltasten');
  SL.Add('Sample wechseln mit Pfeil (rechts/links)');
  SL.Add('Hub wechseln mit Pfeil (rechts/links)');
  SL.Add('Zurückspringen im Hilfetext mit Home-button (Pos1)');
end;

function TFederBinding.InitLowerKeys(SL: TStrings): string;
begin
  SL.Add('Taste a: Animation zum nächsten KeyFrame');
  SL.Add('Taste b: Umschalter für Textur-Faktor');
  SL.Add('Taste c: Zyklus Farbe vorwärts');
  SL.Add('Taste d: Droptarget für Texturdatei ein/aus');
  SL.Add('Taste e: Zyklus Plot vorwärts');
  SL.Add('Taste f: Zoomfaktor fein');
  SL.Add('Taste g: Zoomfaktor grob');
  SL.Add('Taste h: Zylus Hilfetext vorwärts');
  SL.Add('Taste i: animierte Rotation um horizontale Achse');
  SL.Add('Taste j: animierte Rotation um vertikale Achse');
  SL.Add('Taste k: Auswahl Parameter k (k1, k2, k3)');
  SL.Add('Taste l: Auswahl Parameter l (l1, l2, l3)');
  SL.Add('Taste m: Umschalter Begrenzung -z (MinusCap ein/aus)');
  SL.Add('Taste n: ');
  SL.Add('Taste o: Auswahl Parameter o (ox, oy, oz)');
  SL.Add('Taste p: Umschalter Begrenzung +z (PlusCap ein/aus)');
  SL.Add('Taste q: Zyklus Flag vorwärts');
  SL.Add('Taste r: Auswahl Parameter r (rx, ry, rz)');
  SL.Add('Taste s: Umschalter SolutionMode');
  SL.Add('Taste t: Zyklus Texturparameter');
  SL.Add('Taste u: ');
  SL.Add('Taste v: Vorzeichenmodus ein/aus');
  SL.Add('Taste w: Bildformat (Fenstergröße) kleiner');
  SL.Add('Taste x: Auswahl Parameter x (x1, x2, x3, x4)');
  SL.Add('Taste y: Auswahl Parameter y (y1, y2, y3, y4)');
  SL.Add('Taste z: Auswahl Parameter z (z1, z2, z3, z4)');
end;

function TFederBinding.InitUpperKeys(SL: TStrings): string;
begin
  SL.Add('Taste A: Animation Start/Stop');
  SL.Add('Taste B: Parameter Limit (Begrenzung)');
  SL.Add('Taste C: Fenster Connect');
  SL.Add('Taste D: Transition kurz');
  SL.Add('Taste E: Zyklus Plot rückwärts');
  SL.Add('Taste F: Transition lang');
  SL.Add('Taste G: Verstärkung (Gain/Attenuation)');
  SL.Add('Taste H: Umschalter Hilfetext (rückwärts)');
  SL.Add('Taste I: Umschalter Texturlock');
  SL.Add('Taste J: Umschalter Paramlock');
  SL.Add('Taste K: Konstante für alle Federn synchron');
  SL.Add('Taste L: Länge l0 für alle Federn synchron');
  SL.Add('Taste M: Fenster Memo');
  SL.Add('Taste N: Fenster Grid');
  SL.Add('Taste O: Fenster Optionen');
  SL.Add('Taste P: MakeFotoFormat');
  SL.Add('Taste Q: Zyklus Flag rückwärts');
  SL.Add('Taste R: Auswahl Parameter Range (Bereich)');
  SL.Add('Taste S: Starte Animation über alle Samples im Hub');
  SL.Add('Taste T: Auswahl Parameter T (Dreieck-Modus)');
  SL.Add('Taste U: XY-Grid und Positions-Kegel ein/aus');
  SL.Add('Taste V: Text an/aus');
  SL.Add('Taste W: Bildformat (Fenstergröße) größer');
  SL.Add('Taste X: Plotfigur runterzählen (Plot 6)');
  SL.Add('Taste Y: Plotfigur hochzählen (Plot 6)');
  SL.Add('Taste Z: Koorinate Z für alle Federn synchron');
end;

function TFederBinding.InitSpecialKeys(SL: TStrings): string;
begin
  SL.Add('F1-F5: Auswahl Modell/Gleichungssatz (Anzahl Federn)');
  SL.Add('Taste 0-9: Auswahl Plot/Funktion (z)');
  SL.Add('Shift 1-6: Auswahl Figur/Bereich (xy)');
  SL.Add('');
  SL.Add('Taste =: Option ''Gleichseitige Figur'' für T');
  SL.Add('Taste ?: Option ''Kreis'' um Punkt 3');
  SL.Add('');
  SL.Add('Taste ,: Kraft-Modus ZugDruck');
  SL.Add('Taste .: Kraft-Modus Zug');
  SL.Add('Taste -: Kraft-Modus Druck');
  SL.Add('');
  SL.Add('Taste ;: Umschalter Kraft-Modus Feder 1');
  SL.Add('Taste :: Umschalter Kraft-Modus Feder 2');
  SL.Add('Taste _: Umschalter Kraft-Modus Feder 3');
  SL.Add('');
  SL.Add('Taste <: Anzahl Federn kleiner (nur EquationN)');
  SL.Add('Taste >: Anzahl Federn größer (nur EquationN)');
  SL.Add('');
  SL.Add('Taste |: Bildformat zurücksetzen');
  SL.Add('Taste ö: Format 600 x 600');
  SL.Add('Taste ä: Format 800 x 600');
  SL.Add('Taste ü: Umschalter Schrittweite XY-Grid');
  SL.Add('');
  SL.Add('Ctrl-C: Sample-Text kopieren (Pascal-Source)');
  SL.Add('Ctrl-V: Sample-Text einfügen');
  SL.Add('Ctrl-S: Sample aktualisieren (wenn Bundle = extern)');
  SL.Add('Ctrl-L: externes Bundle vom Standardort einlesen');
  SL.Add('Ctrl-O: externes Bundle öffnen (mit Dialog)');
  SL.Add('Taste /: ');
  SL.Add('Taste *: Steuerpanel ein/aus');
  SL.Add('Space  : Text an/aus');
end;

function TFederBinding.InitMeshKeys(SL: TStrings): string;
begin
  SL.Add('( Mesh 128');
  SL.Add(') Mesh 256');
  SL.Add('[ Mesh 512');
  SL.Add('] Mesh 1024');
  SL.Add('{ Mesh 32');
  SL.Add('} Mesh 64');
  SL.Add('ß Mesh 64');
  SL.Add('');
  SL.Add('~ OpenMesh');
  SL.Add('µ PolarMesh');
  SL.Add('@ LinearMesh');
  SL.Add(': FilterMesh');
  SL.Add('; FuzzyMesh');
  SL.Add('');
  SL.Add('Del/Entf: Lösche externe Textur');
end;

procedure TFederBinding.SetOnChangeHelp(const Value: TNotifyEvent);
begin
  FOnChangeHelp := Value;
end;

function TFederBinding.GetLowerKeyInfo: string;
begin
  SLKeyInfo.Clear;
  InitLowerKeys(SLKeyInfo);
  result := SLKeyInfo.Text;
end;

function TFederBinding.GetMeshKeyInfo: string;
begin
  SLKeyInfo.Clear;
  InitMeshKeys(SLKeyInfo);
  result := SLKeyInfo.Text;
end;

function TFederBinding.GetUpperKeyInfo: string;
begin
  SLKeyInfo.Clear;
  InitUpperKeys(SLKeyInfo);
  result := SLKeyInfo.Text;
end;

function TFederBinding.GetSpecialKeyInfo: string;
begin
  SLKeyInfo.Clear;
  InitSpecialKeys(SLKeyInfo);
  result := SLKeyInfo.Text;
end;

procedure TFederBinding.CycleHelpPlus;
begin
  Inc(IndexH);
  if IndexH >= SLHelp.Count then
    IndexH := 0;
  if Assigned(OnChangeHelp) then
    OnChangeHelp(nil);
end;

procedure TFederBinding.CycleHelpMinus;
begin
  Dec(IndexH);
  if IndexH < 0 then
    IndexH := SLHelp.Count-1;
  if Assigned(OnChangeHelp) then
    OnChangeHelp(nil);
end;

function TFederBinding.GetCurrentHelp: string;
begin
  if (IndexH > -1) and (IndexH < SLHelp.Count) then
    result := SLHelp[IndexH]
  else
    result := '';
end;

procedure TFederBinding.GoHome;
begin
  IndexH := 1;
  CycleHelpMinus;
end;

end.
