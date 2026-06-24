unit RiggVar.FB.ParamDef;

interface

uses
  RiggVar.FB.Def;

type
  TFederParamDef = class
  public const
    fp_Unknown = 0;

    fp_x1 = 1;
    fp_x2 = 2;
    fp_x3 = 3;
    fp_x4 = 4;

    fp_y1 = 5;
    fp_y2 = 6;
    fp_y3 = 7;
    fp_y4 = 8;

    fp_Z = 9;
    fp_z1 = 10;
    fp_z2 = 11;
    fp_z3 = 12;
    fp_z4 = 13;

    fp_L = 14;
    fp_l1 = 15;
    fp_l2 = 16;
    fp_l3 = 17;
    fp_l4 = 18;

    fp_K = 19;
    fp_k1 = 20;
    fp_k2 = 21;
    fp_k3 = 22;
    fp_k4 = 23;

    fp_ox = 24;
    fp_oy = 25;
    fp_oz = 26;

    fp_Attenuation = 27;
    fp_Grenze = 28;
    fp_Range = 29;
    fp_AbsoluteRange = 30;

    fp_T = 31;
    fp_t1 = 32;
    fp_t2 = 33;
    fp_t3 = 34;
    fp_t4 = 35;

    fp_trx = 36;
    fp_try = 37;
    fp_trt = 38;
    fp_trs = 39;

    fp_rx = 40;
    fp_ry = 41;
    fp_rz = 42;

    fp_tx = 43;
    fp_ty = 44;
    fp_cz = 45;

    fp_h = 46;
    fp_s = 47;
    fp_pa = 48;

    fp_iv = 49;
    fp_iw = 50;
    fp_jv = 51;
    fp_jw = 52;

    fp_px = 53;
    fp_py = 54;
    fp_va = 55;
    fp_np = 56;
    fp_fp = 57;

    fp_0 = 58;
    fp_1 = 59;
    fp_2 = 60;
    fp_3 = 61;
    fp_4 = 62;
    fp_5 = 63;
    fp_6 = 64;
    fp_7 = 65;
    fp_8 = 66;
    fp_9 = 67;

    fp_bpr = 68;
    fp_bpx = 69;
    fp_bpy = 70;
    fp_bpa = 71;
    fp_bs1 = 72;
    fp_bs2 = 73;
    fp_bcf = 74;
    fp_bcd = 75;
    fp_bcz = 76;

    fp_orx = 77;
    fp_ory = 78;
    fp_orz = 79;

    fp_l1x = 80;
    fp_l1y = 81;
    fp_l1z = 82;

    fp_l2x = 83;
    fp_l2y = 84;
    fp_l2z = 85;

    fp_l3x = 86;
    fp_l3y = 87;
    fp_l3z = 88;

    fp_l4x = 89;
    fp_l4y = 90;
    fp_l4z = 91;

    fp_BandSelected = 92;

    fp_BandCount = 93;
    fp_BandDistributionX = 94;
    fp_BandDistributionY = 95;

    fp_BandWidth = 96;

    fp_LabelTextX = 97;
    fp_LabelTextY = 98;
    fp_LabelTextZ = 99;

    fp_Pan = 100;

    fp_Controller = 101;
    fp_Winkel = 102;
    fp_Vorstag = 103;
    fp_Wante = 104;
    fp_Woben = 105;
    fp_SalingH = 106;
    fp_SalingA = 107;
    fp_SalingL = 108;
    fp_SalingW = 109;
    fp_MastfallF0C = 110;
    fp_MastfallF0F = 111;
    fp_MastfallVorlauf = 112;
    fp_Biegung = 113;
    fp_D0X = 114;

    fp_x12 = 115;
    fp_y12 = 116;
    fp_z12 = 117;

    fp_ParamSliceHeight = 118;
    fp_ParamCapValue = 119;

    fp_ParamY3f = 120;
    fp_ParamL3f = 121;
    fp_ParamLf = 122;

    fp_Coord0 = 123;
    fp_Coord1 = 124;
    fp_Coord2 = 125;
    fp_Coord3 = 126;

    fp_ParamEggX = 127;
    fp_ParamEggZ = 128;

    fp_kw = 129;
    fp_mz = 130;

    fp_ParamStepCount = 131;
    fp_ParamStepWidthFactor = 132;
    fp_ParamLoopSectionFactor = 133;
    fp_ParamIndexOfFirst = 134;
    fp_ParamIndexOfSecond = 135;
    fp_ParamShortPolyMinLength = 136;
    fp_ParamLoopDataX = 137;
    fp_ParamLoopDataY = 138;

    fp_DiscreteValue = 139;

    fp_NorthCapValue = 140;
    fp_SouthCapValue = 141;
    fp_EastCapValue = 142;
    fp_WestCapValue = 143;

    class function Encode(fp: TFederParam): Integer;
    class function Decode(fi: Integer): TFederParam;
  end;

implementation

{ TFederParamDef }

class function TFederParamDef.Decode(fi: Integer): TFederParam;
begin
  case fi of
    fp_DiscreteValue: result := fpDiscreteValue;
    fp_x1: result := fpx1;
    fp_x2: result := fpx2;
    fp_x3: result := fpx3;
    fp_x4: result := fpx4;
    fp_y1: result := fpy1;
    fp_y2: result := fpy2;
    fp_y3: result := fpy3;
    fp_y4: result := fpy4;
    fp_Z: result := fpZ;
    fp_z1: result := fpz1;
    fp_z2: result := fpz2;
    fp_z3: result := fpz3;
    fp_z4: result := fpz4;
    fp_L: result := fpL;
    fp_l1: result := fpl1;
    fp_l2: result := fpl2;
    fp_l3: result := fpl3;
    fp_l4: result := fpl4;
    fp_K: result := fpK;
    fp_k1: result := fpk1;
    fp_k2: result := fpk2;
    fp_k3: result := fpk3;
    fp_k4: result := fpk4;
    fp_ox: result := fpox;
    fp_oy: result := fpoy;
    fp_oz: result := fpoz;
    fp_Attenuation: result := fpAttenuation;
    fp_Grenze: result := fpGrenze;
    fp_Range: result := fpRange;
    fp_AbsoluteRange: result := fpAbsoluteRange;
    fp_T: result := fpT;
    fp_t1: result := fpt1;
    fp_t2: result := fpt2;
    fp_t3: result := fpt3;
    fp_t4: result := fpt4;
    fp_trx: result := fptrx;
    fp_try: result := fptry;
    fp_trt: result := fptrt;
    fp_trs: result := fptrs;
    fp_rx: result := fprx;
    fp_ry: result := fpry;
    fp_rz: result := fprz;
    fp_tx: result := fptx;
    fp_ty: result := fpty;
    fp_cz: result := fpcz;
    fp_h: result := fph;
    fp_s: result := fps;
    fp_pa: result := fppa;
    fp_px: result := fppx;
    fp_py: result := fppy;
    fp_0: result := fp0;
    fp_1: result := fp1;
    fp_2: result := fp2;
    fp_3: result := fp3;
    fp_4: result := fp4;
    fp_5: result := fp5;
    fp_6: result := fp6;
    fp_7: result := fp7;
    fp_8: result := fp8;
    fp_9: result := fp9;
    fp_bpr: result := fpbpr;
    fp_bpx: result := fpbpx;
    fp_bpy: result := fpbpy;
    fp_bpa: result := fpbpa;
    fp_bs1: result := fpbs1;
    fp_bs2: result := fpbs2;
    fp_bcf: result := fpbcf;
    fp_bcd: result := fpbcd;
    fp_bcz: result := fpbcz;
    fp_l1x: result := fpl1x;
    fp_l1y: result := fpl1y;
    fp_l1z: result := fpl1z;
    fp_l2x: result := fpl2x;
    fp_l2y: result := fpl2y;
    fp_l2z: result := fpl2z;
    fp_l3x: result := fpl3x;
    fp_l3y: result := fpl3y;
    fp_l3z: result := fpl3z;
    fp_l4x: result := fpl4x;
    fp_l4y: result := fpl4y;
    fp_l4z: result := fpl4z;
    fp_BandSelected: result := fpBandSelected;
    fp_BandCount: result := fpBandCount;
    fp_BandDistributionX: result := fpBandDistributionX;
    fp_BandDistributionY: result := fpBandDistributionY;
    fp_BandWidth: result := fpBandWidth;
    fp_LabelTextX: result := fpLabelTextX;
    fp_LabelTextY: result := fpLabelTextY;
    fp_LabelTextZ: result := fpLabelTextZ;
    fp_Pan: result := fpPan;
    fp_Controller: result := fpController;
    fp_Winkel: result := fpWinkel;
    fp_Vorstag: result := fpVorstag;
    fp_Wante: result := fpWante;
    fp_Woben: result := fpWoben;
    fp_SalingH: result := fpSalingH;
    fp_SalingA: result := fpSalingA;
    fp_SalingL: result := fpSalingL;
    fp_SalingW: result := fpSalingW;
    fp_MastfallF0C: result := fpMastfallF0C;
    fp_MastfallF0F: result := fpMastfallF0F;
    fp_MastfallVorlauf: result := fpMastfallVorlauf;
    fp_Biegung: result := fpBiegung;
    fp_D0X: result := fpD0X;
    fp_x12: result := fpx12;
    fp_y12: result := fpy12;
    fp_z12: result := fpz12;
    fp_ParamCapValue: result := fpParamCapValue;
    fp_ParamY3f: result := fpParamY3f;
    fp_ParamL3f: result := fpParamL3f;
    fp_ParamLf: result := fpParamLf;
    fp_Coord0: result := fpCoord0;
    fp_Coord1: result := fpCoord1;
    fp_Coord2: result := fpCoord2;
    fp_Coord3: result := fpCoord3;
    fp_NorthCapValue: result := fpNorthCapValue;
    fp_SouthCapValue: result := fpSouthCapValue;
    fp_EastCapValue: result := fpEastCapValue;
    fp_WestCapValue: result := fpWestCapValue;
    else
      result := fpUnknown;
  end;
end;

class function TFederParamDef.Encode(fp: TFederParam): Integer;
begin
  case fp of
    fpDiscreteValue: result := fp_DiscreteValue;
    fpx1: result := fp_x1;
    fpx2: result := fp_x2;
    fpx3: result := fp_x3;
    fpx4: result := fp_x4;
    fpy1: result := fp_y1;
    fpy2: result := fp_y2;
    fpy3: result := fp_y3;
    fpy4: result := fp_y4;
    fpZ: result := fp_Z;
    fpz1: result := fp_z1;
    fpz2: result := fp_z2;
    fpz3: result := fp_z3;
    fpz4: result := fp_z4;
    fpL: result := fp_L;
    fpl1: result := fp_l1;
    fpl2: result := fp_l2;
    fpl3: result := fp_l3;
    fpl4: result := fp_l4;
    fpK: result := fp_K;
    fpk1: result := fp_k1;
    fpk2: result := fp_k2;
    fpk3: result := fp_k3;
    fpk4: result := fp_k4;
    fpox: result := fp_ox;
    fpoy: result := fp_oy;
    fpoz: result := fp_oz;
    fpAttenuation: result := fp_Attenuation;
    fpGrenze: result := fp_Grenze;
    fpRange: result := fp_Range;
    fpAbsoluteRange: result := fp_AbsoluteRange;
    fpT: result := fp_T;
    fpt1: result := fp_t1;
    fpt2: result := fp_t2;
    fpt3: result := fp_t3;
    fpt4: result := fp_t4;
    fptrx: result := fp_trx;
    fptry: result := fp_try;
    fptrt: result := fp_trt;
    fptrs: result := fp_trs;
    fprx: result := fp_rx;
    fpry: result := fp_ry;
    fprz: result := fp_rz;
    fptx: result := fp_tx;
    fpty: result := fp_ty;
    fpcz: result := fp_cz;
    fph: result := fp_h;
    fps: result := fp_s;
    fppa: result := fp_pa;
    fppx: result := fp_px;
    fppy: result := fp_py;
    fp0: result := fp_0;
    fp1: result := fp_1;
    fp2: result := fp_2;
    fp3: result := fp_3;
    fp4: result := fp_4;
    fp5: result := fp_5;
    fp6: result := fp_6;
    fp7: result := fp_7;
    fp8: result := fp_8;
    fp9: result := fp_9;
    fpbpr: result := fp_bpr;
    fpbpx: result := fp_bpx;
    fpbpy: result := fp_bpy;
    fpbpa: result := fp_bpa;
    fpbs1: result := fp_bs1;
    fpbs2: result := fp_bs2;
    fpbcf: result := fp_bcf;
    fpbcd: result := fp_bcd;
    fpbcz: result := fp_bcz;
    fpl1x: result := fp_l1x;
    fpl1y: result := fp_l1y;
    fpl1z: result := fp_l1z;
    fpl2x: result := fp_l2x;
    fpl2y: result := fp_l2y;
    fpl2z: result := fp_l2z;
    fpl3x: result := fp_l3x;
    fpl3y: result := fp_l3y;
    fpl3z: result := fp_l3z;
    fpl4x: result := fp_l4x;
    fpl4y: result := fp_l4y;
    fpl4z: result := fp_l4z;
    fpBandSelected: result := fp_BandSelected;
    fpBandCount: result := fp_BandCount;
    fpBandDistributionX: result := fp_BandDistributionX;
    fpBandDistributionY: result := fp_BandDistributionY;
    fpBandWidth: result := fp_BandWidth;
    fpLabelTextX: result := fp_LabelTextX;
    fpLabelTextY: result := fp_LabelTextY;
    fpLabelTextZ: result := fp_LabelTextZ;
    fpPan: result := fp_Pan;
    fpController: result := fp_Controller;
    fpWinkel: result := fp_Winkel;
    fpVorstag: result := fp_Vorstag;
    fpWante: result := fp_Wante;
    fpWoben: result := fp_Woben;
    fpSalingH: result := fp_SalingH;
    fpSalingA: result := fp_SalingA;
    fpSalingL: result := fp_SalingL;
    fpSalingW: result := fp_SalingW;
    fpMastfallF0C: result := fp_MastfallF0C;
    fpMastfallF0F: result := fp_MastfallF0F;
    fpMastfallVorlauf: result := fp_MastfallVorlauf;
    fpBiegung: result := fp_Biegung;
    fpD0X: result := fp_D0X;
    fpx12: result := fp_x12;
    fpy12: result := fp_y12;
    fpz12: result := fp_z12;
    fpParamCapValue: result := fp_ParamCapValue;
    fpParamY3f: result := fp_ParamY3f;
    fpParamL3f: result := fp_ParamL3f;
    fpParamLf: result := fp_ParamLf;
    fpCoord0: result := fp_Coord0;
    fpCoord1: result := fp_Coord1;
    fpCoord2: result := fp_Coord2;
    fpCoord3: result := fp_Coord3;
    fpNorthCapValue: result := fp_NorthCapValue;
    fpSouthCapValue: result := fp_SouthCapValue;
    fpEastCapValue: result := fp_EastCapValue;
    fpWestCapValue: result := fp_WestCapValue;
    else
      result := fp_Unknown;
  end;
end;

end.
