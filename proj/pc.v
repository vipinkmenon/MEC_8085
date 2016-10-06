`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:59 10/06/2016 
// Design Name: 
// Module Name:    pc 
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
module prgm_cntr(
    input         clk, //clock signal
	 input         reset,
	 input         control,
	 input [15:0]  branch_addr,
	 output reg [15:0] pc
    );
	 
	 
	 always @(posedge clk)
	 begin
	     if(reset)
		      pc <= 16'd0;
		  else
		  begin
		      if(control)
				   pc <= branch_addr;
				else
				   pc <= pc + 1'd1;
		  end
	 end
	 

endmodule
