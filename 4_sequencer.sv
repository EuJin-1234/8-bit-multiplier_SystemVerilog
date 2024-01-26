/////////////////////////////////////////////////////////////////////
// Design unit: sequencer
//            :
// File name  : sequencer.sv
//            :
// Description: Code for M4 Lab exercise
//            : Outline code for sequencer
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : 
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : 
//
// Revision   : Version 1.0 
/////////////////////////////////////////////////////////////////////

module sequencer (input logic start, clock, Q0, n_rst, mFlag,
 output logic add, shift, ready, reset, stay);
 
// Your code goes here
logic [3:0] count, count_next;
enum logic [1:0] {idle, loadQ, addshift, stopped} present_state, next_state;

always_ff @(posedge clock, negedge n_rst)
	if (~n_rst)
		begin
			present_state <= idle;
			count <= 8;
		end	
	else
		begin
			present_state <= next_state;
			count <= count_next;
		end
	
always_comb
	begin
		add = '0;
		shift = '0;
		ready = '0;
		reset = '0;
		stay = '0;
		count_next = count;
		next_state = present_state;
		
		unique case (present_state)
		idle:
			begin
				reset = '1;
				count_next = 8;
				if (start)
					next_state = loadQ;
			end
			
		loadQ:
			begin
				if (~mFlag)
					next_state = addshift;
			end
			
		addshift:
			begin
				count_next = count_next - 1;
				if (Q0 == 1) 
					add = '1;
				else 
					shift = '1;
				if (count_next > 0) 
					next_state = addshift;
				else
					next_state = stopped;
			end
		
		stopped:
			begin 
				ready = '1;
				stay = '1;
				if (start)
				begin
					next_state = idle;
				end
			end
			
		default:
			begin
				next_state = idle;
			end
			
		endcase
	end
endmodule


      
              
             