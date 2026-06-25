unit RiggVar.FB.ActionConfig;

interface

uses
  System.Generics.Collections,
  System.UIConsts,
  System.UITypes,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Color,
  RiggVar.FB.ActionMap;

type
  TBtnPos = (
//    TL01,
    TL02,
    TL03,
    TL04,
    TL05,
    TL06,

    TR01,
    TR02,
    TR03,
    TR04,
//    TR05,
    TR06,
    TR07,
    TR08,

    BL01,
    BL02,
    BL03,
    BL04,
    BL05,
    BL06,
    BL07,
    BL08,

    BR01,
    BR02,
    BR03,
    BR04,
    BR05,
    BR06
  );

  TActionItem = record
    Page: Integer;
    Position: TBtnPos;
    Action: TFederAction;
    Color: TAlphaColor;
  end;

  TActionItemList = class(TList<TActionItem>)
  public
    function GetBtnLocation(APos: TBtnPos): TCornerLocation;
    function GetBtnID(APos: TBtnPos): Integer;
    function GetBtnAction(APos: TBtnPos): Integer;

    procedure InitTestData(APage: Integer);
    procedure ProcessAll;
    procedure ProcessOne(cr: TActionItem);
  end;

implementation

uses
  RiggVar.App.Main;

{ TActionItemList }

function TActionItemList.GetBtnLocation(APos: TBtnPos): TCornerLocation;
begin
  case APos of
//    TL01,
    TL02,
    TL03,
    TL04,
    TL05,
    TL06: result := TCornerLocation.TopLeft;

    TR01,
    TR02,
    TR03,
    TR04,
//    TR05,
    TR06,
    TR07,
    TR08: result := TCornerLocation.TopRight;

    BL01,
    BL02,
    BL03,
    BL04,
    BL05,
    BL06,
    BL07,
    BL08: result := TCornerLocation.BottomLeft;

    BR01,
    BR02,
    BR03,
    BR04,
    BR05,
    BR06: result := TCornerLocation.BottomRight;

    else
      result := TCornerLocation.BottomLeft;
  end;
end;

function TActionItemList.GetBtnID(APos: TBtnPos): Integer;
begin
  case APos of
//    TL01: result := 1;
    TL02: result := 2;
    TL03: result := 3;
    TL04: result := 4;
    TL05: result := 5;
    TL06: result := 6;

    TR01: result := 1;
    TR02: result := 2;
    TR03: result := 3;
    TR04: result := 4;
//    TR05: result := 5;
    TR06: result := 6;
    TR07: result := 7;
    TR08: result := 8;

    BL01: result := 1;
    BL02: result := 2;
    BL03: result := 3;
    BL04: result := 4;
    BL05: result := 5;
    BL06: result := 6;
    BL07: result := 7;
    BL08: result := 8;

    BR01: result := 1;
    BR02: result := 2;
    BR03: result := 3;
    BR04: result := 4;
    BR05: result := 5;
    BR06: result := 6;

    else
      result := 0;
  end;
end;

function TActionItemList.GetBtnAction(APos: TBtnPos): Integer;
begin
  case APos of
//    TL01: result := 1;
    TL02: result := faTL02;
    TL03: result := faTL03;
    TL04: result := faTL04;
    TL05: result := faTL05;
    TL06: result := faTL06;

    TR01: result := faTR01;
    TR02: result := faTR02;
    TR03: result := faTR03;
    TR04: result := faTR04;
//    TR05: result := faTR05;
    TR06: result := faTR06;
    TR07: result := faTR07;
    TR08: result := faTR08;

    BL01: result := faBL01;
    BL02: result := faBL02;
    BL03: result := faBL03;
    BL04: result := faBL04;
    BL05: result := faBL05;
    BL06: result := faBL06;
    BL07: result := faBL07;
    BL08: result := faBL08;

    BR01: result := faBR01;
    BR02: result := faBR02;
    BR03: result := faBR03;
    BR04: result := faBR04;
    BR05: result := faBR05;
    BR06: result := faBR06;

    else
      result := 0;
  end;
end;

procedure TActionItemList.InitTestData(APage: Integer);
var
  cr: TActionItem;
begin
  cr.Page := APage;
  cr.Position := BL02;
  cr.Action := faRandomWhite;
  cr.Color := claPlum;
  Self.Add(cr);

  cr.Page := APage;
  cr.Position := BL03;
  cr.Action := faShowBambu;
  cr.Color := claPlum;
  Self.Add(cr);

  cr.Page := APage;
  cr.Position := BL04;
  cr.Action := faShowInfo;
  cr.Color := claPlum;
  Self.Add(cr);
end;

procedure TActionItemList.ProcessAll;
var
  cr: TActionItem;
begin
  InitTestData(Main.FederText1.ActionPage);

  for cr in Self do
    ProcessOne(cr);
end;

procedure TActionItemList.ProcessOne(cr: TActionItem);
var
  p: Integer;
  ai: TActionInfo;
begin
  p := Main.FederText1.ActionPage;
  if not (cr.Page = p) then
    Exit;

  ai.Page := cr.Page;
  ai.Corner := GetBtnLocation(cr.Position);
  ai.Position := GetBtnID(cr.Position);
  ai.Action := cr.Action;
  ai.Color := cr.Color;

  Main.FederText1.InitActionFromInfo(ai);
end;

end.
