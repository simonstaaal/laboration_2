module mux4to1_slice
                (   input  logic a,
                    input  logic b,
                    input  logic c,
                    input  logic d,
                    input  logic [1:0] s,
                    output logic y
                );

logic u1_out, u2_out, u3_out, u4_out;
logic s0, s1, s0_inv, s1_inv;

    assign s0 = s[0];
    assign s1 = s[1];

    nand2_delay inv0 (
                .a(s0),
                .b(s0),
                .y(s0_inv)
            );

    nand2_delay inv1 (
                .a(s[1]),
                .b(s[1]),
                .y(s1_inv)
            );

    nand3_delay U1 (
                .a(a),
                .b(s0_inv),
                .c(s1_inv),
                .y(u1_out)
            );

    nand3_delay U2 (
                .a(b),
                .b(s0),
                .c(s1_inv),
                .y(u2_out)
            );

    nand3_delay U3 (
                .a(c),
                .b(s0_inv),
                .c(s1),
                .y(u3_out)
            );

    nand3_delay U4 (
                .a(d),
                .b(s0),
                .c(s1),
                .y(u4_out)
            );

    nand4_delay U5 (
                .a(u1_out),
                .b(u2_out),
                .c(u3_out),
                .d(u4_out),
                .y(y)
            );


endmodule