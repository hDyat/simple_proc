module proc(Clock, Resetn, Run, DIN, Done, BusWires);
	input Clock, Resetn, Run;
	input [8:0] DIN;
	output Done;
	output [8:0] BusWires;
	
	parameter T0 = 4'b0000, T1 = 4'b0011, T2 = 4'b0101, T3 = 4'b1001;
	
	reg [0:7] Rin, Rout;
	reg Ain, IRin, AddSub, Gin, Gout, DINout;
	reg [3:0] Tstep_Q, Tstep_D;
	reg Done;
	reg [8:0] BusWires;
	
	wire [1:9] IR;
	wire [0:7] Xreg, Yreg;
	wire [2:0] I;
	wire [2:0] X, Y;
	
	wire [8:0] R7, R6, R5, R4, R3, R2, R1, R0, A, G, AddSub_result;
	wire [9:0] Sel;
	
	assign I = IR[1:3];
	assign X = IR[4:6];
	assign Y = IR[7:9];
	dec3to8 decX (IR[4:6], 1'b1, Xreg);
	dec3to8 decY (IR[7:9], 1'b1, Yreg);
	
	//Control FSM state table
	always @ (Tstep_Q, Run, Done)
	begin
		case (Tstep_Q)
			T0:	if (!Run) 	Tstep_D = T0;
				else		Tstep_D = T1;
			T1: if (Done) 	Tstep_D = T0;
				else		Tstep_D = T2;
			T2: 			Tstep_D = T3;
			T3:				Tstep_D = T0;
			default:		Tstep_D = 4'bxxxx;
		endcase
	end 
	
	//Control FSM outputs
	always @ (Tstep_Q or I or Xreg or Yreg)
	begin
		IRin = 1'b0;
		Rin = 1'b0;
		Rout = 1'b0;
		DINout = 1'b0;
		AddSub = 1'b0;
		Ain = 1'b0;
		Gin = 1'b0;
		Gout = 1'b0;
		Done = 1'b0;
		case (Tstep_Q)
			T0: //store DIn in IR in time step 0
			begin
				IRin = 1'b1;
			end
			T1: //define signals in time step 1
				case (I)
					3'b000: begin
								Rin = Xreg;
								Rout = Yreg;
								Done = 1'b1;
							end 
					3'b001: begin
								DINout = 1'b1;
								Rin = Xreg;
								Done = 1'b1;
							end
					3'b010: begin
								Ain = 1'b1;
								Rout = Xreg;
							end 
					3'b011: begin
								Rout = Xreg;
								Ain = 1'b1;
							end
				endcase
			T2: //define signals in time step 2
				case (I)
					3'b010: begin
								Rout = Yreg;
								Gin = 1'b1;
							end 
					3'b011: begin
								Rout = Yreg;
								Gin = 1'b1;
								AddSub = 1'b1;
							end 
				endcase
			T3: //define signals in time step 3
				case (I)
					3'b010: begin
								Gout = 1'b1;
								Rin = Xreg;
								Done = 1'b1;
							end
					3'b011: begin
								Gout = 1'b1;
								Rin = Xreg;
								Done = 1'b1;
							end
				endcase 
		endcase 
	end

	//Control Fsm flip-flops
	always @ (posedge Clock, posedge Resetn)
		if (Resetn)
			Tstep_Q <= T0;
		else
			Tstep_Q <= Tstep_D;
	
	regn reg_0 (BusWires, Rin[0], Clock, R0);
	regn reg_1 (BusWires, Rin[1], Clock, R1);
	regn reg_2 (BusWires, Rin[2], Clock, R2);
	regn reg_3 (BusWires, Rin[3], Clock, R3);
	regn reg_4 (BusWires, Rin[4], Clock, R4);
	regn reg_5 (BusWires, Rin[5], Clock, R5);
	regn reg_6 (BusWires, Rin[6], Clock, R6);
	regn reg_7 (BusWires, Rin[7], Clock, R7);
	
	regn reg_IR (DIN, IRin, Clock, IR);
	regn reg_A (BusWires, Ain, Clock, A);
	regn reg_G (AddSub_result, Gin, Clock, G);
	
	adder_subtractor addsub (AddSub, A, BusWires, AddSub_result);
	
	assign Sel = {Rout, Gout, DINout};
	
	always @ (*)
		case (Sel)
			10'b10_0000_0000 : BusWires = R0;
			10'b01_0000_0000 : BusWires = R1;
			10'b00_1000_0000 : BusWires = R2;
			10'b00_0100_0000 : BusWires = R3;
			10'b00_0010_0000 : BusWires = R4;
			10'b00_0001_0000 : BusWires = R5;
			10'b00_0000_1000 : BusWires = R6;
			10'b00_0000_0100 : BusWires = R7;
			10'b00_0000_0010 : BusWires = G;
			10'b00_0000_0001 : BusWires = DIN; 
		endcase
		
endmodule