module mux16to1 (
	input logic I0, I1,
	input logic [4:0] sel,
	output logic out
);

always @(*) begin
	unique case (sel)
		5'b00000:out = I0;
		5'b00001:out = I1;
		5'b00010:out = I1;
		5'b00011:out = I1;
		5'b00100:out = I1;
		5'b00101:out = I1;
		5'b00110:out = I1;
		5'b00111:out = I1;
		5'b01000:out = I1;
		5'b01001:out = I1;
		5'b01010:out = I1;
		5'b01011:out = I1;
		5'b01100:out = I1;
		5'b01101:out = I1;
		5'b01110:out = I1;
		5'b01111:out = I1;
		5'b10000:out = I1;
		5'b10001:out = I1;
		5'b10010:out = I1;
		5'b10011:out = I1;
		5'b10100:out = I1;
		5'b10101:out = I1;
		5'b10110:out = I1;
		5'b10111:out = I1;
		5'b11000:out = I1;
		5'b11001:out = I1;
		5'b11010:out = I1;
		5'b11011:out = I1;
		5'b11100:out = I1;
		5'b11101:out = I1;
		5'b11110:out = I1;
		5'b11111:out = I1;
	endcase
end

endmodule