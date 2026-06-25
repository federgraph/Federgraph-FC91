unit RiggVar.FederModel.CornerPlane;

interface

uses
  System.Classes,
  System.Types,
  System.UITypes,
  System.Math,
  System.Math.Vectors,
  FMX.Types3D,
  FMX.Objects,
  FMX.Objects3D;

type
  TCornerPlane = class(TPlane)
  private
    FRotX: single;
    FRotY: single;
    FPosZ: single;
    FDefaultPosZ: single;
    procedure RotateX(deg: single);
    procedure SetRotX(const Value: single);
    procedure SetPosZ(const Value: single);
    procedure SetDefaultPosZ(const Value: single);
  public
    Premultiply: Boolean;
    property RotX: single read FRotX write SetRotX;
    property RotY: single read FRotY write FRotY;
    property PosZ: single read FPosZ write SetPosZ;
    property DefaultPosZ: single read FDefaultPosZ write SetDefaultPosZ;
  end;

implementation

procedure TCornerPlane.RotateX(deg: single);
var
  m: TMatrix3D;
begin
  m := TMatrix3D.CreateRotationX(DegToRad(deg));
  if PreMultiply then
    FLocalMatrix := m * FLocalMatrix // local axis
  else
    FLocalMatrix := FLocalMatrix * m; // global axis
  RecalcAbsolute;
  Repaint;
end;

procedure TCornerPlane.SetRotX(const Value: single);
var
  delta: single;
begin
  delta := Value - FRotX;
  RotateX(delta);
  FRotX := Value;
end;

procedure TCornerPlane.SetDefaultPosZ(const Value: single);
begin
  FDefaultPosZ := Value;
  FPosZ := Value;
end;

procedure TCornerPlane.SetPosZ(const Value: single);
begin
  FPosZ := Value;
  ResetRotationAngle;
  Position.Z := Value;
  RotationAngle.Y := FRotY;
  RotateX(FRotX);
end;

end.
