`timescale 100ns / 100ns



module gen_511k_tb ();

  parameter cycles_ena_on   = 1;  //   oena active  (oclk)
  parameter cycles_ena_off  = 1;  //   oena passive (oclk)
  parameter cycles_reset    = 1;  //   orst active  (oclk)  
  parameter clk_period   =  200;  //   oclk period ns
  parameter clk_delay    =    0;  //   oclk initial delay 

  reg clk;      
  wire clk_511k;    
  
  gen_511k   my_gen(
     .clk(clk),
     .clk_511k(clk_511k)
   );   

 reg [24:0] clk_counter;  
 reg [24:0] clk511_counter;  
 
// Clock generation
 always begin
 # (clk_delay);
   forever # (clk_period/2) clk = ~clk;
 end  
 
// Initial statement 
 initial begin
  #0    clk   = 1'b0;
        clk_counter = 0;
        clk511_counter = 0;
// Reset  
  //#0           rst   = 1'bX;
  //#0           rst   = 1'b0;
  //# ( 2*clk_period *cycles_reset) rst   = 1'b1;
  //# ( 2*clk_period *cycles_reset) rst   = 1'b0;
// Stop
//  # `TB_STOP   $stop;
 end
 
always begin 
 @( posedge clk_511k );
    clk511_counter <=  clk511_counter + 1;
end // always 
 
 
 always begin 
 @( posedge clk );
   if (clk_counter == 5000000) begin
     //$display("clk_5M: 5M;   clk_511k: %d\n", clk511_counter); 
     $display("clk_5M: 5M;   clk_511k: %d", clk511_counter); 
     clk_counter    <= 1;
     clk511_counter <= 0;
   end       
   else
     clk_counter    <=  clk_counter + 1;
 end // always 

endmodule
// eof
