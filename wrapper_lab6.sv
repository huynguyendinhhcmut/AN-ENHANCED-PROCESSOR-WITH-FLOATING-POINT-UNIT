module wrapper_lab6 (
	input logic CLOCK_50,
	input logic [9:9] SW,
	input logic [1:0] KEY,
	output logic [8:0] LEDR
);

system system1 (.clk(KEY[1]), .resetn(KEY[0]), .run(SW[9]), .LEDS(LEDR[8:0]));

endmodule