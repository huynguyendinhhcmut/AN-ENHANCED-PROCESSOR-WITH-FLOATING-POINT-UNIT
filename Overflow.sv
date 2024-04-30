module Overflow (
	input logic [3:0] Result_exp,
	output logic overflow
);

assign overflow = Result_exp[0] & Result_exp[1] & Result_exp[2] & Result_exp[3];

endmodule