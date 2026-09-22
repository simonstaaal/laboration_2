`timescale 1ns / 1ps

module tb_mult_Nbit;

    parameter M = 4; //A
    parameter N =4; //B
    
    logic [N-1:0] A;
    logic [N-1:0] B;
    logic [(M+N)-1:0] Prod; //Produkt M+N , undviker ofv & ufv

mult_mnbit#(N) dut (
                    .A(A),
                    .B(B),
                    .Prod(Prod)
                );

   initial begin

        // 
        A = 1;  
        B = 6;
        #30;

        A = 0;
        B = 6;
        #30;

        A = 1;
        B = 6;
        #30;

        A = 0;
        B = 0;
        #30;

        A = -4;
        B = 2;
        #30;

        A = -5;
        B = -5;
        #30;

        A = -8;
        B = -8;
        #30;

        A = 7;
        B = 7;
        #30;

        A = -7;
        B = 8;
        #30;

        A = 5;
        B = -1;
        #30;


        $finish;


    end
endmodule