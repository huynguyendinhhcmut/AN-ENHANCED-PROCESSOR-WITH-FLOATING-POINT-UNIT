module counterR7 (
	input logic R7in, rst, clk, incr_pc,
	input logic [8:0] PC,
	output logic [8:0] R7, pc
);

always_ff @(posedge clk or negedge rst) begin
	if (!rst) begin
		pc <= 0;
	end else if (incr_pc == 0 && R7in == 0) begin
		pc <= pc;
	end else if (incr_pc == 1 && R7in == 0) begin
		pc <= pc + 1;
	end else if (incr_pc == 1 && R7in == 1) begin
		pc <= pc + 1;
		pc <= PC;
	end else if (incr_pc == 0 && R7in == 1) begin
		pc <= PC;
	end 
	R7 <= pc;
end
endmodule