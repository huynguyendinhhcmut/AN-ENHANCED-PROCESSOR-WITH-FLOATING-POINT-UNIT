module normalized (
	input logic cin, en_A, en_B, en_cin, clk50M, rst,
	output logic [3:0] Result_fract, smallerfract, fractright, fractleft,
	output logic [3:0] Result_exp, 
	output logic addsubexp, choose, result_sign, bigger_sign, smaller_sign, overflow, zero,
	output logic [15:0] total, total1, total2,
	output logic [14:0] totalshiftedfract, totalbiggerfract,
	output logic [3:0] shift_counter,
	output logic [4:0] Exp_diff, expdiff,
	output logic [4:0] Fract_diff,
	input logic [8:0] A, B,
	output logic [8:0] sumF
);

logic sign_A, sign_B;
logic [3:0] Exp_A, Exp_B;
logic [3:0] Fract_A, Fract_B;

assign sign_A = A[8];
assign Exp_A = A[7:4];
assign Fract_A = A[3:0];

assign sign_B = B[8];
assign Exp_B = B[7:4];
assign Fract_B = B[3:0];

assign sumF[8:0] = {result_sign, Result_exp, Result_fract};

assign totalbiggerfract [14] = 1'b1;
assign totalbiggerfract [9:0] = 11'b00000000000; 

bigger_smaller_fraction bsf1 (.Exp_A(Exp_A), .Exp_B(Exp_B), .Fract_A(Fract_A), .Fract_B(Fract_B), .Bigger_fract(totalbiggerfract[13:10]), .Smaller_fract(smallerfract), .Exp_diff(Exp_diff), .Fract_diff(Fract_diff), .choose(choose), .sign_A(sign_A), .sign_B(sign_B), .bigger_sign(bigger_sign), .smaller_sign(smaller_sign));

Exp_diff ExpDiff (.Exp_A(Exp_A), .Exp_B(Exp_B), .Exp_diff(expdiff));

mux8to1 mux82 (.sel(expdiff), .I0(1'b1),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),            .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[14]));
mux8to1 mux83 (.sel(expdiff), .I0(smallerfract[3]), .I1(1'b1),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),            .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[13]));
mux8to1 mux84 (.sel(expdiff), .I0(smallerfract[2]), .I1(smallerfract[3]), .I2(1'b1),            .I3(1'b0),            .I4(1'b0),            .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[12]));
mux8to1 mux85 (.sel(expdiff), .I0(smallerfract[1]), .I1(smallerfract[2]), .I2(smallerfract[3]), .I3(1'b1),            .I4(1'b0),            .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[11]));
mux8to1 mux86 (.sel(expdiff), .I0(smallerfract[0]), .I1(smallerfract[1]), .I2(smallerfract[2]), .I3(smallerfract[3]), .I4(1'b1),            .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[10]));
mux8to1 mux87 (.sel(expdiff), .I0(1'b0),            .I1(smallerfract[0]), .I2(smallerfract[1]), .I3(smallerfract[2]), .I4(smallerfract[3]), .I5(1'b1),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[9]));
mux8to1 mux88 (.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(smallerfract[0]), .I3(smallerfract[1]), .I4(smallerfract[2]), .I5(smallerfract[3]), .I6(1'b1),            .I7(1'b0),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[8]));
mux8to1 mux89 (.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(smallerfract[0]), .I4(smallerfract[1]), .I5(smallerfract[2]), .I6(smallerfract[3]), .I7(1'b1),            .I8(1'b0),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[7]));
mux8to1 mux810(.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(smallerfract[0]), .I5(smallerfract[1]), .I6(smallerfract[2]), .I7(smallerfract[3]), .I8(1'b1),            .I9(1'b0),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[6]));
mux8to1 mux811(.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),				  .I5(smallerfract[0]), .I6(smallerfract[1]), .I7(smallerfract[2]), .I8(smallerfract[3]), .I9(1'b1),            .I10(1'b0),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[5]));
mux8to1 mux812(.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),				  .I5(1'b0),            .I6(smallerfract[0]), .I7(smallerfract[1]), .I8(smallerfract[2]), .I9(smallerfract[3]), .I10(1'b1),            .I11(1'b0),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[4]));
mux8to1 mux813(.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),				  .I5(1'b0),            .I6(1'b0),				 .I7(smallerfract[0]), .I8(smallerfract[1]), .I9(smallerfract[2]), .I10(smallerfract[3]), .I11(1'b1),            .I12(1'b0),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[3]));
mux8to1 mux814(.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),				  .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(smallerfract[0]), .I9(smallerfract[1]), .I10(smallerfract[2]), .I11(smallerfract[3]), .I12(1'b1),            .I13(1'b0),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[2]));
mux8to1 mux815(.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),				  .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),            .I9(smallerfract[0]), .I10(smallerfract[1]), .I11(smallerfract[2]), .I12(smallerfract[3]), .I13(1'b1),            .I14(1'b0),            .I15(1'b0), .out(totalshiftedfract[1]));
mux8to1 mux816(.sel(expdiff), .I0(1'b0),            .I1(1'b0),            .I2(1'b0),            .I3(1'b0),            .I4(1'b0),				  .I5(1'b0),            .I6(1'b0),            .I7(1'b0),            .I8(1'b0),				.I9(1'b0),            .I10(smallerfract[0]), .I11(smallerfract[1]), .I12(smallerfract[2]), .I13(smallerfract[3]), .I14(1'b1),            .I15(1'b0), .out(totalshiftedfract[0]));
 
FA15b fa15b5 (.a(totalbiggerfract), .b(totalshiftedfract), .cin(1'b0), .sum(total1[14:0]), .cout(total1[15]));				
FA15b fa15b6 (.a(totalbiggerfract), .b(totalshiftedfract), .cin(1'b1), .sum(total2[14:0]), .cout(total2[15]));

totalBS (.cin(cin), .A(sign_A), .B(sign_B), .choose(choose), .total1(total1), .total2(total2), .total(total), .sign_result(result_sign));

encoder encoder1 (.i(total), .y(shift_counter));

mux2to1_add_sub mux21 (.I0(1'b0), .I1(1'b1), .sel(total[15:14]), .out(addsubexp));

logic [3:0] biggerexp0;
Exp_diff expdiff187 (.Exp_A(Exp_A), .Exp_B(Exp_B), .Final_exp(biggerexp0));

logic [4:0] resultexp;
FA4b fa4b1 (.a(biggerexp0), .b(shift_counter), .cin(addsubexp), .sum(resultexp[3:0]), .cout(resultexp[4]));
assign Result_exp [3:0] = resultexp [3:0];

mux_resultfract muxresultfract1 (.enable(~total[15]), .sel(shift_counter), .I0(total[13]), .I1(total[12]), .I2(total[11]), .I3(total[10]), .I4(total[9]),  .I5(total[8]),  .I6(total[7]), .I7(total[6]), .I8(total[5]), .I9(total[4]), .I10(total[3]), .I11(total[2]), .I12(total[1]), .I13(total[0]), .I14(1'b0), .I15(1'b0), .out(fractright[3]));
mux_resultfract muxresultfract2 (.enable(~total[15]), .sel(shift_counter), .I0(total[12]), .I1(total[11]), .I2(total[10]), .I3(total[9]),  .I4(total[8]),  .I5(total[7]),  .I6(total[6]), .I7(total[5]), .I8(total[4]), .I9(total[3]), .I10(total[2]), .I11(total[1]), .I12(total[0]), .I13(1'b0),     .I14(1'b0), .I15(1'b0), .out(fractright[2]));
mux_resultfract muxresultfract3 (.enable(~total[15]), .sel(shift_counter), .I0(total[11]), .I1(total[10]), .I2(total[9]),  .I3(total[8]),  .I4(total[7]),  .I5(total[6]),  .I6(total[5]), .I7(total[4]), .I8(total[3]), .I9(total[2]), .I10(total[1]), .I11(total[0]), .I12(1'b0),     .I13(1'b0),     .I14(1'b0), .I15(1'b0), .out(fractright[1]));
mux_resultfract muxresultfract4 (.enable(~total[15]), .sel(shift_counter), .I0(total[10]), .I1(total[9]),  .I2(total[8]),  .I3(total[7]),  .I4(total[6]),  .I5(total[5]),  .I6(total[4]), .I7(total[3]), .I8(total[2]), .I9(total[1]), .I10(total[0]), .I11(1'b0),     .I12(1'b0),     .I13(1'b0),     .I14(1'b0), .I15(1'b0), .out(fractright[0]));

mux_resultfract muxresultfract5 (.enable(total[15]), .sel(shift_counter), .I1(total[14]), .out(fractleft[3]));
mux_resultfract muxresultfract6 (.enable(total[15]), .sel(shift_counter), .I1(total[13]), .out(fractleft[2]));
mux_resultfract muxresultfract7 (.enable(total[15]), .sel(shift_counter), .I1(total[12]), .out(fractleft[1]));
mux_resultfract muxresultfract8 (.enable(total[15]), .sel(shift_counter), .I1(total[11]), .out(fractleft[0]));

mux2to1real muxprestige1 (.sel(total[15]), .I0(fractright[3]), .I1(fractleft[3]), .out(Result_fract[3]));
mux2to1real muxprestige2 (.sel(total[15]), .I0(fractright[2]), .I1(fractleft[2]), .out(Result_fract[2]));
mux2to1real muxprestige3 (.sel(total[15]), .I0(fractright[1]), .I1(fractleft[1]), .out(Result_fract[1]));
mux2to1real muxprestige4 (.sel(total[15]), .I0(fractright[0]), .I1(fractleft[0]), .out(Result_fract[0]));

Overflow Overflow1 (.Result_exp(Result_exp), .overflow(overflow));
Zero zero1 (.sign_A(sign_A), .sign_B(sign_B), .exp_diff(Exp_diff), .fract_diff(Fract_diff), .zero(zero));

endmodule