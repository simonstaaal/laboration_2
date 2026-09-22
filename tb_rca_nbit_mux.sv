module fa_mux(
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module tb_rca_nbit_mux();

    parameter N = 4;

    logic [N-1:0] a;
    logic [N-1:0] b;
    logic cin;
    logic [N-1:0] sum;
    logic cout;

    rca_nbit_mux #(.N(N)) dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        a = 4'b0000;
        b = 4'b0000;
        cin = 1'b0;
        #10;

        a = 4'b0001;
        b = 4'b0010;
        cin = 1'b0;
        #10;

        a = 4'b0101;
        b = 4'b0011;
        cin = 1'b1;
        #10;

        a = 4'b1111;
        b = 4'b1111;
        cin = 1'b0;
        #10;

        a = 4'b1010;
        b = 4'b0101;
        cin = 1'b1;
        #10;
    end

endmodule
