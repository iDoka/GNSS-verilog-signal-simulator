//  $Id$
// *******************************************************************************
// ** Project    : GNSS Signal Generator
// ** URL        : https://github.com/iDoka/GNSS-verilog-signal-simulator
// ** Designer   : Dmitry Murzinov (kakstattakim@gmail.com)
// ** Module     : PRNG
// ** Description: generate PRNG-signals from desired Satellites
// ** Version    : $GlobalRev$
// ** Date       : $LastChangedDate$
// ** License    : MIT
// *******************************************************************************


//`include "prng.vh"

// PRS PRN


module prng_GPS();

PRN_SignalNumber [7:0]; // #1..37, #38..210
PRN_CodeCA_Delay [9:0]; // 5..950 (#1..37), 19..1021 (#38..210)

PRN_codeCA_G1
PRN_codeCA_G2

// ***************************** GPS *****************************
//                             1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
const int CodeCA_G2tap1[37] = {2, 3, 4, 5, 1, 2, 1, 2, 3, 2, 3, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 1, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 4, 1, 2, 4};
const int CodeCA_G2tap2[37] = {6, 7, 8, 9, 9,10, 8, 9,10, 3, 4, 6, 7, 8, 9,10, 4, 5, 6, 7, 8, 9, 3, 6, 7, 8, 9,10, 6, 7, 8, 9,10,10, 7, 8,10};
const int CodeCA_Delay[37]  = {5,6,7,8,17,18,139,140,141,251,252,254,255,256,257,258,469,470,471,472,473,474,509,512,513,514,515,516,859,860,861,862,863,950,947,948,950};
// index for this array - [GPS_PRN_Number]

reg [10:1] G1;
reg [10:1] G2;
reg StartMarker_CodeCA; // period 1ms

parameter G2_Tap1 = ;
parameter G2_Tap2 = ;
parameter CodeCA_Delay = ;



// Must be clocked at 1.023MHz
  G1 <= {10{1'b1}};
  G2 <= {10{1'b1}};

  G1 <= {G1[9:1],(G1[3] ^ G1[10])};
  G2 <= {G2[9:1],(G2[2] ^ G2[3] ^ G2[6] ^ G2[8] ^ G2[9] ^ G2[10])};

  PRN_codeCA = G1[10] ^ G2[CodeCA_G2tap1[GPS_PRN_Number]] ^ G2[CodeCA_G2tap2[GPS_PRN_Number]];
  //G2[10] // for Epoch detector :20


endmodule
//EOF

