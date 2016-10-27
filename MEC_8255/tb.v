`timescale 1ns/1ps

module tb();

wire [7:0] data_bus;
reg [7:0] tb_db;
reg [1:0] tb_ab;
reg [1:0] recv_data;
reg tb_cs_n;
reg tb_wr_n;
reg tb_rd_n;
reg tbe;

assign data_bus = (tbe == 1) ? tb_db : 8'hzz;

initial
begin
tb_cs_n = 1'b1;
tb_rd_n = 1'b1;
tb_wr_n = 1'b1;
tbe = 0;
#10;
tb_ab = 2'b11;
tb_wr_n = 1'b0;
tbe = 1;
tb_db = 'h82;
#10;
tb_cs_n = 1'b0;
#10;
tb_cs_n = 1'b1;
tb_wr_n = 1'b1;
tbe = 0;
#10;
tb_cs_n = 1'b0;
tb_rd_n = 1'b0;
tb_ab = 2'b01;
#5
recv_data = data_bus;
#10;
tb_cs_n = 1'b0;
#10
tb_cs_n = 1'b1;
tb_wr_n = 1'b1;
tb_rd_n = 1'b1;
#10;
tb_ab = 2'b00;
tb_wr_n = 1'b0;
tbe = 1;
tb_db = recv_data;
#10
tb_cs_n = 1'b0;
#10
$stop;
end


wire [7:0] io_device;
assign io_device = 'ha5;

mec_8255 m8255(
 .Reset(1'b0),
 .d(data_bus),
 .Pa(),
 .Pb(io_device),
 .Pc(),
 .A(tb_ab),
 .Cs_n(tb_cs_n),
 .Wr_n(tb_wr_n),
 .Rd_n(tb_rd_n)
);

endmodule

