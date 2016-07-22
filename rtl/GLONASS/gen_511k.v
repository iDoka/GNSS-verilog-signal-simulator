//`timescale 1ns / 100ps

`define DIV10  (5-1)
`define DIV50 (25-1)

module gen_511k (
          input   clk,
          output  clk_511k
   );

//wire clk_511k;
reg [3:0] div1 = 4'b0000; // :10
reg [3:0] div2 = 4'b0000; // :10
reg [5:0] div3 = 6'b000000; // :50

reg div_500k = 1'b0;
reg div_50k  = 1'b0;
reg div_11k  = 1'b0;
wire div_550k;

always @(posedge clk) begin
  if (div1==`DIV10)
    div1 <= 0;
  else
    div1 <= div1 + 1;

  if (div1==`DIV10)
    div_500k <= ~div_500k;
  else
    div_500k <= div_500k;
end

always @(posedge div_500k) begin
  if (div2==`DIV10)
    div2 <= 0;
  else
    div2 <= div2 + 1;

  if (div2==`DIV10)
    div_50k <= ~div_50k;
  else
    div_50k <=  div_50k;
end

assign div_550k = div_500k ^ div_50k;

always @(posedge div_550k) begin
  if (div3==`DIV50)
    div3 <= 0;
  else
    div3 <= div3 + 1;

  if (div3==`DIV50)
    div_11k <= ~div_11k;
  else
    div_11k <=  div_11k;
end

assign clk_511k = div_500k ^ div_11k;

// synthesis_off
// synthesis_on

endmodule
