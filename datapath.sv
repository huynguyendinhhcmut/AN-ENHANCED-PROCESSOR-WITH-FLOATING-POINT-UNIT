module datapath (
	input logic clk, rst,
	input logic [8:0] Din,
	input logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, Ain, Gin, ADDRin, Doutin, W_D, incr_pc, GFin, AFin, 
	input logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, Dinout, AddSub, GFout, AddSubF,
	output logic [8:0] BUS, G, sumG, A, R0, R1, R2, R3, R4, R5, R6, R7, ADDR, Dout, W, sumGF, GF, AF
);

D_FF9b dffR0 (.clk(clk), .rst(rst), .enable(R0in), .data_i(BUS), .data_o(R0));
D_FF9b dffR1 (.clk(clk), .rst(rst), .enable(R1in), .data_i(BUS), .data_o(R1));
D_FF9b dffR2 (.clk(clk), .rst(rst), .enable(R2in), .data_i(BUS), .data_o(R2));
D_FF9b dffR3 (.clk(clk), .rst(rst), .enable(R3in), .data_i(BUS), .data_o(R3));
D_FF9b dffR4 (.clk(clk), .rst(rst), .enable(R4in), .data_i(BUS), .data_o(R4));
D_FF9b dffR5 (.clk(clk), .rst(rst), .enable(R5in), .data_i(BUS), .data_o(R5));
D_FF9b dffR6 (.clk(clk), .rst(rst), .enable(R6in), .data_i(BUS), .data_o(R6));
counterR7 (.clk(clk), .rst(rst), .incr_pc(incr_pc), .R7in(R7in), .PC(BUS), .R7(R7));

D_FF9b dffA (.clk(clk), .rst(rst), .enable(Ain), .data_i(BUS), .data_o(A));
D_FF9b dffAF (.clk(clk), .rst(rst), .enable(AFin), .data_i(BUS), .data_o(AF));

D_FF9b dffADDR (.clk(clk), .rst(rst), .enable(ADDRin), .data_i(BUS), .data_o(ADDR));
D_FF9b dffDout (.clk(clk), .rst(rst), .enable(Doutin), .data_i(BUS), .data_o(Dout));
D_FF9b dffW (.clk(clk), .rst(rst), .enable(1'b1), .data_i(W_D), .data_o(W));

FA9b Addsub (.a(A), .b(BUS), .cin(AddSub), .sum(sumG));
normalized AddsubF (.A(AF), .B(BUS), .cin(AddSubF), .sumF(sumGF));

D_FF9b dffG (.clk(clk), .rst(rst), .enable(Gin), .data_i(sumG), .data_o(G));
D_FF9b dffGF (.clk(clk), .rst(rst), .enable(GFin), .data_i(sumGF), .data_o(GF));

multiplexer multiplexer0 (.Din(Din), .R0(R0),  .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .G(G), .GFout(GFout), .GF(GF),
								  .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out),
								  .Gout(Gout), .Dinout(Dinout), .BUS(BUS));

endmodule



