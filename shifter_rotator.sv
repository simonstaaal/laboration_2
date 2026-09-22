module shifter_rotator(
    input logic[3:0] x,
    input logic[1:0] select,
    output logic[3:0] y
    );

    logic left_input;
    logic right_input;

    // Left input MUX
    mux2to1_Nbit #(1) left_input_mux(
        .A(1'b0),
        .B(x[0]),
        .s(select[1]),
        .Y(left_input)
    );

    // Right input MUX
    mux2to1_Nbit #(1) right_input_mux(
        .A(x[3]),
        .B(1'b0),
        .s(select[1]),
        .Y(right_input)
    );

    // Shift-rotate MUXes
    mux2to1_Nbit #(1) M0(
        .A(right_input),
        .B(x[1]),
        .s(select[0]),
        .Y(y[0])
    );

    mux2to1_Nbit #(1) M1(
        .A(x[0]),
        .B(x[2]),
        .s(select[0]),
        .Y(y[1])
    );

    mux2to1_Nbit #(1) M2(
        .A(x[1]),
        .B(x[3]),
        .s(select[0]),
        .Y(y[2])
    );

    mux2to1_Nbit #(1) M3(
        .A(x[2]),
        .B(left_input),
        .s(select[0]),
        .Y(y[3])
    );

endmodule
