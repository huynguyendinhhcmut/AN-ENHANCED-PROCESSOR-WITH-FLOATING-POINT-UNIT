module display_hex (
	input logic enable,
   input [3:0] data_in,
   output reg [6:0] display_out 
);
	 
always @(*) begin
	if (enable == 1) begin
	case (data_in)
        4'b0000:
            display_out = 7'b1000000;  //zero
        4'b0001:
            display_out = 7'b1111001;  //one
        4'b0010:
            display_out = 7'b0100100;  //two
        4'b0011:
            display_out = 7'b0110000;  //three
        4'b0100:
            display_out = 7'b0011001;  //four
        4'b0101:
            display_out = 7'b0010010;  //five
        4'b0110:
            display_out = 7'b0000010;  //six
        4'b0111:
            display_out = 7'b1111000;  //seven
        4'b1000:
            display_out = 7'b0000000;  //eight
        4'b1001:
            display_out = 7'b0010000;  //nine
        4'b1010:
            display_out = 7'b0001000;  //A
        4'b1011:
            display_out = 7'b0000011;  //b
        4'b1100:
            display_out = 7'b1000110;  //C
        4'b1101:
            display_out = 7'b0100001;  //d
        4'b1110:
            display_out = 7'b0000110;  //E
        4'b1111:
            display_out = 7'b0001110;  //F
    endcase
	 end
end
endmodule