module rca_Nbit_co #(parameter N = 4) (
    input logic  [N-1:0] A,
    input logic  [N-1:0] B,
    input logic  cin,
    output logic [N-1:0] Sum,
    output logic co
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

    assign co = C[N];

endmodule