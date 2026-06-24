unit RiggVar.Bitmap.Bands;

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
  RiggVar.FB.Bitmap;

type
  TBandColorData = class(TColorDataSource)
  private
    TempColorBand: TColorBand;
    procedure SetBands(j: Integer; const Value: string);
  protected
    procedure Sample07;
    procedure Sample11;
    procedure Sample14;
    procedure Sample15;
    procedure Sample16;
    procedure Sample17;
    procedure Sample18;
    procedure Sample19;
    procedure Sample20;
    procedure Sample21;
    procedure Sample22;
    procedure Sample23;

    property Bands[j: Integer]: string write SetBands;
  public
    BlindColorCount: Integer;

    StripWidth: Integer;
    BandWidth: Integer;

    StandardColor: Integer;

    WantContour: Boolean;
    WantShirtColor: Boolean;

    SquareBitmap: Boolean;
    HorizontalBitmap: Boolean;
    SquareSym: Boolean;

    RandomPaint: Boolean;
    StandardPaint: Boolean;
    MonoPaint: Boolean;

    constructor Create;
    destructor Destroy; override;

    procedure ReadBandInfoTestData;

    procedure IntitColorBands(SchemeID: Integer; AColorMix: Integer); virtual;
  end;

implementation

uses
  RiggVar.App.Main;

constructor TBandColorData.Create;
begin
  inherited Create;
  TempColorBand := TColorBand.Create;
end;

destructor TBandColorData.Destroy;
begin
  TempColorBand.Free;
  inherited;
end;

procedure TBandColorData.SetBands(j: Integer; const Value: string);
begin
  if TempColorBand.Parse(Value) then
    Main.BitmapBuilder.AssignBandInfo(j, TempColorBand);
end;

procedure TBandColorData.IntitColorBands(SchemeID, AColorMix: Integer);
begin
  ColorMix := AColorMix;

  case SchemeID of
    07: Sample07;
    11: Sample11;
    14: Sample14;
    15: Sample15;
    16: Sample16;
    17: Sample17;
    18: Sample18;
    19: Sample19;
    20: Sample20;
    21: Sample21;
    22: Sample22;
    23: Sample23;
    else
      Sample14;
  end;
end;

procedure TBandColorData.Sample07;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 7;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-128-128-128';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-206-205-159';
Bands[2] := '011-104-102-051';
Bands[3] := '011-121-022-057';
Bands[4] := '011-154-180-053';
Bands[5] := '011-172-238-196';
Bands[6] := '011-130-069-246';
Bands[7] := '011-005-229-175';
Bands[8] := '011-231-249-218';
Bands[9] := '011-253-233-042';
Bands[10] := '011-157-033-145';
Bands[11] := '011-237-173-173';
Bands[12] := '011-042-072-016';
Bands[13] := '011-076-032-214';
Bands[14] := '011-048-180-132';
Bands[15] := '011-064-169-153';
Bands[16] := '011-235-041-157';
Bands[17] := '011-160-015-210';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-140-237-224';
Bands[19] := '011-188-227-031';
Bands[20] := '011-254-107-032';
Bands[21] := '011-247-007-024';
Bands[22] := '011-166-209-180';
Bands[23] := '011-111-142-088';
Bands[24] := '011-036-209-078';
Bands[25] := '011-070-181-119';
Bands[26] := '011-047-235-044';
Bands[27] := '011-214-118-249';
Bands[28] := '011-250-177-215';
Bands[29] := '011-037-138-219';
Bands[30] := '011-207-097-052';
Bands[31] := '011-098-015-004';
Bands[32] := '011-049-197-070';
Bands[33] := '011-163-019-072';
Bands[34] := '011-132-029-143';
end;

procedure TBandColorData.Sample11;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 11;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-255-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-255-249-249';
Bands[2] := '011-255-189-189';
Bands[3] := '011-255-140-140';
Bands[4] := '011-255-120-120';
Bands[5] := '011-255-191-191';
Bands[6] := '011-255-198-198';
Bands[7] := '011-255-162-162';
Bands[8] := '011-255-185-185';
Bands[9] := '011-255-215-215';
Bands[10] := '011-255-254-254';
Bands[11] := '011-255-150-150';
Bands[12] := '011-255-205-205';
Bands[13] := '011-255-205-206';
Bands[14] := '011-255-083-083';
Bands[15] := '011-255-113-113';
Bands[16] := '011-255-160-160';
Bands[17] := '011-255-170-170';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-255-163-163';
Bands[19] := '011-255-217-217';
Bands[20] := '011-255-238-238';
Bands[21] := '011-255-110-110';
Bands[22] := '011-255-195-195';
Bands[23] := '011-255-171-171';
Bands[24] := '011-255-234-234';
Bands[25] := '011-255-100-100';
Bands[26] := '011-255-116-116';
Bands[27] := '011-255-092-092';
Bands[28] := '011-255-139-139';
Bands[29] := '011-255-152-152';
Bands[30] := '011-255-149-149';
Bands[31] := '011-255-165-165';
Bands[32] := '011-255-097-097';
Bands[33] := '011-255-135-135';
Bands[34] := '011-255-129-129';
end;

procedure TBandColorData.Sample14;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 14;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-087-050-093';
Bands[2] := '011-226-175-106';
Bands[3] := '011-074-157-170';
Bands[4] := '011-061-244-140';
Bands[5] := '011-163-019-072';
Bands[6] := '011-108-188-168';
Bands[7] := '011-028-007-129';
Bands[8] := '011-122-071-059';
Bands[9] := '011-115-155-174';
Bands[10] := '011-251-123-038';
Bands[11] := '011-128-040-148';
Bands[12] := '011-212-006-092';
Bands[13] := '011-068-106-190';
Bands[14] := '011-011-153-250';
Bands[15] := '011-156-139-211';
Bands[16] := '011-066-173-232';
Bands[17] := '011-229-131-125';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-150-124-192';
Bands[19] := '011-242-109-060';
Bands[20] := '011-037-135-120';
Bands[21] := '011-081-007-019';
Bands[22] := '011-130-148-215';
Bands[23] := '011-127-117-217';
Bands[24] := '011-211-047-231';
Bands[25] := '011-048-108-236';
Bands[26] := '011-125-026-156';
Bands[27] := '011-143-231-017';
Bands[28] := '011-177-210-172';
Bands[29] := '011-228-058-247';
Bands[30] := '011-019-175-032';
Bands[31] := '011-044-198-132';
Bands[32] := '011-033-212-020';
Bands[33] := '011-163-019-072';
Bands[34] := '011-012-038-061';
end;

procedure TBandColorData.Sample15;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 15;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-248-029-140';
Bands[2] := '011-012-055-213';
Bands[3] := '011-016-118-198';
Bands[4] := '011-159-136-099';
Bands[5] := '011-044-132-018';
Bands[6] := '011-217-110-243';
Bands[7] := '011-009-066-118';
Bands[8] := '011-131-117-000';
Bands[9] := '011-047-162-054';
Bands[10] := '011-197-124-043';
Bands[11] := '011-145-196-033';
Bands[12] := '011-254-245-225';
Bands[13] := '011-051-031-014';
Bands[14] := '011-163-191-223';
Bands[15] := '011-144-129-171';
Bands[16] := '011-050-073-185';
Bands[17] := '011-005-038-095';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-241-062-022';
Bands[19] := '011-207-031-025';
Bands[20] := '011-030-141-163';
Bands[21] := '011-054-222-226';
Bands[22] := '011-135-134-160';
Bands[23] := '011-227-054-027';
Bands[24] := '011-082-021-059';
Bands[25] := '011-013-016-169';
Bands[26] := '011-211-129-011';
Bands[27] := '011-232-091-247';
Bands[28] := '011-034-152-224';
Bands[29] := '011-110-105-145';
Bands[30] := '011-118-011-122';
Bands[31] := '011-212-250-076';
Bands[32] := '011-084-180-115';
Bands[33] := '011-163-019-072';
Bands[34] := '011-000-016-002';
end;

procedure TBandColorData.Sample16;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 16;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-205-092-092';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-082-010-151';
Bands[2] := '011-231-182-147';
Bands[3] := '011-236-070-089';
Bands[4] := '011-146-230-226';
Bands[5] := '011-022-155-219';
Bands[6] := '011-123-138-071';
Bands[7] := '011-230-222-220';
Bands[8] := '011-085-182-221';
Bands[9] := '011-236-056-118';
Bands[10] := '011-212-235-088';
Bands[11] := '011-091-094-092';
Bands[12] := '011-159-139-185';
Bands[13] := '011-232-025-086';
Bands[14] := '011-240-169-164';
Bands[15] := '011-011-201-169';
Bands[16] := '011-029-202-009';
Bands[17] := '011-217-111-057';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-162-185-115';
Bands[19] := '011-227-207-104';
Bands[20] := '011-145-178-041';
Bands[21] := '011-226-132-216';
Bands[22] := '011-062-159-186';
Bands[23] := '011-246-074-210';
Bands[24] := '011-047-127-251';
Bands[25] := '011-002-187-132';
Bands[26] := '011-122-197-053';
Bands[27] := '011-115-014-192';
Bands[28] := '011-223-133-025';
Bands[29] := '011-074-251-197';
Bands[30] := '011-091-066-142';
Bands[31] := '011-010-147-013';
Bands[32] := '011-172-113-069';
Bands[33] := '011-161-167-101';
Bands[34] := '011-185-069-213';
end;

procedure TBandColorData.Sample17;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 17;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-026-104-172';
Bands[2] := '011-031-213-175';
Bands[3] := '011-038-165-206';
Bands[4] := '011-079-073-122';
Bands[5] := '011-234-233-202';
Bands[6] := '011-124-015-060';
Bands[7] := '011-124-095-076';
Bands[8] := '011-123-111-045';
Bands[9] := '011-083-234-241';
Bands[10] := '011-073-240-225';
Bands[11] := '011-243-055-207';
Bands[12] := '011-218-121-239';
Bands[13] := '011-187-085-053';
Bands[14] := '011-160-030-145';
Bands[15] := '011-095-010-115';
Bands[16] := '011-120-113-225';
Bands[17] := '011-243-055-088';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-236-183-088';
Bands[19] := '011-059-174-236';
Bands[20] := '011-117-252-242';
Bands[21] := '011-026-178-253';
Bands[22] := '011-128-094-175';
Bands[23] := '011-215-183-055';
Bands[24] := '011-154-016-252';
Bands[25] := '011-064-138-252';
Bands[26] := '011-030-232-096';
Bands[27] := '011-087-035-038';
Bands[28] := '011-187-056-043';
Bands[29] := '011-134-211-124';
Bands[30] := '011-080-068-055';
Bands[31] := '011-200-177-048';
Bands[32] := '011-205-173-019';
Bands[33] := '011-163-019-072';
Bands[34] := '011-139-155-168';
end;

procedure TBandColorData.Sample18;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 18;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-072-091-170';
Bands[2] := '011-064-115-100';
Bands[3] := '011-039-013-083';
Bands[4] := '011-122-165-010';
Bands[5] := '011-222-053-149';
Bands[6] := '011-116-086-040';
Bands[7] := '011-048-019-135';
Bands[8] := '011-105-037-037';
Bands[9] := '011-184-109-189';
Bands[10] := '011-232-209-235';
Bands[11] := '011-064-038-126';
Bands[12] := '011-193-110-087';
Bands[13] := '011-096-037-077';
Bands[14] := '011-070-153-137';
Bands[15] := '011-166-062-067';
Bands[16] := '011-007-234-054';
Bands[17] := '011-134-048-106';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-119-132-164';
Bands[19] := '011-249-190-056';
Bands[20] := '011-197-145-207';
Bands[21] := '011-249-096-114';
Bands[22] := '011-249-088-054';
Bands[23] := '011-203-012-107';
Bands[24] := '011-169-020-168';
Bands[25] := '011-211-012-109';
Bands[26] := '011-006-009-065';
Bands[27] := '011-216-139-181';
Bands[28] := '011-192-017-205';
Bands[29] := '011-046-029-068';
Bands[30] := '011-218-088-166';
Bands[31] := '011-015-229-124';
Bands[32] := '011-206-120-186';
Bands[33] := '011-163-019-072';
Bands[34] := '011-225-087-184';
end;

procedure TBandColorData.Sample19;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 19;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-111-120-220';
Bands[2] := '011-040-172-198';
Bands[3] := '011-202-197-141';
Bands[4] := '011-182-139-026';
Bands[5] := '011-215-253-238';
Bands[6] := '011-024-215-124';
Bands[7] := '011-232-088-021';
Bands[8] := '011-165-098-103';
Bands[9] := '011-057-230-229';
Bands[10] := '011-172-159-117';
Bands[11] := '011-082-097-085';
Bands[12] := '011-050-241-095';
Bands[13] := '011-121-131-137';
Bands[14] := '011-239-068-104';
Bands[15] := '011-069-193-041';
Bands[16] := '011-020-144-173';
Bands[17] := '011-215-216-071';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-014-014-059';
Bands[19] := '011-206-168-126';
Bands[20] := '011-098-246-147';
Bands[21] := '011-070-079-195';
Bands[22] := '011-121-170-138';
Bands[23] := '011-111-053-031';
Bands[24] := '011-041-081-169';
Bands[25] := '011-205-105-116';
Bands[26] := '011-057-027-056';
Bands[27] := '011-013-102-230';
Bands[28] := '011-100-019-096';
Bands[29] := '011-131-095-175';
Bands[30] := '011-138-156-179';
Bands[31] := '011-081-088-141';
Bands[32] := '011-171-133-240';
Bands[33] := '011-163-019-072';
Bands[34] := '011-230-191-238';
end;

procedure TBandColorData.Sample20;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 20;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-120-073-221';
Bands[2] := '011-014-043-067';
Bands[3] := '011-172-142-007';
Bands[4] := '011-098-108-202';
Bands[5] := '011-119-242-033';
Bands[6] := '011-037-178-009';
Bands[7] := '011-054-203-166';
Bands[8] := '011-060-244-099';
Bands[9] := '011-133-050-212';
Bands[10] := '011-036-143-154';
Bands[11] := '011-022-062-043';
Bands[12] := '011-134-049-133';
Bands[13] := '011-121-078-006';
Bands[14] := '011-188-240-113';
Bands[15] := '011-217-250-166';
Bands[16] := '011-018-132-019';
Bands[17] := '011-092-007-111';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-231-114-164';
Bands[19] := '011-056-020-081';
Bands[20] := '011-175-024-097';
Bands[21] := '011-248-035-110';
Bands[22] := '011-231-189-177';
Bands[23] := '011-006-209-087';
Bands[24] := '011-053-239-033';
Bands[25] := '011-227-121-021';
Bands[26] := '011-239-113-001';
Bands[27] := '011-217-019-044';
Bands[28] := '011-193-105-004';
Bands[29] := '011-084-248-144';
Bands[30] := '011-134-136-132';
Bands[31] := '011-047-122-025';
Bands[32] := '011-116-190-176';
Bands[33] := '011-163-019-072';
Bands[34] := '011-100-183-093';
end;

procedure TBandColorData.Sample21;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 21;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := False;
StandardPaint := True;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-019-095-031';
Bands[2] := '011-053-221-006';
Bands[3] := '011-244-008-011';
Bands[4] := '011-148-061-047';
Bands[5] := '011-175-236-072';
Bands[6] := '011-100-219-081';
Bands[7] := '011-232-074-023';
Bands[8] := '011-206-083-060';
Bands[9] := '011-147-067-201';
Bands[10] := '011-025-091-015';
Bands[11] := '011-238-087-230';
Bands[12] := '011-000-223-240';
Bands[13] := '011-217-254-107';
Bands[14] := '011-232-236-135';
Bands[15] := '011-008-139-057';
Bands[16] := '011-007-096-152';
Bands[17] := '011-093-147-149';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-254-062-163';
Bands[19] := '011-142-226-099';
Bands[20] := '011-185-248-002';
Bands[21] := '011-032-040-203';
Bands[22] := '011-197-008-093';
Bands[23] := '011-117-131-121';
Bands[24] := '011-097-003-192';
Bands[25] := '011-030-115-235';
Bands[26] := '011-138-190-245';
Bands[27] := '011-072-029-198';
Bands[28] := '011-014-175-117';
Bands[29] := '011-077-165-242';
Bands[30] := '011-145-139-194';
Bands[31] := '011-113-116-008';
Bands[32] := '011-081-206-041';
Bands[33] := '011-163-019-072';
Bands[34] := '011-247-219-049';
end;

procedure TBandColorData.Sample22;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 5;
BandWidth := 11;
StandardColor := 21;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := True;
SquareSym := False;
RandomPaint := False;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '005-100-149-237';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-254-254-254';
Bands[2] := '011-253-253-253';
Bands[3] := '011-252-252-252';
Bands[4] := '011-251-251-251';
Bands[5] := '011-250-250-250';
Bands[6] := '011-249-249-249';
Bands[7] := '011-248-248-248';
Bands[8] := '011-247-247-247';
Bands[9] := '011-246-246-246';
Bands[10] := '011-245-245-245';
Bands[11] := '011-244-244-244';
Bands[12] := '011-243-243-243';
Bands[13] := '011-242-242-242';
Bands[14] := '011-241-241-241';
Bands[15] := '011-240-240-240';
Bands[16] := '011-239-239-239';
Bands[17] := '011-238-238-238';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-237-237-237';
Bands[19] := '011-236-236-236';
Bands[20] := '011-235-235-235';
Bands[21] := '011-234-234-234';
Bands[22] := '011-233-233-233';
Bands[23] := '011-232-232-232';
Bands[24] := '011-231-231-231';
Bands[25] := '011-230-230-230';
Bands[26] := '011-229-229-229';
Bands[27] := '011-228-228-228';
Bands[28] := '011-227-227-227';
Bands[29] := '011-226-226-226';
Bands[30] := '011-225-225-225';
Bands[31] := '011-224-224-224';
Bands[32] := '011-223-223-223';
Bands[33] := '011-222-222-222';
Bands[34] := '011-221-221-221';
end;

procedure TBandColorData.Sample23;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 5;
BandWidth := 11;
StandardColor := 21;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := True;
SquareSym := False;
RandomPaint := False;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '005-255-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-254-254-254';
Bands[2] := '011-253-253-253';
Bands[3] := '011-252-252-252';
Bands[4] := '011-251-251-251';
Bands[5] := '011-250-250-250';
Bands[6] := '011-249-249-249';
Bands[7] := '011-248-248-248';
Bands[8] := '011-247-247-247';
Bands[9] := '011-246-246-246';
Bands[10] := '011-245-245-245';
Bands[11] := '011-244-244-244';
Bands[12] := '011-243-243-243';
Bands[13] := '011-242-242-242';
Bands[14] := '011-241-241-241';
Bands[15] := '011-240-240-240';
Bands[16] := '011-239-239-239';
Bands[17] := '011-238-238-238';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-237-237-237';
Bands[19] := '011-236-236-236';
Bands[20] := '011-235-235-235';
Bands[21] := '011-234-234-234';
Bands[22] := '011-233-233-233';
Bands[23] := '011-232-232-232';
Bands[24] := '011-231-231-231';
Bands[25] := '011-230-230-230';
Bands[26] := '011-229-229-229';
Bands[27] := '011-228-228-228';
Bands[28] := '011-227-227-227';
Bands[29] := '011-226-226-226';
Bands[30] := '011-225-225-225';
Bands[31] := '011-224-224-224';
Bands[32] := '011-223-223-223';
Bands[33] := '011-222-222-222';
Bands[34] := '011-221-221-221';
end;

procedure TBandColorData.ReadBandInfoTestData;
begin
//BlindColorCount := 1;
//StripWidth := 1;
//BandWidth := 11;
//StandardColor := 16;
//WantContour := True;
//WantShirtColor := False;
//SquareBitmap := False;
//HorizontalBitmap := False;
//SquareSym := False;
//RandomPaint := False;
//StandardPaint := True;
//MonoPaint := False;

//BandInfo := Width-Red-Green-Blue-Contour-Alpha;
Bands[0] := '001-000-000-080-000-255';
Bands[1] := '011-064-094-103-000-255';
Bands[2] := '011-114-042-071-000-255';
Bands[3] := '011-084-132-243-000-255';
Bands[4] := '011-006-238-229-000-255';
Bands[5] := '011-044-083-200-000-255';
Bands[6] := '011-141-148-002-000-255';
Bands[7] := '011-150-226-093-000-255';
Bands[8] := '011-202-150-061-000-255';
Bands[9] := '011-171-254-161-000-255';
Bands[10] := '011-166-085-165-000-255';
Bands[11] := '011-032-001-143-000-255';
Bands[12] := '011-066-088-134-000-255';
Bands[13] := '011-168-229-034-000-255';
Bands[14] := '011-011-219-228-000-255';
Bands[15] := '011-228-229-163-000-255';
Bands[16] := '011-117-181-114-000-255';
Bands[17] := '011-198-037-030-000-255';
Bands[18] := '011-074-138-198-000-255';
Bands[19] := '011-065-130-246-000-255';
Bands[20] := '011-246-198-221-000-255';
Bands[21] := '011-210-180-140-000-255';
Bands[22] := '011-065-181-128-000-255';
Bands[23] := '011-125-121-158-000-255';
Bands[24] := '011-014-132-092-000-255';
Bands[25] := '011-042-198-152-000-255';
Bands[26] := '011-163-085-114-000-255';
Bands[27] := '011-127-033-228-000-255';
Bands[28] := '011-208-096-103-000-255';
Bands[29] := '011-128-233-199-000-255';
Bands[30] := '011-015-001-052-000-255';
Bands[31] := '011-231-022-084-000-255';
Bands[32] := '011-181-152-035-000-255';
Bands[33] := '011-159-111-236-000-255';
Bands[34] := '011-152-152-183-000-255';
Bands[35] := '255-051-051-051-000-255';
end;

end.
