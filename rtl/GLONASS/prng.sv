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

module prng_GLONASS();

// ***************************** GLONASS *****************************

reg REG_GLONASS_PRN511 [];
reg REG_GLONASS_PRN30_TimeMarker [];

reg  [9:1] PRN_codeCA;
reg [25:1] PRN_codeP;
reg counter_codeP;

// The P-code is truncated by resetting the shift register to its initial state at each second epoch.
// Thus, the GLONASS P-code efectively is only 1s long = 5110000 chips

PRN_codeCA <= {9{1'b1}};
PRN_codeP  <= {25{1'b1}};

PRN_codeCA <= {PRN_codeCA[8:1],(PRN_codeCA[5] ^ PRN_codeCA[9])};
PRN_codeP  <= {PRN_codeP[24:1],(PRN_codeP[3] ^ PRN_codeP[25])};

out_codeCA = PRN_codeCA[7];
out_codeP  = PRN_codeP[25];


endmodule
//EOF

