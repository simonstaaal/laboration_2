module mult_mnbit #(parameter M = 4, parameter N = 4)(
	input logic [M-1:0] a,
	input logic [N-1:0] b,
	output logic [M+N-1:0] product
	);

	localparam adder_width = M;
	localparam adder_num = N-1;

	logic [M-1:0] prod_terms [N-1:0]; //M-bit packed array of N-bit unpacked arrays
	logic co [adder_num-1:0];
	logic [adder_width-1:0] adder_sum [adder_num-1:0]; 
	logic [adder_width-1:0] term_a [adder_num-1:0];
	logic [adder_width-1:0] term_b [adder_num-1:0];
	
	
	// Generate block to create the MxN product terms
	genvar i, j;
	generate
		for (j = 0; j < N; j++) begin : B_loop
			for (i = 0; i < M; i++) begin : A_loop
				and2_delay u_and (
					.a(a[i]), 
					.b(b[j]), 
					.y(prod_terms[j][i]) //Unpacked first, packed second
					);
			end
		end
	endgenerate

	// First adder
	assign term_a[0] = {1'b0, prod_terms[0][M-1:1]};
	assign term_b[0] = prod_terms[1];

	rca_Nbit_co #(adder_width) u1 ( 
		.A(term_a[0]),
		.B(term_b[0]),
		.cin(1'b0),
		.Sum(adder_sum[0]),
		.co(co[0])
	);

	// Subsequent adders
	generate
		for (i = 1; i < adder_num; i++) begin : adder_loop
			assign term_a[i] = {co[i-1], adder_sum[i-1][adder_width-1:1]};
			assign term_b[i] = prod_terms[i+1];

			rca_Nbit_co #(adder_width) u_adder (
				.A(term_a[i]),
				.B(term_b[i]),
				.cin(1'b0),
				.Sum(adder_sum[i]),
				.co(co[i])
			);
		end
	endgenerate

	// Assign the final product
	assign product[0] = prod_terms[0][0];
	generate
		for (i = 0; i < adder_num; i++) begin : product_loop
			assign product[i+1] = adder_sum[i][0];
		end
	endgenerate
	assign product [M+N-1:M-1] = {co[adder_num-1], adder_sum[adder_num-1]};

endmodule
