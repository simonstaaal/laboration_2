

module nand2_delay ( 
	input logic a,   // First input 
	input logic b,   // Second input 
	output logic y   // Output 
	); 

// Continuous assignment for XOR gate 
    assign y = ~(a & b);  // Perform the XOR operation after the delay
	
endmodule