module Processor (
	input logic [8:0] Din,
	input logic clk, resetn, run, 
	output logic [8:0] ADDR, Dout,
	output logic W, Done
);

ControlunitFSM FSM (.clk(clk), .resetn(resetn), .GFin(GFin), .AFin(AFin), .GFout(GFout), .AddSubF(AddSubF), .run(run),
							.Din(Din), .Gout(Gout), .Dinout(Dinout), .IRin(IRin), .Ain(Ain), .Gin(Gin), .AddSub(AddSub), .Done(Done), .state(state), .IR(IR), .incr_pc(incr_pc), .G(G),
							.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), .ADDRin(ADDRin), .Doutin(Doutin), .W_D(W_D),
							.R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out));

datapath datapath (.clk(clk), .rst(resetn), .Din(Din), .Ain(Ain), .Gin(Gin), .Gout(Gout), .Dinout(Dinout), .AddSub(AddSub), .incr_pc(incr_pc), .ADDR(ADDR), .Dout(Dout), .AFin(AFin),
						 .R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), .ADDRin(ADDRin), .Doutin(Doutin), .W_D(W_D), .GFin(GFin),
						 .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), .AF(AF), .GF(GF), .sumGF(sumGF), 
						 .BUS(BUS), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .A(A), .sumG(sumG), .G(G), .W(W), .GFout(GFout), .AddSubF(AddSubF));
						 
endmodule
