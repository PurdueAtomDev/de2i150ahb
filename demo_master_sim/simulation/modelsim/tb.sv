//
`timescale 1ns / 1ns

module tb ();

   logic clk    = 1'b0;
   logic reset_n  = 1'b0;

   
   localparam  CLOCK_PERIOD            = 10; // Clock period in ns
   localparam  INITIAL_RESET_CYCLES    = 3;  // Number of cycles to reset when simulation starts
   
   AHB_master_bfm dut(
	.clock(clk),
	.reset_n(reset_n)
   );
  
   test_program  tp();
   
   // Clock signal generator
   always begin
      #(CLOCK_PERIOD / 2);
      clk = ~clk;
   end
   
   // Initial reset
   initial begin
      repeat(INITIAL_RESET_CYCLES) @(posedge clk);
      reset_n = 1'b0;
      repeat(INITIAL_RESET_CYCLES) @(posedge clk);
        reset_n = 1'b1;	
   end

endmodule 



