unit RiggVar.Bitmap.Strips01;

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
  System.UIConsts,
  RiggVar.Bitmap.Strips;

type
  TStripColorData01 = class(TStripColorData)
  protected
    function GetBitmapColor1(j: Integer): TAlphaColor; override;
    function GetBitmapColor2(j: Integer): TAlphaColor; override;
    function GetBitmapColor3(j: Integer): TAlphaColor; override;
    function GetBitmapColor4(j: Integer): TAlphaColor; override;
    function GetBitmapColor5(j: Integer): TAlphaColor; override;
    function GetBitmapColor6(j: Integer): TAlphaColor; override;
    function GetBitmapColor7(j: Integer): TAlphaColor; override;
    function GetBitmapColor8(j: Integer): TAlphaColor; override;
    function GetBitmapColor9(j: Integer): TAlphaColor; override;
    function GetBitmapColor0(j: Integer): TAlphaColor; override;
  public
    function GetBitmapColor(SchemeID: Integer; j: Integer; Mix: Integer = 0): TAlphaColor; override;
  end;

implementation

function TStripColorData01.GetBitmapColor1(j: Integer): TAlphaColor;
begin
  { Rote Streifen }
  case j of
    1: result := MC(j, 255, 249, 249);
    2: result := MC(j, 255, 189, 189);
    3: result := MC(j, 255, 140, 140);
    4: result := MC(j, 255, 120, 120);
    5: result := MC(j, 255, 191, 191);
    6: result := MC(j, 255, 198, 198);
    7: result := MC(j, 255, 162, 162);
    8: result := MC(j, 255, 185, 185);
    9: result := MC(j, 255, 215, 215);
    10: result := MC(j, 255, 254, 254);
    11: result := MC(j, 255, 150, 150);
    12: result := MC(j, 255, 205, 205);
    13: result := MC(j, 255, 205, 206);
    14: result := MC(j, 255, 83, 83);
    15: result := MC(j, 255, 113, 113);
    16: result := MC(j, 255, 160, 160);
    17: result := MC(j, 255, 170, 170);
    18: result := MC(j, 255, 163, 163);
    19: result := MC(j, 255, 217, 217);
    20: result := MC(j, 255, 238, 238);
    21: result := MC(j, 255, 110, 110);
    22: result := MC(j, 255, 195, 195);
    23: result := MC(j, 255, 171, 171);
    24: result := MC(j, 255, 234, 234);
    25: result := MC(j, 255, 100, 100);
    26: result := MC(j, 255, 116, 116);
    27: result := MC(j, 255, 92, 92);
    28: result := MC(j, 255, 139, 139);
    29: result := MC(j, 255, 152, 152);
    30: result := MC(j, 255, 149, 149);
    31: result := MC(j, 255, 165, 165);
    32: result := MC(j, 255, 97, 97);
    33: result := MC(j, 255, 135, 135);
    34: result := MC(j, 255, 129, 129);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor2(j: Integer): TAlphaColor;
begin
  case j of
1: result := MC(j, 87, 50, 93);
2: result := MC(j, 226, 175, 106);
3: result := MC(j, 74, 157, 170);
4: result := MC(j, 61, 244, 140);
5: result := MC(j, 163, 19, 72);
6: result := MC(j, 108, 188, 168);
7: result := MC(j, 28, 7, 129);
8: result := MC(j, 122, 71, 59);
9: result := MC(j, 115, 155, 174);
10: result := MC(j, 251, 123, 38);
11: result := MC(j, 128, 40, 148);
12: result := MC(j, 212, 6, 92);
13: result := MC(j, 68, 106, 190);
14: result := MC(j, 11, 153, 250);
15: result := MC(j, 156, 139, 211);
16: result := MC(j, 66, 173, 232);
17: result := MC(j, 229, 131, 125);
18: result := MC(j, 150, 124, 192);
19: result := MC(j, 242, 109, 60);
20: result := MC(j, 37, 135, 120);
21: result := MC(j, 81, 7, 19);
22: result := MC(j, 130, 148, 215);
23: result := MC(j, 127, 117, 217);
24: result := MC(j, 211, 47, 231);
25: result := MC(j, 48, 108, 236);
26: result := MC(j, 125, 26, 156);
27: result := MC(j, 143, 231, 17);
28: result := MC(j, 177, 210, 172);
29: result := MC(j, 228, 58, 247);
30: result := MC(j, 19, 175, 32);
31: result := MC(j, 44, 198, 132);
32: result := MC(j, 33, 212, 20);
33: result := MC(j, 163, 19, 72);
34: result := MC(j, 12, 38, 61);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor3(j: Integer): TAlphaColor;
begin
  case j of
1: result := MC(j, 248, 29, 140);
2: result := MC(j, 12, 55, 213);
3: result := MC(j, 16, 118, 198);
4: result := MC(j, 159, 136, 99);
5: result := MC(j, 44, 132, 18);
6: result := MC(j, 217, 110, 243);
7: result := MC(j, 9, 66, 118);
8: result := MC(j, 131, 117, 0);
9: result := MC(j, 47, 162, 54);
10: result := MC(j, 197, 124, 43);
11: result := MC(j, 145, 196, 33);
12: result := MC(j, 254, 245, 225);
13: result := MC(j, 51, 31, 14);
14: result := MC(j, 163, 191, 223);
15: result := MC(j, 144, 129, 171);
16: result := MC(j, 50, 73, 185);
17: result := MC(j, 5, 38, 95);
18: result := MC(j, 241, 62, 22);
19: result := MC(j, 207, 31, 25);
20: result := MC(j, 30, 141, 163);
21: result := MC(j, 54, 222, 226);
22: result := MC(j, 135, 134, 160);
23: result := MC(j, 227, 54, 27);
24: result := MC(j, 82, 21, 59);
25: result := MC(j, 13, 16, 169);
26: result := MC(j, 211, 129, 11);
27: result := MC(j, 232, 91, 247);
28: result := MC(j, 34, 152, 224);
29: result := MC(j, 110, 105, 145);
30: result := MC(j, 118, 11, 122);
31: result := MC(j, 212, 250, 76);
32: result := MC(j, 84, 180, 115);
33: result := MC(j, 163, 19, 72);
34: result := MC(j, 0, 16, 2);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor4(j: Integer): TAlphaColor;
begin
  case j of
    1: result := MC(j, 82, 10, 151);
    2: result := MC(j, 231, 182, 147);
    3: result := MC(j, 236, 70, 89);
    4: result := MC(j, 146, 230, 226);
    5: result := MC(j, 22, 155, 219);
    6: result := MC(j, 123, 138, 71);
    7: result := MC(j, 230, 222, 220);
    8: result := MC(j, 85, 182, 221);
    9: result := MC(j, 236, 56, 118);
    10: result := MC(j, 212, 235, 88);
    11: result := MC(j, 91, 94, 92);
    12: result := MC(j, 159, 139, 185);
    13: result := MC(j, 232, 25, 86);
    14: result := MC(j, 240, 169, 164);
    15: result := MC(j, 11, 201, 169);
    16: result := MC(j, 29, 202, 9);
    17: result := MC(j, 217, 111, 57);
    18: result := MC(j, 162, 185, 115);
    19: result := MC(j, 227, 207, 104);
    20: result := MC(j, 145, 178, 41);
    21: result := MC(j, 226, 132, 216);
    22: result := MC(j, 62, 159, 186);
    23: result := MC(j, 246, 74, 210);
    24: result := MC(j, 47, 127, 251);
    25: result := MC(j, 2, 187, 132);
    26: result := MC(j, 122, 197, 53);
    27: result := MC(j, 115, 14, 192);
    28: result := MC(j, 223, 133, 25);
    29: result := MC(j, 74, 251, 197);
    30: result := MC(j, 91, 66, 142);
    31: result := MC(j, 10, 147, 13);
    32: result := MC(j, 172,113,69);
    33: result := MC(j, 161, 167, 101);
    34: result := MC(j, 185, 69, 213);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor5(j: Integer): TAlphaColor;
begin
  case j of
1: result := MC(j, 26, 104, 172);
2: result := MC(j, 31, 213, 175);
3: result := MC(j, 38, 165, 206);
4: result := MC(j, 79, 73, 122);
5: result := MC(j, 234, 233, 202);
6: result := MC(j, 124, 15, 60);
7: result := MC(j, 124, 95, 76);
8: result := MC(j, 123, 111, 45);
9: result := MC(j, 83, 234, 241);
10: result := MC(j, 73, 240, 225);
11: result := MC(j, 243, 55, 207);
12: result := MC(j, 218, 121, 239);
13: result := MC(j, 187, 85, 53);
14: result := MC(j, 160, 30, 145);
15: result := MC(j, 95, 10, 115);
16: result := MC(j, 120, 113, 225);
17: result := MC(j, 243, 55, 88);
18: result := MC(j, 236, 183, 88);
19: result := MC(j, 59, 174, 236);
20: result := MC(j, 117, 252, 242);
21: result := MC(j, 26, 178, 253);
22: result := MC(j, 128, 94, 175);
23: result := MC(j, 215, 183, 55);
24: result := MC(j, 154, 16, 252);
25: result := MC(j, 64, 138, 252);
26: result := MC(j, 30, 232, 96);
27: result := MC(j, 87, 35, 38);
28: result := MC(j, 187, 56, 43);
29: result := MC(j, 134, 211, 124);
30: result := MC(j, 80, 68, 55);
31: result := MC(j, 200, 177, 48);
32: result := MC(j, 205, 173, 19);
33: result := MC(j, 163, 19, 72);
34: result := MC(j, 139, 155, 168);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor6(j: Integer): TAlphaColor;
begin
  case j of
1: result := MC(j, 72, 91, 170);
2: result := MC(j, 64, 115, 100);
3: result := MC(j, 39, 13, 83);
4: result := MC(j, 122, 165, 10);
5: result := MC(j, 222, 53, 149);
6: result := MC(j, 116, 86, 40);
7: result := MC(j, 48, 19, 135);
8: result := MC(j, 105, 37, 37);
9: result := MC(j, 184, 109, 189);
10: result := MC(j, 232, 209, 235);
11: result := MC(j, 64, 38, 126);
12: result := MC(j, 193, 110, 87);
13: result := MC(j, 96, 37, 77);
14: result := MC(j, 70, 153, 137);
15: result := MC(j, 166, 62, 67);
16: result := MC(j, 7, 234, 54);
17: result := MC(j, 134, 48, 106);
18: result := MC(j, 119, 132, 164);
19: result := MC(j, 249, 190, 56);
20: result := MC(j, 197, 145, 207);
21: result := MC(j, 249, 96, 114);
22: result := MC(j, 249, 88, 54);
23: result := MC(j, 203, 12, 107);
24: result := MC(j, 169, 20, 168);
25: result := MC(j, 211, 12, 109);
26: result := MC(j, 6, 9, 65);
27: result := MC(j, 216, 139, 181);
28: result := MC(j, 192, 17, 205);
29: result := MC(j, 46, 29, 68);
30: result := MC(j, 218, 88, 166);
31: result := MC(j, 15, 229, 124);
32: result := MC(j, 206, 120, 186);
33: result := MC(j, 163, 19, 72);
34: result := MC(j, 225, 87, 184);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor7(j: Integer): TAlphaColor;
begin
  case j of
1: result := MC(j, 111, 120, 220);
2: result := MC(j, 40, 172, 198);
3: result := MC(j, 202, 197, 141);
4: result := MC(j, 182, 139, 26);
5: result := MC(j, 215, 253, 238);
6: result := MC(j, 24, 215, 124);
7: result := MC(j, 232, 88, 21);
8: result := MC(j, 165, 98, 103);
9: result := MC(j, 57, 230, 229);
10: result := MC(j, 172, 159, 117);
11: result := MC(j, 82, 97, 85);
12: result := MC(j, 50, 241, 95);
13: result := MC(j, 121, 131, 137);
14: result := MC(j, 239, 68, 104);
15: result := MC(j, 69, 193, 41);
16: result := MC(j, 20, 144, 173);
17: result := MC(j, 215, 216, 71);
18: result := MC(j, 14, 14, 59);
19: result := MC(j, 206, 168, 126);
20: result := MC(j, 98, 246, 147);
21: result := MC(j, 70, 79, 195);
22: result := MC(j, 121, 170, 138);
23: result := MC(j, 111, 53, 31);
24: result := MC(j, 41, 81, 169);
25: result := MC(j, 205, 105, 116);
26: result := MC(j, 57, 27, 56);
27: result := MC(j, 13, 102, 230);
28: result := MC(j, 100, 19, 96);
29: result := MC(j, 131, 95, 175);
30: result := MC(j, 138, 156, 179);
31: result := MC(j, 81, 88, 141);
32: result := MC(j, 171, 133, 240);
33: result := MC(j, 163, 19, 72);
34: result := MC(j, 230, 191, 238);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor8(j: Integer): TAlphaColor;
begin
  case j of
1: result := MC(j, 120, 73, 221);
2: result := MC(j, 14, 43, 67);
3: result := MC(j, 172, 142, 7);
4: result := MC(j, 98, 108, 202);
5: result := MC(j, 119, 242, 33);
6: result := MC(j, 37, 178, 9);
7: result := MC(j, 54, 203, 166);
8: result := MC(j, 60, 244, 99);
9: result := MC(j, 133, 50, 212);
10: result := MC(j, 36, 143, 154);
11: result := MC(j, 22, 62, 43);
12: result := MC(j, 134, 49, 133);
13: result := MC(j, 121, 78, 6);
14: result := MC(j, 188, 240, 113);
15: result := MC(j, 217, 250, 166);
16: result := MC(j, 18, 132, 19);
17: result := MC(j, 92, 7, 111);
18: result := MC(j, 231, 114, 164);
19: result := MC(j, 56, 20, 81);
20: result := MC(j, 175, 24, 97);
21: result := MC(j, 248, 35, 110);
22: result := MC(j, 231, 189, 177);
23: result := MC(j, 6, 209, 87);
24: result := MC(j, 53, 239, 33);
25: result := MC(j, 227, 121, 21);
26: result := MC(j, 239, 113, 1);
27: result := MC(j, 217, 19, 44);
28: result := MC(j, 193, 105, 4);
29: result := MC(j, 84, 248, 144);
30: result := MC(j, 134, 136, 132);
31: result := MC(j, 47, 122, 25);
32: result := MC(j, 116, 190, 176);
33: result := MC(j, 163, 19, 72);
34: result := MC(j, 100, 183, 93);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor9(j: Integer): TAlphaColor;
begin
  case j of
1: result := MC(j, 19, 95, 31);
2: result := MC(j, 53, 221, 6);
3: result := MC(j, 244, 8, 11);
4: result := MC(j, 148, 61, 47);
5: result := MC(j, 175, 236, 72);
6: result := MC(j, 100, 219, 81);
7: result := MC(j, 232, 74, 23);
8: result := MC(j, 206, 83, 60);
9: result := MC(j, 147, 67, 201);
10: result := MC(j, 25, 91, 15);
11: result := MC(j, 238, 87, 230);
12: result := MC(j, 0, 223, 240);
13: result := MC(j, 217, 254, 107);
14: result := MC(j, 232, 236, 135);
15: result := MC(j, 8, 139, 57);
16: result := MC(j, 7, 96, 152);
17: result := MC(j, 93, 147, 149);
18: result := MC(j, 254, 62, 163);
19: result := MC(j, 142, 226, 99);
20: result := MC(j, 185, 248, 2);
21: result := MC(j, 32, 40, 203);
22: result := MC(j, 197, 8, 93);
23: result := MC(j, 117, 131, 121);
24: result := MC(j, 97, 3, 192);
25: result := MC(j, 30, 115, 235);
26: result := MC(j, 138, 190, 245);
27: result := MC(j, 72, 29, 198);
28: result := MC(j, 14, 175, 117);
29: result := MC(j, 77, 165, 242);
30: result := MC(j, 145, 139, 194);
31: result := MC(j, 113, 116, 8);
32: result := MC(j, 81, 206, 41);
33: result := MC(j, 163, 19, 72);
34: result := MC(j, 247, 219, 49);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor0(j: Integer): TAlphaColor;
begin
  case j of
    1: result := MC(j, 206, 205, 159);
    2: result := MC(j, 104, 102, 51);
    3: result := MC(j, 121, 22, 57);
    4: result := MC(j, 154, 180, 53);
    5: result := MC(j, 172, 238, 196);
    6: result := MC(j, 130, 69, 246);
    7: result := MC(j, 5, 229, 175);
    8: result := MC(j, 231, 249, 218);
    9: result := MC(j, 253, 233, 42);
    10: result := MC(j, 157, 33, 145);
    11: result := MC(j, 237, 173, 173);
    12: result := MC(j, 42, 72, 16);
    13: result := MC(j, 76, 32, 214);
    14: result := MC(j, 48, 180, 132);
    15: result := MC(j, 64, 169, 153);
    16: result := MC(j, 235, 41, 157);
    17: result := MC(j, 160, 15, 210);
    18: result := MC(j, 140, 237, 224);
    19: result := MC(j, 188, 227, 31);
    20: result := MC(j, 254, 107, 32);
    21: result := MC(j, 247, 7, 24);
    22: result := MC(j, 166, 209, 180);
    23: result := MC(j, 111, 142, 88);
    24: result := MC(j, 36, 209, 78);
    25: result := MC(j, 70, 181, 119);
    26: result := MC(j, 47, 235, 44);
    27: result := MC(j, 214, 118, 249);
    28: result := MC(j, 250, 177, 215);
    29: result := MC(j, 37, 138, 219);
    30: result := MC(j, 207, 97, 52);
    31: result := MC(j, 98, 15, 4);
    32: result := MC(j, 49, 197, 70);
    33: result := MC(j, 163, 19, 72);
    34: result := MC(j, 132, 29, 143);
    else result := claGray;
  end;
end;

function TStripColorData01.GetBitmapColor(SchemeID, j, Mix: Integer): TAlphaColor;
begin
  ColorMix := Mix;
  case SchemeID of
    11: result := GetBitmapColor1(j);
    14: result := GetBitmapColor2(j);
    15: result := GetBitmapColor3(j);
    16: result := GetBitmapColor4(j);
    17: result := GetBitmapColor5(j);
    18: result := GetBitmapColor6(j);
    19: result := GetBitmapColor7(j);
    20: result := GetBitmapColor8(j);
    21: result := GetBitmapColor9(j);
    else
      result := GetBitmapColor0(j);
  end;
end;

end.
