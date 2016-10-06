module ALU(
   input  wire [7:0] op1,
   input  wire [7:0] op2,
   output reg  [7:0] out,
   input  wire [2:0] ctrl
);

wire [7:0] add_out;
wire [7:0] sub_out;
wire [7:0] ral_out;
wire [7:0] rar_out;
wire [7:0] and_out;
wire [7:0] or_out;
wire [7:0] xor_out;
wire [7:0] not_out;

assign add_out = op1 + op2;
assign sub_out = op1 - op2;
assign ral_out = {op1[6:0],op1[7]}; //D7 goes to D0, others left by 1 pos
assign rar_out = {op1[0],op1[7:1]}; //D7 goes to D0, others left by 1 pos
assign and_out = op1 & op2;
assign or_out  = op1 | op2;
assign xor_out = op1 ^ op2;
assign not_out = ~op1;

always @(*)//sensitivity block
begin
    case(ctrl)
       3'b000:begin
        out = add_out;
       end
       3'b001:begin
        out = sub_out;
       end
       3'b010:begin
        out = ral_out;
       end
       3'b011:begin
        out = rar_out;
       end
       3'b100:begin
        out = and_out;
       end
       3'b101:
       begin
        out = or_out;
       end
       3'b110:begin
        out = xor_out;
       end
       3'b111:begin
        out = not_out;
       end
    endcase
end

endmodule