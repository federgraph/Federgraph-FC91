unit RiggVar.Util.BitmapCache;

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
  FMX.Types,
  FMX.Graphics;

type
  TBitmapCache = class
  private
    FBitmap: TBitmap;
  protected
    procedure CopyBitmapToClipboard(ABitmap: TBitmap);
  public
    constructor Create;
    destructor Destroy; override;
    procedure UpdateBitmap(ABitmap: TBitmap);
    procedure CopyImage;
    property Bitmap: TBitmap read FBitmap;
  end;

implementation

uses
  FMX.Platform,
  RiggVar.Util.AppUtils,
  RiggVar.App.Main;

{$ifdef MSWINDOWS}
procedure TBitmapCache.CopyBitmapToClipboard(ABitmap: TBitmap);
var
  dn, fn: string;
  Svc: IFMXClipboardService;
begin
  if not Assigned(ABitmap) then
    Exit;


  if MainVar.HardCopyFlag then
  begin
    dn := TAppUtils.GetUserPicturesDir;
    dn := dn + 'Screenshots';
    fn := dn + '\FC-TS-000.png';
    if DirectoryExists(dn) then
      ABitmap.SaveToFile(fn);
  end;

  if MainVar.NoCopyFlag then
    { do nothing }
  else if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    Svc.SetClipboard(ABitmap);
end;
{$endif}

{$ifdef MACOS}
procedure TBitmapCache.CopyBitmapToClipboard(ABitmap: TBitmap);
var
  Svc: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    Svc.SetClipboard(ABitmap);
end;
{$endif}

{$ifdef Android}
procedure TBitmapCache.CopyBitmapToClipboard(ABitmap: TBitmap);
var
  Svc: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    Svc.SetClipboard(ABitmap);
end;
{$endif}

procedure TBitmapCache.CopyImage;
begin
  CopyBitmapToClipboard(FBitmap);
end;

constructor TBitmapCache.Create;
begin
  FBitmap := TBitmap.Create(10, 10);
end;

destructor TBitmapCache.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TBitmapCache.UpdateBitmap(ABitmap: TBitmap);
begin
  FBitmap.Assign(ABitmap);
end;

end.
