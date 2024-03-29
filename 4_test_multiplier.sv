/////////////////////////////////////////////////////////////////////
// Design unit: test_multiplier
//            :
// File name  : test_multiplier.sv
//            :
// Description: Code for M4 Lab exercise
//            : Basic testbench for multiplier
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Mark Zwolinski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mz@ecs.soton.ac.uk
//
// Revision   : Version 1.0 16/10/17
/////////////////////////////////////////////////////////////////////

module test_multiplier;

logic start, n_rst, clock; 
logic [7:0] Min, Qin; 
logic ready; 
logic[15:0] AQ;
logic mFlag;

multiplier m0 (.*);

initial 
begin
  clock = 1'b0; 
  forever #10ns clock = ~clock; 
end

initial
  begin
  n_rst = '1;
  #2ns n_rst = '0;
  #2ns n_rst = '1;
  end
  
initial
  begin
  start = '0;
  Qin = '0;
  mFlag = '0;
  #5ns start = '1;
  mFlag = 1;
  Qin = 128;
  #15ns mFlag = 0;
  Qin = 129;
  Min = 128;
  @(posedge ready) // Wait for ready to become true
    if (AQ==Min*Qin)
      $display("Test passed: at %t Min = %d, Qin = %d, AQ = %d", $time, Min, Qin, AQ);
    else
      $display("Test failed: at %t Min = %d, Qin = %d, AQ = %d", $time, Min, Qin, AQ);
  end
  
endmodule