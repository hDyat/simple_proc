`timescale 1ns / 1ps

module testbench ();
	reg MClock, PClock, Run, Resetn;
	
	wire [8:0] DIN;
	wire Done;
	wire [8:0] BusWires;
	wire [4:0] address; 
	
	proc p1 (PClock, Resetn, Run, DIN, Done, BusWires);
	
	//Rom instantiate
	inst_mem rom (address, MClock, DIN);
	
	//counter instantiate
	counter count (MClock, Resetn, address);
	
	initial 
	begin
		Run <= 1'b1; Resetn <= 1'b1;
		#20 Resetn <= 1'b0;
	end // initial

	initial begin
		MClock <= 1'b0; PClock <= 1'b0;
		#10 MClock <= 1'b1; PClock <= 1'b1;		// MClock, PClock
		#10 MClock <= 1'b0; PClock <= 1'b0;
		#10 MClock <= 1'b1;							// MClock
		#10 MClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0; MClock <= 1'b1;
		#10 MClock <= 1'b0; PClock <= 1'b1;		// MClock, PClock
		#10 MClock <= 1'b1; PClock <= 1'b0;
		#10 PClock <= 1'b0;							// PClock
		#10 PClock <= 1'b0;
		#10 MClock <= 1'b1; PClock <= 1'b1;		// MClock, PClock
		#10 MClock <= 1'b0; PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 MClock <= 1'b1; PClock <= 1'b1;		// MClock, PClock
		#10 MClock <= 1'b0; PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 MClock <= 1'b1; PClock <= 1'b1;		// MClock, PClock
		#10 MClock <= 1'b0; PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 MClock <= 1'b1; PClock <= 1'b1;		// MClock, PClock
		#10 MClock <= 1'b0; PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
		#10 PClock <= 1'b1;							// PClock
		#10 PClock <= 1'b0;
	end // initial
endmodule