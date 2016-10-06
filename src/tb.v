`timescale 1ns/1ps
module testbench();

reg [2:0] myctrl;
wire [7:0] myout;
integer a;
integer b;
integer c;


initial
begin
#10;
myctrl = 0;
a = 255;
b = 1;
c = a+b;
#5
$display("For inputs %d and %d output is %d",a,b,myout);
if(c==myout)
    $display("Passed");
else
    $display("Failed Expected %d received %d",c,myout);
end



ALU my_alu(
   .op1(a),
   .op2(b),
   .out(myout),
   .ctrl(myctrl)
);


endmodule