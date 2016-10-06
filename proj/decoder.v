`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:48 10/06/2016 
// Design Name: 
// Module Name:    decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder(
    input         clk,
	 input         reset,
	 input [7:0]   decode_input,
	 output [2:0]  alu_ctrl,
	 output        pc_ctrl,
	 output [15:0] branch_address,
	 output reg    enable_a_reg,
	 output        enable_b_reg,
	 output        enable_c_reg,
	 output        enable_d_reg,
    output [7:0]  reg_wr_data
    );
	 
	 assign reg_wr_data  =  decode_input;
	 
	 reg [3:0] state;
	 
	 localparam S0 = 'd0,
	            S1 = 'd1,
					S2 = 'd2;
	 
	 always @(posedge clk)
	 begin
	     if(reset)
		      state <= S0;
		  else
		  begin
	         case(state)
				    S0:begin
					     if(decode_input == 'h3E)
						  begin
					         state <= S1;
						  end
						  else
						      state <= S0;
					 end
					 S1:begin
					    enable_a_reg <=  1'b1;
						 state <= S2;
					 end
					 S2:begin
					     enable_a_reg <=  1'b0;
						  state <= S0;
					 end
				endcase
		  end
	 end


endmodule
