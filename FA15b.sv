module FA15b (
	input logic [14:0] a,
	input logic [14:0] b,
	input logic cin,
	output logic [14:0] sum,
	output logic cout
);

logic [14:0] carry;

FA fa1 (.sum(sum[0]), .a(a[0]), .b(b[0]^cin), .cin(cin), .cout(carry[0])); 		
FA fa2 (.sum(sum[1]), .a(a[1]), .b(b[1]^cin), .cin(carry[0]), .cout(carry[1]));	
FA fa3 (.sum(sum[2]), .a(a[2]), .b(b[2]^cin), .cin(carry[1]), .cout(carry[2]));	
FA fa4 (.sum(sum[3]), .a(a[3]), .b(b[3]^cin), .cin(carry[2]), .cout(carry[3]));	
FA fa5 (.sum(sum[4]), .a(a[4]), .b(b[4]^cin), .cin(carry[3]), .cout(carry[4]));	
FA fa6 (.sum(sum[5]), .a(a[5]), .b(b[5]^cin), .cin(carry[4]), .cout(carry[5]));
FA fa7 (.sum(sum[6]), .a(a[6]), .b(b[6]^cin), .cin(carry[5]), .cout(carry[6]));	
FA fa8 (.sum(sum[7]), .a(a[7]), .b(b[7]^cin), .cin(carry[6]), .cout(carry[7]));
FA fa9 (.sum(sum[8]), .a(a[8]), .b(b[8]^cin), .cin(carry[7]), .cout(carry[8]));	
FA fa10 (.sum(sum[9]), .a(a[9]), .b(b[9]^cin), .cin(carry[8]), .cout(carry[9]));
FA fa11 (.sum(sum[10]), .a(a[10]), .b(b[10]^cin), .cin(carry[9]), .cout(carry[10]));
FA fa12 (.sum(sum[11]), .a(a[11]), .b(b[11]^cin), .cin(carry[10]), .cout(carry[11]));
FA fa13 (.sum(sum[12]), .a(a[12]), .b(b[12]^cin), .cin(carry[11]), .cout(carry[12]));
FA fa14 (.sum(sum[13]), .a(a[13]), .b(b[13]^cin), .cin(carry[12]), .cout(carry[13]));
FA fa15 (.sum(sum[14]), .a(a[14]), .b(b[14]^cin), .cin(carry[13]), .cout(carry[14]));

xor (cout, carry[14], cin);

endmodule