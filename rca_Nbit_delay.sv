module rca_Nbit_delay #(parameter N = 8) (
    input logic signed [N-1:0] A,
    input logic signed [N-1:0] B,
    input logic cin,
    output logic signed [N:0] Sum
);
    // Internal carry signals
    logic [N:0] C;

    assign C[0] =cin;
    
    // Generate block to create the N full adders
    genvar i;
    generate
        for (i = 0; i < N; i++) begin : gen_full_adders
            fa_delay fa (
                .a(A[i]),
                .b(B[i]),
                .cin(C[i]),
                .sum(Sum[i]),
                .cout(C[i+1])
            );
        end
    endgenerate

    // Additional full adder for sign extension
    fa_delay fa_del (
        .a(A[N-1]),
        .b(B[N-1]),
        .cin(C[N]),
        .sum(Sum[N]),
        .cout() // Final carry out is not used
    );

endmodule