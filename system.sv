module system (
	input logic clk, resetn, run,
	output logic [8:0] LEDS,
	output logic [8:0] G, GF,
	output logic Done
);

logic leds,wr_en, W;
logic [8:0] ADDR, Dout, Din;
 
assign A7A81 = ~(ADDR[7] | ADDR[8]); 
assign A7A82 = ~(~ADDR[7] | ADDR[8]);
assign wr_en = A7A81 & W;
assign leds = W & A7A82;

D_FF_enable dffleds (.clk(clk), .rst(resetn), .enable(leds), .data_i(Dout), .data_o(LEDS));

RAM Memory (.address(ADDR[6:0]), .clock(clk), .data(Dout), .wren(wr_en), .q(Din));

Processor Processor (.Din(Din), .clk(clk), .resetn(resetn), .run(run), .ADDR(ADDR), .Dout(Dout), .W(W), .Done(Done), .G(G), .GF(GF));

endmodule