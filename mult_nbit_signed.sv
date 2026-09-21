module mult_mnbit #(parameter M = 4, parameter N = 4)(
	input logic [M-1:0] a,
	input logic [N-1:0] b,
	output logic [M+N-1 : 0] prod_final
	);

	localparam adder_width = M;
	localparam adder_num = N-1;

	logic [M-1:0] prod_terms [N-1:0]; //M-bit packed array of N-bit unpacked arrays
	logic co [adder_num-1:0];
	logic [adder_width-1:0] adder_sum [adder_num-1:0]; 
	logic [adder_width-1:0] term_a [adder_num-1:0];
	logic [adder_width-1:0] term_b [adder_num-1:0];

	
	logic [M-1:0] a_inv;
	logic [N-1:0] b_inv;

	logic [M-1:0] a_out;
	logic [N-1:0] b_out;

	logic is_prod_inv;
	logic [M+N-1:0] product;
	logic [M+N-1:0] product_inv;

	

	rca_Nbit_co  #(M) inv_a( // Two's complement of A
		.A(~(a[M-1 :0])),
		.B({M{1'b0}}), // M stycken 0:or i en "array"
		.cin(1),
		.Sum(a_inv),
		.co()
	);

		rca_Nbit_co #(N) inv_b( // Two's complement of B
		.A(~(b[N-1 :0])),
		.B({N{1'b0}}), // M stycken 0:or i en "array"
		.cin(1),
		.Sum(b_inv),
		.co()
	);


    mux2to1_Nbit #(M) a_mux(
		.A(a_inv[M-1:0]), //Inverterade A
		.B(a[M-1:0]), //Vanliga A
		.s(a[M-1]),
		.Y(a_out)
	);

	    mux2to1_Nbit #(N) b_mux(
		.A(b_inv[N-1:0]), //Inverterade B
		.B(b[N-1:0]), //Vanliga B
		.s(b[N-1]),
		.Y(b_out)
	);

	// Generate block to create the MxN product terms  
	genvar i, j;
	generate
		for (j = 0; j < N; j++) begin : B_loop
			for (i = 0; i < M; i++) begin : A_loop
				and2_delay u_and (
					.a(a_out[i]), 
					.b(b_out[j]), 
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
	assign product [M+N-1: N] = {co[adder_num-1], adder_sum[adder_num-1][adder_width-1:1]};

	rca_Nbit_co #(M+N)inv_product( // Two's complement of Product
		.A(~(product[M+N-1:0])),
		.B({(M+N){1'b0}}), // M+N stycken 0:or i en "array"
		.cin(1),
		.Sum(product_inv),
		.co()
	);

	xor2_delay xor_u(
		.a(a[M-1]),
		.b(b[N-1]),
		.y(is_prod_inv)
	);

	mux2to1_Nbit #(M+N) prod_mux(
		.A(product_inv[M+N-1 : 0]), // Inverterade produkt
		.B(product[M+N-1 : 0]),    //  Vanliga A
		.s(is_prod_inv),
		.Y(prod_final)
	);
	

endmodule

