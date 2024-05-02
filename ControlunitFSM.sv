module ControlunitFSM (
	input logic clk, resetn, 
	input logic [8:0] Din, G,
	output logic [4:0] state,
	output logic Gout, Dinout, IRin, Ain, GFin, AFin, GFout,
	output logic Gin, AddSub, Done, AddSubF,
	output logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, ADDRin, Doutin, W_D, incr_pc,
	output logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R7out1, R7out2,
	output logic [8:0] IR
);

logic [7:0] outX, outY;
logic RXout, RYout, RXin, RYin;

D_FF9b dffIR (.clk(clk), .rst(resetn), .enable(IRin), .data_i(Din), .data_o(IR));

decoder3to8 decoder3to8RX (.in(IR[5:3]), .out(outX));
decoder3to8 decoder3to8RY (.in(IR[2:0]), .out(outY));

assign R0in = (outX[0] & RXin) | (outY[0] & RYin);
assign R1in = (outX[1] & RXin) | (outY[1] & RYin);
assign R2in = (outX[2] & RXin) | (outY[2] & RYin);
assign R3in = (outX[3] & RXin) | (outY[3] & RYin);
assign R4in = (outX[4] & RXin) | (outY[4] & RYin);
assign R5in = (outX[5] & RXin) | (outY[5] & RYin);
assign R6in = (outX[6] & RXin) | (outY[6] & RYin);
assign R7in = (outX[7] & RXin) | (outY[7] & RYin);

assign R0out = (outX[0] & RXout) | (outY[0] & RYout);
assign R1out = (outX[1] & RXout) | (outY[1] & RYout);
assign R2out = (outX[2] & RXout) | (outY[2] & RYout);
assign R3out = (outX[3] & RXout) | (outY[3] & RYout);
assign R4out = (outX[4] & RXout) | (outY[4] & RYout);
assign R5out = (outX[5] & RXout) | (outY[5] & RYout);
assign R6out = (outX[6] & RXout) | (outY[6] & RYout);
assign R7out1 = (outX[7] & RXout) | (outY[7] & RYout);

assign R7out = R7out1 ^ R7out2;

typedef enum bit [4:0] {reset		=	5'b00000, //0
								ldADDR 	=	5'b00001, //1
								PCp		=	5'b00010, //2
								fetch1 	=	5'b00011, //3
								fetch 	=	5'b00100, //4
								mv 		=	5'b00101, //5
								mvi1 		= 	5'b00110, //6
								mvi2  	=  5'b00111, //7
								mvi3		=	5'b01000, //8
								mvi4		=	5'b01001, //9
								add1 		= 	5'b01010, //10
								add2 		= 	5'b01011, //11
								add3 		= 	5'b01100, //12
								sub1	 	= 	5'b01101, //13
								sub2 		=	5'b01110, //14
								sub3 		= 	5'b01111, //15
								ld1		=	5'b10000, //16
								ld2 		=	5'b10001, //17
								ld3		=	5'b10010, //18
								st1		=	5'b10011, //19
								st2		=	5'b10100, //20
								st3		=	5'b10101, //21
								mvnz1		=	5'b10110, //22
								addf1		=	5'b10111, //23
								addf2		=	5'b11000, //24
								addf3		=	5'b11001} state_t;
state_t state_reg, state_next;

always_ff @(posedge clk or negedge resetn) begin
	if (!resetn)
		state_reg <= reset;
	else 
		state_reg <= state_next;
end

always @(*) begin
	state_next = state_reg;
	case (state_reg)
		reset:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
						if (!resetn) 
							state_next = reset;
						else if (resetn) state_next = ldADDR;
					end
		ldADDR: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b1;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b1;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = PCp;
				end	
		PCp: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0; 
					incr_pc = 1'b1;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = fetch1;
				end
		fetch1: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b1; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = fetch;
				end
		fetch: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b1; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
						if (IR[8:6] == 3'b000) begin
							state_next = mv;
						end else if (IR[8:6] == 3'b001) begin
							state_next = mvi1;
						end else if (IR[8:6] == 3'b010) begin
							state_next = add1;
						end else if (IR[8:6] == 3'b011) begin
							state_next = sub1;
						end else if (IR[8:6] == 3'b100) begin
							state_next = ld1;
						end else if (IR[8:6] == 3'b101) begin
							state_next = st1;
						end else if (IR[8:6] == 3'b110) begin
							state_next = mvnz1;
						end else if (IR[8:6] == 3'b111) begin
							state_next = addf1;
						end
					end
		mv:	begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ldADDR;
				end
		mvi1:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b1;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b1;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = mvi2;
				end
		mvi2: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;	
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = mvi3;
				end
		mvi3:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;	
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = mvi4;
				end
		mvi4:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b1; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;	
					incr_pc = 1'b1;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ldADDR;
				end
		add1:	begin
					RXout = 1'b1; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b1;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					incr_pc = 1'b0;	
					R7out2 = 1'b0;	
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;			
					state_next = add2;
				end
		add2:	begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b1; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;				
					state_next = add3;
				end
		add3:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b1;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b1;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;	
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ldADDR;
				end
		sub1:	begin
					RXout = 1'b1; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b1;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = sub2;
				end
		sub2:	begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b1; 
					AddSub = 1'b1; 
					Done = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = sub3;
				end
		sub3: begin	
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b1;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ldADDR;
				end
		ld1: begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b1;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ld2;
				end
		ld2: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ld3;
				end	
		ld3: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b1; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ldADDR;
				end
		st1: begin
					RXout = 1'b1; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b1;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = st2;
				end
		st2: begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b1;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = st3;
				end
		st3: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b1;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = ldADDR;
				end
		mvnz1: begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b1;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
						if (G != 0) begin
							state_next = mv;
						end else if (G == 0) begin
							state_next = ldADDR;
						end	
				end
		addf1: begin
					RXout = 1'b1; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b1;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b0;
					state_next = addf2;
				end
		addf2: begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b0;
					AddSubF = 1'b0;
					GFout = 1'b0;
					GFin = 1'b1;
					state_next = addf3;
				end
		addf3: begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;
					ADDRin = 1'b0;
					Doutin = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					AFin = 1'b1;
					AddSubF = 1'b0;
					GFout = 1'b1;
					GFin = 1'b0;
					state_next = ldADDR;
				end
	endcase
end
assign state = state_reg;
endmodule