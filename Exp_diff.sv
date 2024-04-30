module Exp_diff (
	input logic [3:0] Exp_A, Exp_B,
	output logic [4:0] Exp_diff,
	output logic [3:0] Final_exp, Bigger_exp, Smaller_exp
);

FA4b fa4b1 ( .a(Exp_A), .b(Exp_B), .cin(1'b1), .sum(Exp_diff[3:0]), .cout(Exp_diff[4]));

always_comb begin
	case (Exp_diff[4])
		1'b0: begin
				Final_exp = Exp_A;
				Bigger_exp = Exp_A;
				Smaller_exp = Exp_B;
				end
		1'b1: begin
				Final_exp = Exp_B;
				Bigger_exp = Exp_B;
				Smaller_exp = Exp_A;
				end
	endcase
end

endmodule