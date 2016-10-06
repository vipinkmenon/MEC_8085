module register_file(
input  wire  clk,
input [7:0]  alu_out,
input [7:0]  mem_data,
output reg [7:0] reg_out1,
output reg [7:0] reg_out2,
input [2:0]  op1_select,
input [2:0]  op2_select,

input [7:0]  reg_wr_data,
input        enable_reg_a,
input        enable_reg_b,
input        enable_reg_c,
input        enable_reg_d,

input        store_alu_a_reg
);

reg [7:0] A;
reg [7:0] B;
reg [7:0] C;
reg [7:0] D;
reg [7:0] E;
reg [7:0] H;
reg [7:0] L;

always @(*)
begin
    case(op1_select)
       3'd0:reg_out1 = A;
       3'd1:reg_out1 = B;
       3'd2:reg_out1 = C;
       3'd3:reg_out1 = D;
       3'd4:reg_out1 = E;
       3'd5:reg_out1 = H;
       3'd6:reg_out1 = L;
       3'd7:reg_out1 = mem_data;
    endcase
end

always @(*)
begin
    case(op2_select)
       3'd0:reg_out2 = A;
       3'd1:reg_out2 = B;
       3'd2:reg_out2 = C;
       3'd3:reg_out2 = D;
       3'd4:reg_out2 = E;
       3'd5:reg_out2 = H;
       3'd6:reg_out2 = L;
       3'd7:reg_out2 = 8'd1;
    endcase
end

always @(posedge clk)
begin
   if(enable_reg_a)
       A <= reg_wr_data;
	else if(store_alu_a_reg)
	    A <= alu_out;
end

endmodule