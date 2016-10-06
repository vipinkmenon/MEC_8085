`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:44 09/22/2016 
// Design Name: 
// Module Name:    proc_8085_top 
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
module proc_8085_top(
   input clock,
	input reset,
	input [2:0] op1_select,
	input [2:0] op2_select,
	output [15:0] a,
	input  [7:0] d
);

wire [7:0] reg_to_op1;
wire [7:0] reg_to_op2;
wire [7:0] alu_to_reg;
wire [7:0] reg_wr_data;
wire [2:0] alu_ctrl;
wire       pc_ctrl;
wire [15:0] branch_address;

ALU alu (
    .op1(reg_to_op1), 
    .op2(reg_to_op2), 
    .out(alu_to_reg), 
    .ctrl(alu_ctrl)
    );
	 
register_file reg_file (
    .clk(clock), 
    .alu_out(alu_to_reg), 
    .mem_data(), 
    .reg_out1(reg_to_op1), 
    .reg_out2(reg_to_op2), 
    .op1_select(op1_select), 
    .op2_select(op2_select),
	 
    .reg_wr_data(reg_wr_data),
    .enable_reg_a(enable_reg_a),
    .enable_reg_b(enable_reg_b),
    .enable_reg_c(enable_reg_c),
    .enable_reg_d(enable_reg_d),
	 
	 .store_alu_a_reg()
    );
	 
prgm_cntr pctr(
    .clk(clock), //clock signal
	 .reset(reset),
	 .control(pc_ctrl),
	 .branch_addr(branch_address),
	 .pc(a)
    );

decoder decoder (
    .clk(clock), 
    .reset(reset), 
    .decode_input(d), 
    .alu_ctrl(alu_ctrl), 
    .pc_ctrl(pc_ctrl), 
    .branch_address(branch_address), 
    .enable_a_reg(enable_reg_a), 
    .enable_b_reg(enable_reg_b), 
    .enable_c_reg(enable_reg_c), 
    .enable_d_reg(enable_reg_d), 
    .reg_wr_data(reg_wr_data)
    );	 


endmodule
