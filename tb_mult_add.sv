`timescale 1ns/1ps

module tb_mult_add;

logic [3:0] a0,a1,a2,a3,a4,a5,a6,a7;

logic [9:0] x;


mult_add dut(
    .a0(a0),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .a4(a4),
    .a5(a5),
    .a6(a6),
    .a7(a7),
    .x(x)
);

initial begin
    a0 = 4'd0;
    a1 = 4'd0;
    a2 = 4'd0;
    a3 = 4'd0;
    a4 = 4'd0;
    a5 = 4'd0;
    a6 = 4'd0;
    a7 = 4'd0;
    #20;

    a0 = 4'd2;
    a1 = 4'd2;
    a2 = 4'd2;
    a3 = 4'd2;
    a4 = 4'd2;
    a5 = 4'd2;
    a6 = 4'd2;
    a7 = 4'd2;
    #20;


    a0 = 4'd5;
    a1 = 4'd5;
    a2 = 4'd5;
    a3 = 4'd5;
    a4 = 4'd5;
    a5 = 4'd5;
    a6 = 4'd5;
    a7 = 4'd5;
    #20;

    a0 = 4'd15;
    a1 = 4'd15;
    a2 = 4'd15;
    a3 = 4'd15;
    a4 = 4'd15;
    a5 = 4'd15;
    a6 = 4'd15;
    a7 = 4'd15; 
    #20;

end
endmodule