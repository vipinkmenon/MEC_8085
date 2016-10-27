module mec_8255(
input        Reset,
inout [7:0]  d,
inout [7:0] Pa,
inout [7:0] Pb,
inout [7:0] Pc,
input [1:0]  A,
input        Cs_n,
input        Wr_n,
input        Rd_n
);

reg [7:0] Pa_reg;
reg [7:0] Pb_reg;
reg [7:0] Pc_reg;
reg [7:0] Pa_p;
reg [7:0] Pb_p;
reg [7:0] Pc_p;
reg [7:0] Pctrl_reg1;
reg [7:0] d_int;

assign d = (ctrl == 1'b0) ? 8'hZZ : d_int;

assign ctrl = ~Cs_n & ~Rd_n & Wr_n;

assign Pa = Pa_p;
assign Pb = Pb_p;
assign Pc = Pc_p;

always @(negedge Cs_n)
begin
    if(~Wr_n & Rd_n & A[1:0] == 2'b00)
        Pa_reg <= d;
        
    if(~Wr_n & Rd_n & A[1:0] == 2'b01)
        Pb_reg <= d;
        
    if(~Wr_n & Rd_n & A[1:0] == 2'b10)
        Pc_reg <= d;    
        
    if(~Wr_n & Rd_n & A[1:0] == 2'b11)
        Pctrl_reg1 <= d;
end


always @(*)
begin
    if(~Pctrl_reg1[4] & Pctrl_reg1[6:5] == 2'b00)
       Pa_p = Pa_reg;
end

always @(*)
begin
    if(~Pctrl_reg1[1] & ~Pctrl_reg1[2])
       Pb_p = Pb_reg;
end


always @(*)
begin
    if(~Pctrl_reg1[0] & ~Pctrl_reg1[2])
       Pc_p[3:0] = Pc_reg[3:0];
end


always @(*)
begin
    if(~Pctrl_reg1[3] & Pctrl_reg1[6:5] == 2'b00)
       Pc_p[7:4] = Pc_reg[7:4];
end


always @(*)
begin
    if(A[1:0] == 2'b00 & Pctrl_reg1[4])
       d_int = Pa;
    else if(A[1:0] == 2'b01 & Pctrl_reg1[1])
       d_int = Pb;
    else if(A[1:0] == 2'b10)
    begin
        if(Pctrl_reg1[0])
          d_int[3:0] = Pc[3:0];
        else
          d_int[3:0] = 4'hX;
        if(Pctrl_reg1[3])
          d_int[7:4] = Pc[7:4];
        else
          d_int[7:4] = 4'hX;
    end
    else
        d_int[7:0] = 8'hXX;
end

endmodule












