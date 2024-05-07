module system (
	input logic clk, resetn, run,
	output logic [8:0] LEDS,
	output logic Done
);

logic AddSub, Ain, incr_pc, ADDRin, IRin, W_D, W, Dinout;
logic [8:0] BUS, R0, R1, R2, R3, R4, R5, R6, R7, A, AF, sumG, sumGF, G, GF, IR, ADDR, Dout, Din;
logic [4:0] state;
logic Gout, Gin, Doutin, A7A81, A7A82, wr_en, leds, GFin, AFin, GFout, AddSubF;
logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in;
logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;

assign A7A81 = ~(ADDR[7] | ADDR[8]); 
assign A7A82 = ~(~ADDR[7] | ADDR[8]);
assign wr_en = A7A81 & W;
assign leds = W & A7A82;

D_FF_enable dffleds (.clk(clk), .rst(resetn), .enable(leds), .data_i(Dout), .data_o(LEDS));

RAM Memory (.address(ADDR[6:0]), .clock(clk), .data(Dout), .wren(wr_en), .q(Din));

Processor Processor (.Din(Din), .clk(clk), .resetn(resetn), .run(run), .ADDR(ADDR), .Dout(Dout), .W(W), .Done(Done));

endmodule