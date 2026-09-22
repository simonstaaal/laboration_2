module rca_nbit_mux #(parameter N = 4)(
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    input logic cin,
    output logic [N-1:0] sum,
    output logic cout
    );

    logic [N:0] C;
    assign C[0] =cin;

    genvar i;
    generate
        for (i = 0; i < N; i++) begin : gen_full_adders
            fa_mux fa (
                .a(a[i]),
                .b(b[i]),
                .cin(C[i]),
                .sum(sum[i]),
                .cout(C[i+1])
            );
        end
    endgenerate
endmodule
