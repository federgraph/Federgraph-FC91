unit RiggVar.Bitmap.Bands01;

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
  RiggVar.Bitmap.Bands;

type
  TBandColorData01 = class(TBandColorData)
  protected
    procedure ColorSample0;
    procedure ColorSample1;
    procedure ColorSample2;
    procedure ColorSample3;
    procedure ColorSample4;
    procedure ColorSample5;
    procedure ColorSample6;
    procedure ColorSample7;
    procedure ColorSample8;
    procedure ColorSample9;
    procedure ColorSample07;
    procedure ColorSample11;
  public
    procedure IntitColorBands(SchemeID: Integer; AColorMix: Integer); override;
  end;

implementation

uses
  RiggVar.App.Main;

{ TBandColorData }

procedure TBandColorData01.IntitColorBands(SchemeID, AColorMix: Integer);
begin
  ColorMix := AColorMix;

  if MainConst.WantOldBandColors then
  begin
   inherited;
  end
  else
  case SchemeID of
    07: ColorSample07;
    11: ColorSample11;

    14: ColorSample0;
    15: ColorSample1;
    16: ColorSample2;
    17: ColorSample3;
    18: ColorSample4;
    19: ColorSample5;
    20: ColorSample6;
    21: ColorSample7;
    22: ColorSample8;
    23: ColorSample9;
  end;
end;

procedure TBandColorData01.ColorSample0;
begin
{ copied from old colors }

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

Exit;

{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 12;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := True;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-185-116-210';
Bands[2] := '011-154-205-068';
Bands[3] := '011-246-028-008';
Bands[4] := '011-201-123-020';
Bands[5] := '011-081-100-157';
Bands[6] := '011-032-201-068';
Bands[7] := '011-178-047-199';
Bands[8] := '011-178-150-222';
Bands[9] := '011-168-105-130';
Bands[10] := '011-098-094-193';
Bands[11] := '011-006-039-187';
Bands[12] := '011-246-194-211';
Bands[13] := '011-061-087-120';
Bands[14] := '011-217-121-033';
Bands[15] := '011-239-084-213';
Bands[16] := '011-111-248-023';
Bands[17] := '011-073-092-090';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-129-183-148';
Bands[19] := '011-113-098-164';
Bands[20] := '011-082-219-205';
Bands[21] := '011-147-141-195';
Bands[22] := '011-180-036-186';
Bands[23] := '011-215-081-111';
Bands[24] := '011-235-038-032';
Bands[25] := '011-155-040-246';
Bands[26] := '011-004-052-148';
Bands[27] := '011-204-056-163';
Bands[28] := '011-063-138-007';
Bands[29] := '011-104-149-251';
Bands[30] := '011-104-223-216';
Bands[31] := '011-066-246-201';
Bands[32] := '011-021-208-235';
Bands[33] := '011-216-101-007';
Bands[34] := '011-010-241-157';
end;

procedure TBandColorData01.ColorSample1;
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
Bands[19] := '011-032-178-170';
Bands[20] := '011-145-178-041';
Bands[21] := '011-226-132-216';
Bands[22] := '011-062-159-186';
Bands[23] := '011-246-074-210';
Bands[24] := '011-047-127-251';
Bands[25] := '011-002-187-132';
Bands[26] := '011-122-197-053';
Bands[27] := '011-107-142-035';
Bands[28] := '011-223-133-025';
Bands[29] := '011-154-205-050';
Bands[30] := '011-143-188-143';
Bands[31] := '011-144-238-144';
Bands[32] := '011-172-113-069';
Bands[33] := '011-161-167-101';
Bands[34] := '011-185-069-213';
end;

procedure TBandColorData01.ColorSample2;
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

Bands[0] := '001-000-000-080';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-064-094-103';
Bands[2] := '011-114-042-071';
Bands[3] := '011-084-132-243';
Bands[4] := '011-006-238-229';
Bands[5] := '011-044-083-200';
Bands[6] := '011-141-148-002';
Bands[7] := '011-150-226-093';
Bands[8] := '011-202-150-061';
Bands[9] := '011-171-254-161';
Bands[10] := '011-166-085-165';
Bands[11] := '011-032-001-143';
Bands[12] := '011-066-088-134';
Bands[13] := '011-168-229-034';
Bands[14] := '011-011-219-228';
Bands[15] := '011-228-229-163';
Bands[16] := '011-117-181-114';
Bands[17] := '011-198-037-030';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-074-138-198';
Bands[19] := '011-065-130-246';
Bands[20] := '011-246-198-221';
Bands[21] := '011-210-180-140';
Bands[22] := '011-065-181-128';
Bands[23] := '011-125-121-158';
Bands[24] := '011-014-132-092';
Bands[25] := '011-042-198-152';
Bands[26] := '011-163-085-114';
Bands[27] := '011-127-033-228';
Bands[28] := '011-208-096-103';
Bands[29] := '011-128-233-199';
Bands[30] := '011-015-001-052';
Bands[31] := '011-231-022-084';
Bands[32] := '011-181-152-035';
Bands[33] := '011-159-111-236';
Bands[34] := '011-152-152-183';
end;

procedure TBandColorData01.ColorSample3;
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
Bands[3] := '011-255-140-000';
Bands[4] := '011-250-128-114';
Bands[5] := '011-205-092-092';
Bands[6] := '011-240-128-128';
Bands[7] := '011-255-182-193';
Bands[8] := '011-240-128-128';
Bands[9] := '011-147-112-219';
Bands[10] := '011-232-209-235';
Bands[11] := '011-218-112-214';
Bands[12] := '011-255-182-193';
Bands[13] := '011-240-128-128';
Bands[14] := '011-070-153-137';
Bands[15] := '011-240-128-128';
Bands[16] := '011-255-140-000';
Bands[17] := '011-134-048-106';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-119-132-164';
Bands[19] := '011-255-105-180';
Bands[20] := '011-197-145-207';
Bands[21] := '011-249-096-114';
Bands[22] := '011-249-088-054';
Bands[23] := '011-255-105-180';
Bands[24] := '011-255-192-203';
Bands[25] := '011-238-130-238';
Bands[26] := '011-218-112-214';
Bands[27] := '011-186-085-211';
Bands[28] := '011-106-090-205';
Bands[29] := '011-106-090-205';
Bands[30] := '011-106-090-205';
Bands[31] := '011-148-000-211';
Bands[32] := '011-153-050-204';
Bands[33] := '011-163-019-072';
Bands[34] := '011-225-087-184';
end;

procedure TBandColorData01.ColorSample4;
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
Bands[12] := '011-000-128-128';
Bands[13] := '011-121-131-137';
Bands[14] := '011-239-068-104';
Bands[15] := '011-240-128-128';
Bands[16] := '011-020-144-173';
Bands[17] := '011-215-216-071';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-065-105-225';
Bands[19] := '011-206-168-126';
Bands[20] := '011-098-246-147';
Bands[21] := '011-070-079-195';
Bands[22] := '011-121-170-138';
Bands[23] := '011-240-230-140';
Bands[24] := '011-100-149-237';
Bands[25] := '011-244-164-096';
Bands[26] := '011-205-092-092';
Bands[27] := '011-250-128-114';
Bands[28] := '011-100-019-096';
Bands[29] := '011-131-095-175';
Bands[30] := '011-138-156-179';
Bands[31] := '011-081-088-141';
Bands[32] := '011-171-133-240';
Bands[33] := '011-163-019-072';
Bands[34] := '011-230-191-238';
end;

procedure TBandColorData01.ColorSample5;
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
Bands[19] := '011-255-099-071';
Bands[20] := '011-175-024-097';
Bands[21] := '011-248-035-110';
Bands[22] := '011-231-189-177';
Bands[23] := '011-006-209-087';
Bands[24] := '011-053-239-033';
Bands[25] := '011-227-121-021';
Bands[26] := '011-239-113-001';
Bands[27] := '011-217-019-044';
Bands[28] := '011-193-105-004';
Bands[29] := '011-255-165-000';
Bands[30] := '011-134-136-132';
Bands[31] := '011-047-122-025';
Bands[32] := '011-116-190-176';
Bands[33] := '011-163-019-072';
Bands[34] := '011-100-183-093';
end;

procedure TBandColorData01.ColorSample6;
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
Bands[18] := '011-135-206-235';
Bands[19] := '011-142-226-099';
Bands[20] := '011-185-248-002';
Bands[21] := '011-095-158-160';
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

procedure TBandColorData01.ColorSample7;
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
Bands[31] := '011-255-215-000';
Bands[32] := '011-049-197-070';
Bands[33] := '011-255-140-000';
Bands[34] := '011-132-029-143';
end;

procedure TBandColorData01.ColorSample8;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 12;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := True;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-105-055-105';
Bands[2] := '011-251-238-205';
Bands[3] := '011-015-040-205';
Bands[4] := '011-100-026-168';
Bands[5] := '011-040-201-053';
Bands[6] := '011-118-099-121';
Bands[7] := '011-044-030-237';
Bands[8] := '011-159-144-167';
Bands[9] := '011-005-144-197';
Bands[10] := '011-080-199-067';
Bands[11] := '011-139-155-155';
Bands[12] := '011-140-231-139';
Bands[13] := '011-206-201-064';
Bands[14] := '011-161-036-243';
Bands[15] := '011-126-036-190';
Bands[16] := '011-168-091-017';
Bands[17] := '011-020-140-069';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-145-182-239';
Bands[19] := '011-082-190-129';
Bands[20] := '011-152-249-042';
Bands[21] := '011-061-181-254';
Bands[22] := '011-229-185-077';
Bands[23] := '011-047-247-218';
Bands[24] := '011-122-251-028';
Bands[25] := '011-149-063-108';
Bands[26] := '011-221-168-029';
Bands[27] := '011-153-155-207';
Bands[28] := '011-003-042-056';
Bands[29] := '011-113-145-078';
Bands[30] := '011-134-246-218';
Bands[31] := '011-040-201-090';
Bands[32] := '011-010-182-187';
Bands[33] := '011-152-150-166';
Bands[34] := '011-254-016-002';
end;

procedure TBandColorData01.ColorSample9;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 12;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := True;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-038-182-052';
Bands[2] := '011-097-165-088';
Bands[3] := '011-073-200-244';
Bands[4] := '011-003-058-005';
Bands[5] := '011-179-149-088';
Bands[6] := '011-124-236-208';
Bands[7] := '011-251-067-122';
Bands[8] := '011-150-243-051';
Bands[9] := '011-034-147-010';
Bands[10] := '011-111-052-136';
Bands[11] := '011-073-077-254';
Bands[12] := '011-135-214-047';
Bands[13] := '011-220-120-037';
Bands[14] := '011-034-132-223';
Bands[15] := '011-005-042-097';
Bands[16] := '011-047-108-254';
Bands[17] := '011-167-056-003';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-226-091-108';
Bands[19] := '011-246-058-015';
Bands[20] := '011-159-230-253';
Bands[21] := '011-007-046-030';
Bands[22] := '011-052-188-243';
Bands[23] := '011-238-104-095';
Bands[24] := '011-237-138-164';
Bands[25] := '011-044-068-045';
Bands[26] := '011-237-065-124';
Bands[27] := '011-237-017-030';
Bands[28] := '011-063-170-234';
Bands[29] := '011-112-129-182';
Bands[30] := '011-125-241-002';
Bands[31] := '011-056-115-093';
Bands[32] := '011-085-093-228';
Bands[33] := '011-213-003-222';
Bands[34] := '011-141-059-109';
end;

procedure TBandColorData01.ColorSample07;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 12;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := True;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-075-083-211';
Bands[2] := '011-144-180-104';
Bands[3] := '011-207-126-071';
Bands[4] := '011-137-152-006';
Bands[5] := '011-132-201-176';
Bands[6] := '011-069-092-174';
Bands[7] := '011-026-147-218';
Bands[8] := '011-019-240-153';
Bands[9] := '011-183-169-094';
Bands[10] := '011-239-231-206';
Bands[11] := '011-071-227-153';
Bands[12] := '011-094-251-166';
Bands[13] := '011-146-234-085';
Bands[14] := '011-203-101-052';
Bands[15] := '011-049-235-221';
Bands[16] := '011-057-128-134';
Bands[17] := '011-077-086-189';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-160-182-211';
Bands[19] := '011-175-242-071';
Bands[20] := '011-120-086-224';
Bands[21] := '011-122-071-112';
Bands[22] := '011-236-179-008';
Bands[23] := '011-234-212-004';
Bands[24] := '011-174-112-228';
Bands[25] := '011-131-131-048';
Bands[26] := '011-209-074-114';
Bands[27] := '011-181-203-108';
Bands[28] := '011-095-190-170';
Bands[29] := '011-143-138-085';
Bands[30] := '011-100-251-073';
Bands[31] := '011-175-067-060';
Bands[32] := '011-172-124-117';
Bands[33] := '011-179-203-176';
Bands[34] := '011-241-191-217';
end;

procedure TBandColorData01.ColorSample11;
begin
{ ColorStripInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 12;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := True;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '011-056-063-087';
Bands[2] := '011-201-211-235';
Bands[3] := '011-143-030-019';
Bands[4] := '011-252-245-110';
Bands[5] := '011-052-227-158';
Bands[6] := '011-054-092-030';
Bands[7] := '011-198-155-056';
Bands[8] := '011-144-229-202';
Bands[9] := '011-086-023-072';
Bands[10] := '011-017-084-178';
Bands[11] := '011-116-044-232';
Bands[12] := '011-046-248-188';
Bands[13] := '011-177-103-178';
Bands[14] := '011-088-119-241';
Bands[15] := '011-082-027-200';
Bands[16] := '011-176-034-035';
Bands[17] := '011-165-208-062';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '011-230-085-077';
Bands[19] := '011-049-172-219';
Bands[20] := '011-191-248-239';
Bands[21] := '011-199-196-209';
Bands[22] := '011-046-104-225';
Bands[23] := '011-212-057-050';
Bands[24] := '011-236-181-213';
Bands[25] := '011-014-132-184';
Bands[26] := '011-001-222-166';
Bands[27] := '011-091-162-065';
Bands[28] := '011-086-073-199';
Bands[29] := '011-184-128-115';
Bands[30] := '011-150-213-131';
Bands[31] := '011-121-167-244';
Bands[32] := '011-015-159-115';
Bands[33] := '011-182-060-019';
Bands[34] := '011-247-077-023';
end;

end.
