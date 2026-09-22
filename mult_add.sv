module mult_add(
    input logic [3:0] a0,
    input logic [3:0] a1,
    input logic [3:0] a2,
    input logic [3:0] a3,
    input logic [3:0] a4,
    input logic [3:0] a5,
    input logic [3:0] a6,
    input logic [3:0] a7,
    output logic [10:0] x
    );

    // Add 0 so rca_Nbit_delay doesnt think its a negative number
    logic [8:0] mult1_out;
    assign mult1_out [8]  = 1'b0;
    
    logic [8:0] mult2_out;
    assign mult2_out [8] = 1'b0;
    
    logic [8:0] mult3_out;
    assign mult3_out [8] = 1'b0;
    
    logic [8:0] mult4_out;
    assign mult4_out [8] = 1'b0;
    

    logic [9:0] rca1_out;
    logic [9:0] rca2_out;

    // m1
    mult_mnbit #(.M(4), .N(4)) mult1(
        .a(a0),
        .b(a1),
        .prod_final(mult1_out[7:0])
    );
        //m2
        mult_mnbit #(.M(4),.N(4)) mult2(
        .a(a2),
        .b(a3),
        .prod_final(mult2_out[7:0])
    );
    // m1 +m2
    rca_Nbit_delay #(.N(9)) add_m1_m2(
        .A(mult1_out),
        .B(mult2_out),
        .cin(0),
        .Sum(rca1_out)
    );
    // m3
        mult_mnbit #(.M(4), .N(4)) mult3(
        .a(a4),
        .b(a5),
        .prod_final(mult3_out[7:0])
    );
    //m4
        mult_mnbit #(.M(4), .N(4)) mult4(
        .a(a6),
        .b(a7),
        .prod_final(mult4_out[7:0])
    );
        //m3+m4
        rca_Nbit_delay #(.N(9)) add_m3_m4(
        .A(mult3_out),
        .B(mult4_out),
        .cin(0),
        .Sum(rca2_out)
    );
        // Final addition
        rca_Nbit_delay #(.N(10)) add_final(
        .A(rca1_out),
        .B(rca2_out),
        .cin(0),
        .Sum(x)

    );   
endmodule

