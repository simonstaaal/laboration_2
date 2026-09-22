`timescale 1ns / 1ps

module mux2to1_Nbit #(parameter WIDTH = 1) (
    input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,
    input logic s,
    output logic [WIDTH-1:0] Y
);
    assign Y = s ? B : A;
endmodule

module tb_shifter_rotator();

    logic [3:0] x;
    logic [1:0] select;
    logic [3:0] y;

    shifter_rotator dut (
        .x(x),
        .select(select),
        .y(y)
    );

    initial begin

        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 4; j++) begin
                x = i[3:0];
                select = j[1:0];
                
                #10;

            end
        end

    end

endmodule
