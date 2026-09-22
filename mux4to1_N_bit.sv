module mux4to1_N_bit #(parameter N=4)
                (   input  logic [N-1:0] A,
                    input  logic [N-1:0] B,
                    input  logic [N-1:0] C,
                    input  logic [N-1:0] D,
                    input  logic [1:0] sel,
                    output logic [N-1:0] Y
                );


    // Generate N bit 2-1 mux
    genvar i;
    generate
        for (i = 0; i < N; i++) begin : gen_4to1_mux
            mux4to1_slice ms (
                .a(A[i]),
                .b(B[i]),
                .c(C[i]),
                .d(D[i]),
                .s(sel),
                .y(Y[i])
            );
        end
    endgenerate

endmodule