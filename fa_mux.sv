module fa_mux(
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic cout
);
    logic a_inv;
    inverter inv(.a(a), .y(a_inv));

    mux4to1_slice sum_mux(
        .a(a),
        .b(a_inv),
        .c(a_inv),
        .d(a),
        .s0(b),
        .s1(cin),
        .y(sum)
    );

    mux4to1_slice cout_mux(
        .a(1'b0),
        .b(a),
        .c(a),
        .d(1'b1),
        .s0(b),
        .s1(cin),
        .y(cout)
    );

endmodule