module multiplexer (
	input logic [8:0] Din,
	input logic [8:0] R0, R1, R2, R3, R4, R5, R6, R7, G, GF,
	input logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, Dinout, GFout, 
	output logic [8:0] BUS
);

logic [10:0] sel;
assign sel [10:0] = {R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, GFout, Dinout};

always @(*) begin
	case (sel) 
		11'b10000000000: BUS = R0;
		11'b01000000000: BUS = R1;
		11'b00100000000: BUS = R2;
		11'b00010000000: BUS = R3;
		11'b00001000000: BUS = R4;
		11'b00000100000: BUS = R5;
		11'b00000010000: BUS = R6;
		11'b00000001000: BUS = R7;
		11'b00000000100: BUS = G;
		11'b00000000010: BUS = GF;
		11'b00000000001: BUS = Din;
		default: BUS = 9'b000000000;
	endcase
end 
endmodule
	
	