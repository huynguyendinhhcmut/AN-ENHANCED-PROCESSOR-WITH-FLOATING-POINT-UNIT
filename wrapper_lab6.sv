module wrapper_lab6 (
	input logic CLOCK_50, CLK,
	input logic [9:9] SW,
	input logic [2:0] KEY,
	output logic [8:0] LEDR, 
	output logic [6:0] HEX0, HEX1, HEX2
);

logic [8:0] G, GF;
logic [3:0] g;
//logic CLK;

//clk_1Hz (.clk50M(CLOCK_50), .clk(CLK));
system system1 (.clk(CLK), .resetn(KEY[0]), .run(SW[9]), .G(G), .GF(GF));

D_FF9b (.clk(CLK), .rst(KEY[0]), .enable(~KEY[2]), .data_i(GF), .data_o(LEDR[8:0]));

assign g = {3'b000, G[8]};

display_hex displayhex0 (.enable(~KEY[1]), .data_in(G[3:0]), .display_out(HEX0));
display_hex displayhex1 (.enable(~KEY[1]), .data_in(G[7:4]), .display_out(HEX1));
display_hex displayhex2 (.enable(~KEY[1]), .data_in(g), .display_out(HEX2));

endmodule