module ha_delay (
	input logic a, 
	input logic b, 
	output logic sum, 
	output logic carry ); 

// Instantiate the XOR gate, unit u1, for the sum 
xor2_delay u1 (
	.a(a), 
	.b(b), 
	.y(sum)
	); 

// Instantiate the AND gate, unit u2, for the carry 
nand2_delay u2 (
	.a(a), 
	.b(b), 
	.y(carry)
	); 

endmodule
