module fa_delay (
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
// Intermediate signals
logic sum1, carry1, carry2;

// Instantiate the first half adder
ha_delay HA1 (a, b, sum1, carry1);

// Instantiate the second half adder
ha_delay HA2 (sum1, cin, sum, carry2);

// Instantiate the two-input NAND gate for the carry out
nand2_delay N2 (carry1, carry2, cout);

endmodule