unit RiggVar.Conn.Connection;

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

{$define Kreis}

uses
  System.SysUtils,
  System.Classes,
  RiggVar.Conn.Client,
  RiggVar.Conn.MsgParser,
{$ifdef Kreis}
  RiggVar.Conn.Proxy,
{$endif}
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionDecode,
  RiggVar.FB.Classes,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.ParamDef;

type
  TFederConnection = class
  public
    ResultClient: TResultClient;
    MsgCounter: Integer;
    InputMsgCounter: Integer;
    ViewEnabled: Boolean;
  private
    FLastUpdateTime: TDateTime;
    FLEDColor: TConnectionStatus;
    FOnUpdateLED: TNotifyEvent;
    procedure HandleConnectedChanged(Sender: TObject);
    procedure PaintLED;
    procedure SetOnUpdateLED(const Value: TNotifyEvent);
    procedure SetLEDColor(const Value: TConnectionStatus);
  protected
    function IsInputMsg(s: string): Boolean;
    function IsBackupMsg(s: string): Boolean;
  public
    HasUpdate: Boolean;
//    ConnectBtn: TButton;
//    DisconnectBtn: TButton;
//    RequestBtn: TButton;
    HostPanelText: string;
    PortPanelText: string;
    CounterPanelText: string;
    MsgPanelText: string;

    constructor Create;
    destructor Destroy; override;

    procedure ConnectBtnClick(Sender: TObject);
    procedure DisconnectBtnClick(Sender: TObject);
    procedure DownloadBtnClick(Sender: TObject);

    procedure Connect;
    procedure Disconnect;
    procedure Download;

    procedure Init; virtual;
    procedure HandleConnect; virtual;
    procedure HandleDisconnect; virtual;
    procedure BeginDownload; virtual;
    procedure UpdateLED;
    property OnUpdateLED: TNotifyEvent read FOnUpdateLED write SetOnUpdateLED;
    property LEDColor: TConnectionStatus read FLEDColor write SetLEDColor;
  end;

{$ifdef Kreis}
  TKreisOutputConnection = class(TFederConnection)
  private
    FOnUpdateView: TNotifyEvent;
    FederProxy: TFederProxy;
    RequestString: string;
    NeedRequest: Boolean;
    procedure SetOnUpdateView(const Value: TNotifyEvent);
  protected
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
  public
    destructor Destroy; override;

    procedure Init; override;
    procedure HandleConnect; override;

    procedure DoOnIdle;
    procedure DoRequest(s: string);
    procedure RequestBtnClick(Sender: TObject);
    procedure SetOutputMsg(Sender: TObject; s: string);
    procedure UpdateView;
    property OnUpdateView: TNotifyEvent read FOnUpdateView write SetOnUpdateView;
  end;
{$endif}

  TFederProt = class(TLineParser)
  private
    WantValueScaling: Boolean;
    FProtocolFormatString: string;
    VKL: TStringList;
  protected
    fmt: TFederMessageType;
    fmk: TFederMessageKind;
    fmv: TFederAction;
    fmp: TFederParam;

    ScaledValue: Integer;

    K, V: string;
    X, Y, Z: Integer;

    function ParseKeyValue(Key, Value: string): Boolean; override;

    function GetFormattedMsg: string;
    function ScaleDoubleValue(s: string): Integer;
    procedure MarshallValue;
    procedure UnMarshallValue;

    function GetIntValue: Integer;
    function GetDoubleValue: single;
    function GetBoolValue: Boolean;
    property IntValue: Integer read GetIntValue;
    property DoubleValue: single read GetDoubleValue;
    property BoolValue: Boolean read GetBoolValue;

    procedure UpdateFMK;
    procedure UpdateFMT;
    procedure UpdateFMP;
    procedure UpdateFMV;

    function GetMessageValue: Integer;
    property MessageValue: Integer read GetMessageValue;
  public
    constructor Create;
    destructor Destroy; override;
    function IsValidKey(s: string): Boolean;
    function MapKey(s: string): Boolean;
    property FederParam: TFederParam read fmp;
    property MsgKind: TFederMessageKind read fmk;
    property MsgValue: TFederAction read fmv;
  end;

  TFederProtReceiver = class(TFederProt)
  private
    MsgParser: TMsgParser;
    function ParseFormattedMsg(s: string): Boolean;
    procedure ProcessMsg;
    function PrintMsg: string;
    procedure UpdateFMD;
    procedure UpdateFMA;
  public
    fd: TFederData;
    vd: Integer;
    vb: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure ProcessInput(MLIn, MLOut: TStrings);
    function ProcessSingleMsg(s: string): string;
  end;

  TFederInputConnection = class(TFederConnection)
  private
    FP: TFederProt;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Send(s: string);
    procedure ProcessInput(MLIn, MLOut: TStrings);
  end;

  TFederOutputConnection = class(TFederConnection)
  private
    FOnUpdateView: TNotifyEvent;
    FPR: TFederProtReceiver;
    SLBackup: TStringList;
    procedure UpdateView;
    procedure SetOnUpdateView(const Value: TNotifyEvent);
    procedure SetOutputMsg(Sender: TObject; s: string);
    function GetFederData: TFederData;
  public
    MsgText: string;
    constructor Create;
    destructor Destroy; override;
    procedure Init; override;
    procedure ProcessInput(MLIn, MLOut: TStrings); virtual;
    procedure BeginDownload; override;
    procedure EndDownload(SL: TStrings);
    property FederData: TFederData read GetFederData;
    property FederProt: TFederProtReceiver read FPR;
    property OnUpdateView: TNotifyEvent read FOnUpdateView write SetOnUpdateView;
  end;

  TFederTestConnection = class(TFederOutputConnection)
  private
    FP: TFederProt;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Send(s: string);
    procedure ProcessInput(MLIn, MLOut: TStrings); override;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederConnection }

constructor TFederConnection.Create;
begin
  LEDColor := csRed;
  HostPanelText := 'Host';
  PortPanelText := 'Port';
  CounterPanelText := '0';
  MsgPanelText := 'no message received yet';
end;

destructor TFederConnection.Destroy;
begin
  ResultClient.Free;
  inherited;
end;

procedure TFederConnection.Init;
begin
  ResultClient := TResultClient.Create(Main.IniImage.Host, Main.IniImage.Port);
  ResultClient.Client.OnConnectedChanged := HandleConnectedChanged;
  HostPanelText := 'Host: ' + ResultClient.Client.Host;
  PortPanelText := 'Port: ' + IntToStr(ResultClient.Client.Port);

//  if Assigned(ConnectBtn) then
//    ConnectBtn.OnClick := ConnectBtnClick;
//  if Assigned(DisconnectBtn) then
//    DisconnectBtn.OnClick := DisconnectBtnClick;
//  if Assigned(RequestBtn) then
//    RequestBtn.OnClick := DownloadBtnClick;
end;

procedure TFederConnection.BeginDownload;
begin
  { virtual }
end;

procedure TFederConnection.Connect;
begin
  ConnectBtnClick(nil);
end;

procedure TFederConnection.Disconnect;
begin
  DisconnectBtnClick(nil);
end;

procedure TFederConnection.Download;
begin
  DownloadBtnClick(nil);
end;

procedure TFederConnection.ConnectBtnClick(Sender: TObject);
begin
  if (ResultClient = nil)
    or (ResultClient.Client.Host <> Main.IniImage.Host)
    or (ResultClient.Client.Port <> Main.IniImage.Port)
    or MainVar.ShouldRecycleSocket
  then
  begin
    MainVar.ShouldRecycleSocket := False;
    Disconnect;
    ResultClient.Free;
    Init;
  end;
  if not ResultClient.Connected then
  begin
    LEDColor := csYellow;
    ResultClient.Connect;
  end;
end;

procedure TFederConnection.DisconnectBtnClick(Sender: TObject);
begin
  if Assigned(ResultClient) then
    ResultClient.Disconnect;
  PaintLED;
end;

procedure TFederConnection.DownloadBtnClick(Sender: TObject);
begin
  BeginDownload;
end;

procedure TFederConnection.HandleConnectedChanged(Sender: TObject);
begin
  PaintLED;
  if ResultClient.Connected then
    HandleConnect
  else
    HandleDisconnect;
end;

procedure TFederConnection.PaintLED;
begin
  if Assigned(ResultClient) then
  begin
  if ResultClient.Connected then
    LEDColor := csGreen
  else
    LEDColor := csRed;
  end;
end;

procedure TFederConnection.SetLEDColor(const Value: TConnectionStatus);
begin
  FLEDColor := Value;
  UpdateLED;
end;

procedure TFederConnection.SetOnUpdateLED(const Value: TNotifyEvent);
begin
  FOnUpdateLED:= Value;
end;

function TFederConnection.IsInputMsg(s: string): Boolean;
begin
  result := TUtils.StartsWith(s, 'A.B.');
end;

function TFederConnection.IsBackupMsg(s: string): Boolean;
var
  b1, b2: Boolean;
begin
  b1 := TUtils.StartsWith(s, 'version=');
  b2 := TUtils.StartsWith(s, 'SampleData.Begin');
  result := b1 or b2;
end;

procedure TFederConnection.HandleConnect;
begin
  { virtual }
end;

procedure TFederConnection.HandleDisconnect;
begin
  { virtual }
end;

procedure TFederConnection.UpdateLED;
begin
  { virtual }
  if Assigned(OnUpdateLED) then
    OnUpdateLED(self);
end;

{$ifdef Kreis}

{ TKreisOutputConnection }

procedure TKreisOutputConnection.Init;
begin
  inherited;
  ResultClient.Client.OnHandleMsg := SetOutputMsg;

  FederProxy := TFederProxy.Create;
  NeedRequest := True;

//  if Assigned(RequestBtn) then
//    RequestBtn.OnClick := RequestBtnClick;
end;

destructor TKreisOutputConnection.Destroy;
begin
  FederProxy.Free;
  inherited;
end;

procedure TKreisOutputConnection.ApplicationEventsIdle(Sender: TObject;
  var Done: Boolean);
begin
  DoOnIdle;
end;

procedure TKreisOutputConnection.DoOnIdle;
var
  Hour, Min, Sec, MSec: Word;
begin
  if NeedRequest then
  begin
    DoRequest('');
    FLastUpdateTime := Now;
  end
  else if ViewEnabled then
  begin
    DecodeTime(Now - FLastUpdateTime, Hour, Min, Sec, MSec);
    if Sec > 0 then
    begin
      DoRequest('');
      FLastUpdateTime := Now;
    end;
  end;
  PaintLED;
end;

procedure TKreisOutputConnection.HandleConnect;
begin
  inherited;
  if ResultClient.Connected then
    NeedRequest := True;
end;

procedure TKreisOutputConnection.RequestBtnClick(Sender: TObject);
begin
  DoRequest('');
end;

procedure TKreisOutputConnection.DoRequest(s: string);
begin
  if ResultClient.Connected then
  begin
    RequestString := 'A.B.Output.GetProxy';
    ResultClient.Client.SendMsg(RequestString);
  end
  else
  begin
    { indicate not connected }
  end;
  NeedRequest := False;
end;

procedure TKreisOutputConnection.SetOnUpdateView(const Value: TNotifyEvent);
begin
  FOnUpdateView := Value;
end;

procedure TKreisOutputConnection.SetOutputMsg(Sender: TObject; s: string);
begin
  if IsInputMsg(s) then
  begin
    Inc(InputMsgCounter);
    CounterPanelText := IntToStr(InputMsgCounter);
    MsgPanelText := s;
    NeedRequest := True;
    DoOnIdle;
  end
  else
  begin
    Inc(MsgCounter);
    CounterPanelText := IntToStr(MsgCounter);
    FederProxy.CommaText := s;
    UpdateView;
  end;
end;

procedure TKreisOutputConnection.UpdateView;
var
  fd: TFederData;
begin
  if Assigned(Main.FederData) and Assigned(FederProxy) then
  begin
    fd := Main.FederData;
    fd.l1 := FederProxy.R1;
    fd.l2 := FederProxy.R2;
    fd.x1 := FederProxy.M1X;
    fd.y1 := FederProxy.M1Y;
    fd.x2 := FederProxy.M2X;
    fd.y2 := FederProxy.M2Y;
    fd.OffsetX := FederProxy.S1X;
    fd.OffsetY := FederProxy.S1Y;
    fd.AngleX := FederProxy.S2X;
    fd.AngleY := FederProxy.S2Y;

    HasUpdate := True;
    if Assigned(OnUpdateView) then
      OnUpdateView(self);
  end;
end;
{$endif}

{ TFederInputConnection }

constructor TFederInputConnection.Create;
begin
  inherited Create;
  FP := TFederProt.Create;
end;

destructor TFederInputConnection.Destroy;
begin
  FP.Free;
  inherited;
end;

procedure TFederInputConnection.Send(s: string);
begin
  if ResultClient.Connected then
    ResultClient.Client.SendMsg(s);
end;

procedure TFederInputConnection.ProcessInput(MLIn, MLOut: TStrings);
var
  i: Integer;
  s, t: string;
  c: Integer;
begin
  c := MLIn.Count - 1;
  for i := 0 to c do
  begin
    s := MLIn[i];
    if FP.ParseLine(s) then
    begin
      t := FP.GetFormattedMsg;
      Send(t);
      MLOut.Add(t);
    end
    else
    begin
      MLOut.Add('#' + s);
    end;
  end;
end;

{ TFederProt }

constructor TFederProt.Create;
begin
  inherited Create;
  VKL := TStringList.Create;

  VKL.Add(cScene);
  VKL.Add(cGraph);
  VKL.Add(cPlot);
  VKL.Add(cFigure);
  VKL.Add(cBitmap);
  VKL.Add(cColor);
  VKL.Add(cParam);

  VKL.Add(cPalCol);
  VKL.Add(cParamValue);

  VKL.Add(cOpacity);
  VKL.Add(cBigmap);
  VKL.Add(cMinusCap);
  VKL.Add(cPlusCap);
  VKL.Add(cMeshSize);
  VKL.Add(cHub);
  VKL.Add(cSample);

  VKL.Add(cTX);
  VKL.Add(cTY);
  VKL.Add(cRX);
  VKL.Add(cRY);
  VKL.Add(cRZ);
  VKL.Add(cCZ);

  VKL.Add(cx1);
  VKL.Add(cy1);
  VKL.Add(cx2);
  VKL.Add(cy2);
  VKL.Add(cx3);
  VKL.Add(cy3);
  VKL.Add(cx4);
  VKL.Add(cy4);

  VKL.Add(cAnimNewStory);
  VKL.Add(cAnimNewEntry);
  VKL.Add(cAnimGO);
  VKL.Add(cAnimParam);
  VKL.Add(cAnimStartValue);
  VKL.Add(cAnimStopValue);
  VKL.Add(cAnimAnimationType);
  VKL.Add(cAnimInterpolationType);
  VKL.Add(cAnimDuration);
  VKL.Add(cAnimAutoReverse);
  VKL.Add(cAnimLoop);
  VKL.Add(cAnimFromCurrent);

  VKL.Add(cAction);

  VKL.Add(cParallelT);
  VKL.Add(cParallelL);
  VKL.Add(cParallelK);
  VKL.Add(cParallelZ);

  VKL.Add(cParallelX1);
  VKL.Add(cParallelX2);
  VKL.Add(cParallelX3);
  VKL.Add(cParallelX4);

  VKL.Add(cParallelY1);
  VKL.Add(cParallelY2);
  VKL.Add(cParallelY3);
  VKL.Add(cParallelY4);

  VKL.Add(cParallelL1);
  VKL.Add(cParallelL2);
  VKL.Add(cParallelL3);
  VKL.Add(cParallelL4);

  VKL.Add(cParallelK1);
  VKL.Add(cParallelK2);
  VKL.Add(cParallelK3);
  VKL.Add(cParallelK4);

  VKL.Add(cParallelOX);
  VKL.Add(cParallelOY);
  VKL.Add(cParallelOZ);

  VKL.Add(cParallelT1);
  VKL.Add(cParallelT2);

  VKL.Add(cParallelGain);
  VKL.Add(cParallelLimit);
  VKL.Add(cParallelRange);

  VKL.Add(cParallelAttenuation);
  VKL.Add(cParallelAbsoluteRange);
  VKL.Add(cParallelCapValue);
  VKL.Add(cParallelSliceHeight);

  VKL.Add(cm1);
  VKL.Add(cm2);
  VKL.Add(cm3);
  VKL.Add(cm4);

  VKL.Add(cForceMode);
  VKL.Add(cSolutionMode);
  VKL.Add(cPlotFigure);
  VKL.Add(cVorzeichen);
  VKL.Add(cSliceMode);
  VKL.Add(cOpenMesh);
  VKL.Add(cPolarMesh);
  VKL.Add(cLinearMesh);
  VKL.Add(cFuzzyMesh);
  VKL.Add(cReducedMesh);
  VKL.Add(cDim);
  VKL.Add(cGleich);

  VKL.Add(civ);
  VKL.Add(ciw);
  VKL.Add(cjv);
  VKL.Add(cjw);

  VKL.Add(cParallelSample);
  VKL.Add(cParallelHub);
  VKL.Add(cParallelColor);

  VKL.Add(cParallelRX);
  VKL.Add(cParallelRY);
  VKL.Add(cParallelRZ);
  VKL.Add(cParallelCZ);
  VKL.Add(cParallelSW);
  VKL.Add(cParallelBW);
  VKL.Add(cParallelDW);

  VKL.Add(cEulerX);
  VKL.Add(cEulerY);
  VKL.Add(cEulerZ);

  Z := 1;
  FProtocolFormatString := 'A.B.Z%d.Y%d.X%d=%d';
end;

destructor TFederProt.Destroy;
begin
  VKL.Free;
  inherited;
end;

function TFederProt.GetIntValue: Integer;
begin
  result := StrToIntDef(V, 0);
end;

function TFederProt.GetBoolValue: Boolean;
begin
  result := V = '1';
end;

function TFederProt.GetDoubleValue: single;
begin
  result := StrToFloatDef(V, 0.0);
  result := result / 100;
end;

function TFederProt.ScaleDoubleValue(s: string): Integer;
var
  i: Integer;
  d: single;
begin
  d := StrToFloatDef(s, 0);
  i := Round(d * 100);
  result := i;
end;

function TFederProt.GetFormattedMsg: string;
begin
  UpdateFMK;
  UpdateFMT;
  MarshallValue;
  result := Format(FProtocolFormatString, [Z, Y, X, ScaledValue]);
end;

function TFederProt.ParseKeyValue(Key, Value: string): Boolean;
begin
  result := false;
  if IsValidKey(Key) then
  begin
    K := Key;
    V := Value;
    result := MapKey(K);
  end
  else
  begin
    K := '';
    V := '';
    X := 0;
    Y := 0;
    Z := 1;
  end;
end;

function TFederProt.IsValidKey(s: string): Boolean;
begin
  result := VKL.IndexOf(s) >= 0;
end;

function TFederProt.MapKey(s: string): Boolean;
var
  t: Integer;
begin
  WantValueScaling := false;
  t := 0;

  if s = cScene then
    t := 11
  else if s = cGraph then
    t := 12
  else if s = cFigure then
    t := 13
  else if s = cBitmap then
    t := 14
  else if s = cColor then
    t := 15
  else if s = cSample then
    t := 16

  else if s = cParam then
    t := 21
  else if s = cParamValue then
  begin
    t := 22;
    WantValueScaling := True;
  end

  else if s = cMinusCap then
    t := 23
  else if s = cPlusCap then
    t := 24
  else if s = cOpacity then
    t := 25
  else if s = cMeshSize then
    t := 26

  else if s = cAction then
    t := 31
  else if s = cBigmap then
    t := 32
  else if s = cPlot then
    t := 33
  else if s = cHub then
    t := 34
  else if s = cPalCol then
    t := 35

  else if s = cTX then
    t := 41
  else if s = cTY then
    t := 42
  else if s = cRX then
    t := 43
  else if s = cRY then
    t := 44
  else if s = cRZ then
    t := 45
  else if s = cCZ then
    t := 46

  else if s = cx1 then
    t := 51
  else if s = cy1 then
    t := 52
  else if s = cx2 then
    t := 53
  else if s = cy2 then
    t := 54
  else if s = cx3 then
    t := 55
  else if s = cy3 then
    t := 56

  else if s = cAnimNewStory then
    t := 61
  else if s = cAnimNewEntry then
    t := 62
  else if s = cAnimParam then
    t := 63
  else if s = cAnimStartValue then
    t := 64
  else if s = cAnimStopValue then
    t := 65
  else if s = cAnimGO then
    t := 66

  else if s = cAnimAnimationType then
    t := 71
  else if s = cAnimInterpolationType then
    t := 72
  else if s = cAnimDuration then
    t := 73
  else if s = cAnimAutoReverse then
    t := 74
  else if s = cAnimLoop then
    t := 75
  else if s = cAnimFromCurrent then
    t := 76

  else if s = cParallelX1 then
    t := 81
  else if s = cParallelX2 then
    t := 82
  else if s = cParallelX3 then
    t := 83
  else if s = cParallelY1 then
    t := 84
  else if s = cParallelY2 then
    t := 85
  else if s = cParallelY3 then
    t := 86

  else if s = cParallelL1 then
    t := 91
  else if s = cParallelL2 then
    t := 92
  else if s = cParallelL3 then
    t := 93
  else if s = cParallelK1 then
    t := 94
  else if s = cParallelK2 then
    t := 95
  else if s = cParallelK3 then
    t := 96

  else if s = cParallelOX then
    t := 101
  else if s = cParallelOY then
    t := 102
  else if s = cParallelOZ then
    t := 103
  else if s = cEulerX then
    t := 104
  else if s = cEulerY then
    t := 105
  else if s = cEulerZ then
    t := 106

  else if s = cParallelT1 then
    t := 111
  else if s = cParallelT2 then
    t := 112
  else if s = cParallelGain then
    t := 113
  else if s = cParallelLimit then
    t := 114
  else if s = cParallelRange then
    t := 115
  else if s = cParallelDW then
    t := 116

  else if s = cx4 then
    t := 121
  else if s = cy4 then
    t := 122
  else if s = cParallelX4 then
    t := 123
  else if s = cParallelY4 then
    t := 124
  else if s = cParallelL4 then
    t := 125
  else if s = cParallelK4 then
    t := 126

  else if s = cm1 then
    t := 131
  else if s = cm2 then
    t := 132
  else if s = cm3 then
    t := 133
  else if s = cm4 then
    t := 134

  else if s = cForceMode then
    t := 141
  else if s = cSolutionMode then
    t := 142
  else if s = cPlotFigure then
    t := 143
  else if s = cVorzeichen then
    t := 144
  else if s = cDim then
    t := 145
  else if s = cGleich then
    t := 146

  else if s = civ then
    t := 151
  else if s = ciw then
    t := 152
  else if s = cjv then
    t := 153
  else if s = cjw then
    t := 154
  else if s = cSliceMode then
    t := 155

  else if s = cOpenMesh then
    t := 161
  else if s = cPolarMesh then
    t := 162
  else if s = cLinearMesh then
    t := 163
  else if s = cFuzzyMesh then
    t := 164
  else if s = cReducedMesh then
    t := 165

  else if s = cParallelL then
    t := 171
  else if s = cParallelK then
    t := 172
  else if s = cParallelT then
    t := 173
  else if s = cParallelZ then
    t := 174

  else if s = cParallelSample then
    t := 181
  else if s = cParallelHub then
    t := 182
  else if s = cParallelColor then
    t := 183

  else if s = cParallelRX then
    t := 191
  else if s = cParallelRY then
    t := 192
  else if s = cParallelRZ then
    t := 193
  else if s = cParallelCZ then
    t := 194
  else if s = cParallelSW then
    t := 195
  else if s = cParallelBW then
    t := 196

  else if s = cParallelAttenuation then
    t := 201
  else if s = cParallelAbsoluteRange then
    t := 202
  else if s = cParallelCapValue then
    t := 203
  else if s = cParallelSliceHeight then
    t := 204

  ;
  Y := t div 10;
  X := t mod 10;
  result := (Y >= 1) and (Y <= 20) and (X >= 1) and (X <= 6);
end;

procedure TFederProt.MarshallValue;
begin
  case fmt of
    fmtInt: ScaledValue := StrToIntDef(V, 0);
    fmtDouble: ScaledValue := ScaleDoubleValue(V);
    fmtBool:
    begin
      if TUtils.IsTrue(V) then
        ScaledValue := 1
      else
        ScaledValue := 0;
    end;
  end;
end;

procedure TFederProt.UnMarshallValue;
begin
  case fmt of
    fmtInt: V := IntToStr(ScaledValue);
    fmtDouble: V := Format('%2.2f', [ScaledValue / 100]);
    fmtBool:
    begin
      if ScaledValue = 1 then
        V := BoolStr[True]
      else
        V := BoolStr[False];
    end;
  end;
end;

procedure TFederProt.UpdateFMP;
begin
  if fmk = fmkParam then
  begin
//    fmp := TFederUtils.GetFederParam(MessageValue);
    fmp := TFederParamDef.Decode(MessageValue);
  end;
end;

procedure TFederProt.UpdateFMT;
begin
  if fmk = fmkParamValue then
    fmt := fmtDouble
  else if fmk = fmkEulerX then
    fmt := fmtDouble
  else if fmk = fmkEulerY then
    fmt := fmtDouble
  else if fmk = fmkEulerZ then
    fmt := fmtDouble
  else if fmk = fmkMinusCap then
    fmt := fmtBool
  else if fmk = fmkPlusCap then
    fmt := fmtBool
  else if fmk = fmkOpacity then
    fmt := fmtBool
  else if fmk = fmkBigmap then
    fmt := fmtBool
  else if fmk = fmkSolutionMode then
    fmt := fmtBool
  else if fmk = fmkVorzeichen then
    fmt := fmtBool
  else if fmk = fmkOpenMesh then
    fmt := fmtBool
  else if fmk = fmkPolarMesh then
    fmt := fmtBool
  else if fmk = fmkLinearMesh then
    fmt := fmtBool
  else if fmk = fmkFuzzyMesh then
    fmt := fmtBool
  else if fmk = fmkReducedMesh then
    fmt := fmtBool
  else if fmk = fmkGleich then
    fmt := fmtBool
  else
    fmt := fmtInt;
end;

procedure TFederProt.UpdateFMV;
begin
  if fmk = fmkAction then
    fmv := TFederAction(GetFederActionDecodedValue(IntValue));
end;

procedure TFederProt.UpdateFMK;
var
  t: Integer;
begin
  t := Y * 10 + X;
  case t of
    11: fmk := fmkScene;
    12: fmk := fmkGraph;
    13: fmk := fmkFigure;
    14: fmk := fmkBitmap;
    15: fmk := fmkColor;
    16: fmk := fmkSample;

    21: fmk := fmkParam;
    22: fmk := fmkParamValue;
    23: fmk := fmkMinusCap;
    24: fmk := fmkPlusCap;
    25: fmk := fmkOpacity;
    26: fmk := fmkMeshSize;

    31: fmk := fmkAction;
    32: fmk := fmkBigmap;
    33: fmk := fmkPlot;
    34: fmk := fmkHub;
    35: fmk := fmkPalCol;

    41: fmk := fmkTX;
    42: fmk := fmkTY;
    43: fmk := fmkRX;
    44: fmk := fmkRY;
    45: fmk := fmkRZ;
    46: fmk := fmkCZ;

    51: fmk := fmkX1;
    52: fmk := fmkY1;
    53: fmk := fmkX2;
    54: fmk := fmkY2;
    55: fmk := fmkX3;
    56: fmk := fmkY3;

    61: fmk := fmkAnimNewStory;
    62: fmk := fmkAnimNewEntry;
    63: fmk := fmkAnimParam;
    64: fmk := fmkAnimStartValue;
    65: fmk := fmkAnimStopValue;
    66: fmk := fmkAnimGO;

    71: fmk := fmkAnimAT;
    72: fmk := fmkAnimIT;
    73: fmk := fmkAnimDU;
    74: fmk := fmkAnimAR;
    75: fmk := fmkAnimLP;
    76: fmk := fmkAnimFC;

    81: fmk := fmkParallelX1;
    82: fmk := fmkParallelX2;
    83: fmk := fmkParallelX3;
    84: fmk := fmkParallelY1;
    85: fmk := fmkParallelY2;
    86: fmk := fmkParallelY3;

    91: fmk := fmkParallelL1;
    92: fmk := fmkParallelL2;
    93: fmk := fmkParallelL3;
    94: fmk := fmkParallelK1;
    95: fmk := fmkParallelK2;
    96: fmk := fmkParallelK3;

    101: fmk := fmkParallelOX;
    102: fmk := fmkParallelOY;
    103: fmk := fmkParallelOZ;
    104: fmk := fmkEulerX;
    105: fmk := fmkEulerY;
    106: fmk := fmkEulerZ;

    111: fmk := fmkParallelT1;
    112: fmk := fmkParallelT2;
    113: fmk := fmkParallelGain;
    114: fmk := fmkParallelLimit;
    115: fmk := fmkParallelRange;
    116: fmk := fmkParallelDW;

    121: fmk := fmkX4;
    122: fmk := fmkY4;
    123: fmk := fmkParallelX4;
    124: fmk := fmkParallelY4;
    125: fmk := fmkParallelL4;
    126: fmk := fmkParallelK4;

    131: fmk := fmkM1;
    132: fmk := fmkM2;
    133: fmk := fmkM3;
    134: fmk := fmkM4;

    141: fmk := fmkForceMode;
    142: fmk := fmkSolutionMode;
    143: fmk := fmkPlotFigure;
    144: fmk := fmkVorzeichen;
    145: fmk := fmkDim;
    146: fmk := fmkGleich;

//    151: fmk := fmkIV;
//    152: fmk := fmkIW;
//    153: fmk := fmkJV;
//    154: fmk := fmkJW;
//    155: fmk := fmkSliceMode;

    161: fmk := fmkOpenMesh;
    162: fmk := fmkPolarMesh;
    163: fmk := fmkLinearMesh;
    164: fmk := fmkFuzzyMesh;
    165: fmk := fmkReducedMesh;

    171: fmk := fmkParallelL;
    172: fmk := fmkParallelK;
    173: fmk := fmkParallelT;
    174: fmk := fmkParallelZ;

    181: fmk := fmkParallelSample;
    182: fmk := fmkParallelHub;
    183: fmk := fmkParallelColor;

    191: fmk := fmkParallelRX;
    192: fmk := fmkParallelRY;
    193: fmk := fmkParallelRZ;
    194: fmk := fmkParallelCZ;
    195: fmk := fmkParallelSW;
    196: fmk := fmkParallelBW;

    201: fmk := fmkParallelAttenuation;
    202: fmk := fmkParallelAbsoluteRange;
    203: fmk := fmkParallelCapValue;
//    204: fmk := fmkParallelSliceHeight;

  end;
end;

function TFederProt.GetMessageValue: Integer;
begin
  result := StrToIntDef(V, MaxInt);
end;

{ TFederProtReceiver }

constructor TFederProtReceiver.Create;
begin
  inherited Create;
  fd := TFederData.Create;
  MsgParser := TMsgParser.Create;
end;

destructor TFederProtReceiver.Destroy;
begin
  MsgParser.Free;
  fd.Free;
  inherited;
end;

function TFederProtReceiver.ProcessSingleMsg(s: string): string;
begin
  if ParseFormattedMsg(s) then
  begin
    ProcessMsg;
    result := PrintMsg;
  end
  else
  begin
    result := '#' + s;
  end;
end;

procedure TFederProtReceiver.ProcessInput(MLIn, MLOut: TStrings);
var
  i: Integer;
  s, t: string;
  c: Integer;
begin
  c := MLIn.Count - 1;
  for i := 0 to c do
  begin
    s := MLIn[i];
    if ParseFormattedMsg(s) then
    begin
      ProcessMsg;
      t := PrintMsg;
      MLOut.Add(t);
    end
    else
    begin
      MLOut.Add('#' + s);
    end;
  end;
end;

function TFederProtReceiver.ParseFormattedMsg(s: string): Boolean;
begin
  result := MsgParser.ParseLine(s);
  Z := MsgParser.iRace;
  Y := StrToIntDef(MsgParser.sBib, 0);
  X := StrToIntDef(MsgParser.sCommand, 0);
  V := MsgParser.sValue;
  ScaledValue := StrToIntDef(V, MaxInt);
end;

procedure TFederProtReceiver.ProcessMsg;
begin
  UpdateFMK;
  UpdateFMT;
  if fmk = fmkParam then
    UpdateFMP;
  UpdateFMD;
  UpdateFMV;
  UpdateFMA;
end;

procedure TFederProtReceiver.UpdateFMD;
begin
  case fmk of
    fmkX1: vd := IntValue;
    fmkY1: vd := IntValue;
    fmkX2: vd := IntValue;
    fmkY2: vd := IntValue;
    fmkX3: vd := IntValue;
    fmkY3: vd := IntValue;
    fmkX4: vd := IntValue;
    fmkY4: vd := IntValue;

    fmkTX: vd := IntValue;
    fmkTY: vd := IntValue;
    fmkRX: vd := IntValue;
    fmkRY: vd := IntValue;
    fmkRZ: vd := IntValue;
    fmkCZ: vd := IntValue;

    fmkParam: fd.Param := IntValue;
    fmkPalCol: vd := IntValue;

    fmkScene: fd.Scene := IntValue;
    fmkGraph: fd.Graph := IntValue;
    fmkPlot: fd.Plot := IntValue;
    fmkFigure: fd.Figure := IntValue;
    fmkBitmap: fd.Bitmap := IntValue;
    fmkColor: fd.Color := IntValue;

    fmkMinusCap: fd.MinusCap := BoolValue;
    fmkPlusCap: fd.PlusCap := BoolValue;
    fmkOpacity: fd.Opacity := BoolValue;
    fmkBigmap: fd.Bigmap := BoolValue;

    fmkHub: Main.Hub := IntValue;
    fmkSample: Main.Sample := IntValue;
    fmkMeshSize: fd.MeshSize := IntValue;

    fmkParamValue:
    begin
      case fmp of
        fpx1: fd.x1 := DoubleValue;
        fpx2: fd.x2 := DoubleValue;
        fpx3: fd.x3 := DoubleValue;
        fpx4: fd.x4 := DoubleValue;

        fpy1: fd.y1 := DoubleValue;
        fpy2: fd.y2 := DoubleValue;
        fpy3: fd.y3 := DoubleValue;
        fpy4: fd.y4 := DoubleValue;

        fpz1: fd.z1 := DoubleValue;
        fpz2: fd.z2 := DoubleValue;
        fpz3: fd.z3 := DoubleValue;
        fpz4: fd.z4 := DoubleValue;
        fpz:
        begin
          fd.z1 := DoubleValue;
          fd.z2 := DoubleValue;
          fd.z3 := DoubleValue;
          fd.z4 := DoubleValue;
        end;

        fpl1: fd.l1 := DoubleValue;
        fpl2: fd.l2 := DoubleValue;
        fpl3: fd.l3 := DoubleValue;
        fpl4: fd.l4 := DoubleValue;
        fpl:
        begin
          fd.l1 := DoubleValue;
          fd.l2 := DoubleValue;
          fd.l3 := DoubleValue;
          fd.l4 := DoubleValue;
        end;

        fpk1: fd.k1 := DoubleValue;
        fpk2: fd.k2 := DoubleValue;
        fpk3: fd.k3 := DoubleValue;
        fpk4: fd.k4 := DoubleValue;
        fpk:
        begin
          fd.k1 := DoubleValue;
          fd.k2 := DoubleValue;
          fd.k3 := DoubleValue;
          fd.k4 := DoubleValue;
        end;

        fpt: fd.x1 := DoubleValue;
        fptrt: fd.x1 := DoubleValue;
        fptrx: fd.x1 := DoubleValue;
        fptry: fd.x1 := DoubleValue;

        fpox: fd.OffsetX := IntValue div 100;
        fpoy: fd.OffsetY := IntValue div 100;
        fpoz: fd.OffsetZ := IntValue div 100;

        fprx: fd.x1 := DoubleValue;
        fpry: fd.x1 := DoubleValue;
        fprz: fd.x1 := DoubleValue;

        fpAttenuation: fd.Gain := IntValue div 100;
        fpGrenze: fd.Limit := IntValue div 100;
        fpRange: fd.Range := IntValue div 100;
        fpAbsoluteRange: fd.AbsoluteRange := IntValue div 100;

        fpParamCapValue: fd.CapValue := Round(DoubleValue);
//        fpParamSliceHeight: vd := Round(DoubleValue);

        fpt1: fd.t1 := Round(DoubleValue);
        fpt2: fd.t2 := Round(DoubleValue);
        fpt3: fd.t3 := Round(DoubleValue);
        fpt4: fd.t4 := Round(DoubleValue);
      end;
    end;

    fmkParallelX1:
    begin
      fd.Param := TFederParamDef.Encode(fpx1);
      vd := IntValue;
    end;
    fmkParallelX2:
    begin
      fd.Param := TFederParamDef.Encode(fpx2);
      vd := IntValue;
    end;
    fmkParallelX3:
    begin
      fd.Param := TFederParamDef.Encode(fpx3);
      vd := IntValue;
    end;
    fmkParallelX4:
    begin
      fd.Param := TFederParamDef.Encode(fpx4);
      vd := IntValue;
    end;

    fmkParallelY1:
    begin
      fd.Param := TFederParamDef.Encode(fpy1);
      vd := IntValue;
    end;
    fmkParallelY2:
    begin
      fd.Param := TFederParamDef.Encode(fpy2);
      vd := IntValue;
    end;
    fmkParallelY3:
    begin
      fd.Param := TFederParamDef.Encode(fpy3);
      vd := IntValue;
    end;
    fmkParallelY4:
    begin
      fd.Param := TFederParamDef.Encode(fpy4);
      vd := IntValue;
    end;

    fmkParallelZ:
    begin
      fd.Param := TFederParamDef.Encode(fpz);
      vd := IntValue;
    end;
    fmkParallelZ1:
    begin
      fd.Param := TFederParamDef.Encode(fpz1);
      vd := IntValue;
    end;
    fmkParallelZ2:
    begin
      fd.Param := TFederParamDef.Encode(fpz2);
      vd := IntValue;
    end;
    fmkParallelZ3:
    begin
      fd.Param := TFederParamDef.Encode(fpz3);
      vd := IntValue;
    end;
    fmkParallelZ4:
    begin
      fd.Param := TFederParamDef.Encode(fpz4);
      vd := IntValue;
    end;

    fmkParallelL:
    begin
      fd.Param := TFederParamDef.Encode(fpl);
      vd := IntValue;
    end;
    fmkParallelL1:
    begin
      fd.Param := TFederParamDef.Encode(fpl1);
      vd := IntValue;
    end;
    fmkParallelL2:
    begin
      fd.Param := TFederParamDef.Encode(fpl2);
      vd := IntValue;
    end;
    fmkParallelL3:
    begin
      fd.Param := TFederParamDef.Encode(fpl3);
      vd := IntValue;
    end;
    fmkParallelL4:
    begin
      fd.Param := TFederParamDef.Encode(fpl4);
      vd := IntValue;
    end;

    fmkParallelK:
    begin
      fd.Param := TFederParamDef.Encode(fpk);
      vd := IntValue;
    end;
    fmkParallelK1:
    begin
      fd.Param := TFederParamDef.Encode(fpk1);
      vd := IntValue;
    end;
    fmkParallelK2:
    begin
      fd.Param := TFederParamDef.Encode(fpk2);
      vd := IntValue;
    end;
    fmkParallelK3:
    begin
      fd.Param := TFederParamDef.Encode(fpk3);
      vd := IntValue;
    end;
    fmkParallelK4:
    begin
      fd.Param := TFederParamDef.Encode(fpk4);
      vd := IntValue;
    end;

    fmkParallelOX:
    begin
      fd.Param := TFederParamDef.Encode(fpox);
      vd := IntValue;
    end;
    fmkParallelOY:
    begin
      fd.Param := TFederParamDef.Encode(fpoy);
      vd := IntValue;
    end;
    fmkParallelOZ:
    begin
      fd.Param := TFederParamDef.Encode(fpoz);
      vd := IntValue;
    end;

    fmkParallelT:
    begin
      fd.Param := TFederParamDef.Encode(fpt);
      vd := IntValue;
    end;
    fmkParallelT1:
    begin
      fd.Param := TFederParamDef.Encode(fpt1);
      vd := IntValue;
    end;
    fmkParallelT2:
    begin
      fd.Param := TFederParamDef.Encode(fpt2);
      vd := IntValue;
    end;

    fmkParallelGain:
    begin
      fd.Param := TFederParamDef.Encode(fpAttenuation);
      vd := IntValue;
    end;
    fmkParallelLimit:
    begin
      fd.Param := TFederParamDef.Encode(fpGrenze);
      vd := IntValue;
    end;
    fmkParallelRange:
    begin
      fd.Param := TFederParamDef.Encode(fpRange);
      vd := IntValue;
    end;

    fmkParallelAttenuation:
    begin
      fd.Param := TFederParamDef.Encode(fpAttenuation);
      vd := IntValue;
    end;

    fmkParallelAbsoluteRange:
    begin
      fd.Param := TFederParamDef.Encode(fpAbsoluteRange);
      vd := IntValue;
    end;

    fmkParallelCapValue:
    begin
      fd.Param := TFederParamDef.Encode(fpParamCapValue);
      vd := IntValue;
    end;

//    fmkParallelSliceHeight:
//    begin
//      fd.Param := TFederParamDef.Encode(fpParamSliceHeight);
//      vd := IntValue;
//    end;

    fmkm1: fd.m1 := IntValue;
    fmkm2: fd.m2 := IntValue;
    fmkm3: fd.m3 := IntValue;
    fmkm4: fd.m4 := IntValue;

    fmkForceMode: fd.ForceMode := IntValue;
    fmkSolutionMode: fd.SolutionMode := BoolValue;
    fmkPlotFigure: fd.PlotFigure := IntValue;
    fmkVorzeichen: fd.Vorzeichen := BoolValue;

    fmkOpenMesh: vb := BoolValue;
    fmkPolarMesh: vb := BoolValue;
    fmkLinearMesh: vb := BoolValue;
    fmkFuzzyMesh: vb := BoolValue;
    fmkReducedMesh: vb := BoolValue;
    fmkDim: vd := IntValue;
    fmkGleich: vb := BoolValue;

    fmkParallelSample: vd := IntValue;
    fmkParallelHub: vd := IntValue;
    fmkParallelColor: vd := IntValue;

    fmkParallelRX: vd := IntValue;
    fmkParallelRY: vd := IntValue;
    fmkParallelRZ: vd := IntValue;
    fmkParallelCZ: vd := IntValue;
    fmkParallelSW: vd := IntValue;
    fmkParallelBW: vd := IntValue;
    fmkParallelDW: vd := IntValue;

    fmkEulerX: fd.AngleX := DoubleValue;
    fmkEulerY: fd.AngleY := DoubleValue;
    fmkEulerZ: fd.AngleZ := DoubleValue;

  end;

end;

procedure TFederProtReceiver.UpdateFMA;
begin
  Main.ProcessAnimLine(fmk, V);
end;

function TFederProtReceiver.PrintMsg: string;
var
  a, b: string;
begin
  UnmarshallValue;
  a := TFederUtils.GetMessageKindString(fmk);
  b := V;
  result := Format('%s=%s', [a, b]);
end;

{ TFederOutputConnection }

constructor TFederOutputConnection.Create;
begin
  inherited Create;
  FPR := TFederProtReceiver.Create;
  SLBackup := TStringList.Create;
end;

destructor TFederOutputConnection.Destroy;
begin
  FPR.Free;
  SLBackup.Free;
  inherited;
end;

function TFederOutputConnection.GetFederData: TFederData;
begin
  result := FPR.fd;
end;

procedure TFederOutputConnection.Init;
begin
  inherited;
  ResultClient.Client.OnHandleMsg := SetOutputMsg;
end;

procedure TFederOutputConnection.ProcessInput(MLIn, MLOut: TStrings);
begin
  { ignore }
end;

procedure TFederOutputConnection.SetOnUpdateView(const Value: TNotifyEvent);
begin
  FOnUpdateView := Value;
end;

procedure TFederOutputConnection.SetOutputMsg(Sender: TObject; s: string);
var
  p: Integer;
  msg: string;
begin
  { decode header }
  p := Pos(#4, s);
  if p > 0 then
    msg := Copy(s, p+1, Length(s)-p)
  else
    msg := s;

  if IsInputMsg(msg) then
  begin
    Inc(InputMsgCounter);
    CounterPanelText := IntToStr(InputMsgCounter);
    MsgPanelText := msg;
    MsgText := FPR.ProcessSingleMsg(msg);
    UpdateView;
  end
  else if IsBackupMsg(msg) then
  begin
    SLBackup.Text := msg;
    EndDownload(SLBackup);
    SLBackup.Clear;
  end;
end;

procedure TFederOutputConnection.UpdateView;
begin
  HasUpdate := True;
  if Assigned(OnUpdateView) then
    OnUpdateView(self);
end;

procedure TFederOutputConnection.BeginDownload;
begin
  if ResultClient.Connected then
    ResultClient.Client.SendMsg('A.B.Output.GetProxy');
end;

procedure TFederOutputConnection.EndDownload(SL: TStrings);
begin
  Main.DownloadCompleted(SL);
end;

{ TFederTestConnection }

constructor TFederTestConnection.Create;
begin
  inherited Create;
  FP := TFederProt.Create;
end;

destructor TFederTestConnection.Destroy;
begin
  FP.Free;
  inherited;
end;

procedure TFederTestConnection.Send(s: string);
begin
  if ResultClient.Connected then
  begin
    //ResultClient.Client.SendMsg(s);
    SetOutputMsg(self, s);
  end;
end;

procedure TFederTestConnection.ProcessInput(MLIn, MLOut: TStrings);
var
  i: Integer;
  s, t: string;
  c: Integer;
begin
  c := MLIn.Count - 1;
  for i := 0 to c do
  begin
    s := MLIn[i];
    if FP.ParseLine(s) then
    begin
      t := FP.GetFormattedMsg;
      Send(t);
      MLOut.Add(t);
    end
    else
    begin
      MLOut.Add('#' + s);
    end;
  end;
end;

end.
