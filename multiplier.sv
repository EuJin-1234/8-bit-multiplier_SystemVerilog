/////////////////////////////////////////////////////////////////////
// Design unit: multiplier
//            :
// File name  : multiplier.sv
//            :
// Description: Code for M4 Lab exercise
//            : Top-level module for shift and add multiplier
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Tom Kazmierski & Mark Zwolinski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mz@ecs.soton.ac.uk
//
// Revision   : Version 1.0 17/10/13
//            : modified for DE1-SoC: mz, 16/10/17
/////////////////////////////////////////////////////////////////////

module multiplier(input logic start, n_rst, clock, mFlag, input logic [7:0] Qin,
                  output logic ready, output logic [6:0] d0, d1, d2, d3);

logic C, reset, shift, add, stay;
logic [7:0] Sum, M;
logic[15:0] AQ;

adder A0(.A(AQ[15:8]), .M(M), .C(C), .Sum(Sum));
register R0 (.*);
reg_m R1 (.*);
sequencer S(.start(start), .clock(clock), .reset(reset), .Q0(AQ[0]), .n_rst(n_rst), .mFlag(mFlag),
 .add(add), .shift(shift), .ready(ready), .stay(stay));
 
sevenseg S0(.address(AQ[3:0]), .data(d0));
sevenseg S1(.address(AQ[7:4]), .data(d1));
sevenseg S2(.address(AQ[11:8]), .data(d2));
sevenseg S3(.address(AQ[15:12]), .data(d3));
  
endmodule