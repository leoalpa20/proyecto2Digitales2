module Probador(
	//Salidas
	output reg clk,
    	output reg reset_L,
    	output reg enable2,
    	output reg [2-1:0] buffer_empty, 
    	output reg [2-1:0] buffer_full,
    	output reg push,      
    	output reg pop,         
    	output reg [6-1:0] data_in,	
	//Entradas
	input [6-1:0] data_out_c,
    	input error_c,
    	input almost_empty_c, 
    	input almost_full_c, 
    	input empty_c,     
    	input full_out_c,
    	
    	input [6-1:0] data_out_c_estruc,
    	input error_c_estruc,
    	input almost_empty_c_estruc, 
    	input almost_full_c_estruc, 
    	input empty_c_estruc,       
    	input full_out_c_estruc
    	
    	);
	
	integer idx;
	
	initial begin
		$dumpfile("FIFO.vcd");
		$dumpvars;
		$display ("\t\t\tclk,\treset_L,\tbuffer_empty,\tbuffer_full,\tpush,\tpop,\tdata_in,\tdata_out_c,\terror_c,\talmost_empty_c,\talmost_full_c,\tempty_c,\tfull_out_c,\tdata_out_c_estruc,\terror_c_estruc,\talmost_empty_c_estruc,\talmost_full_c_estruc,\tempty_c_estruc,\tfull_out_c_estruc,\tenable2");
		$monitor($time,"\t%b\t%b\t\t%b\t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b",clk,reset_L,buffer_empty,buffer_full,push,pop,data_in,data_out_c,error_c,almost_empty_c,almost_full_c,empty_c,full_out_c,data_out_c_estruc,error_c_estruc,almost_empty_c_estruc,almost_full_c_estruc,empty_c_estruc,full_out_c_estruc,enable2);           
		
		#50;
		@(posedge clk);
		reset_L   <=0;
		@(posedge clk);
		push	<=0;
		pop	<=0;
		buffer_full <=3;
		buffer_empty <=1;
		//state 	<= 0;
		enable2 	<= 1;
        	reset_L   <=1;
		@(posedge clk);
		
		for (idx = 0; idx < (1<<2); idx = idx + 1) begin
			data_in	<= 7-idx;
			@(posedge clk);
			push	<=1;
		end
		push	<=0;
		
		//state 	<= 1;
		for (idx = 0; idx < (1<<2); idx = idx + 1) begin
			@(posedge clk);
			pop		<=1;
		end
		pop		<=0;
		//enable 	<= 1;
		@(posedge clk);
		push	<=1;
		pop		<=0;
		data_in	<= 'h3;
		@(posedge clk);
		push	<=1;
		pop		<=1;
		data_in	<= 'h6;
		
		@(posedge clk);
		push	<=1;
		pop		<=1;
		data_in	<= 'h8;
		@(posedge clk);
		
		@(posedge clk);
		//state 	<= 0;
		push	<=0;
		pop		<=1;
		data_in	<= 'hF;
		
		@(posedge clk);
		//enable 	<= 1;
		reset_L 	<=0;
		@(posedge clk);
		reset_L<=1;
		pop<=0;
		@(posedge clk);
		data_in <= 'h5;
			pop<=0;
			push<=1;
		@(posedge clk);
		data_in <= 'hA;
			pop<=0;
			push<=1;
			//pop<=1;
		@(posedge clk);
		data_in <= 'h6;
			push<=1;
			pop<=1;
		@(posedge clk);
		data_in <= 'h5;
			push<=1;
			
		@(posedge clk);
		data_in <= 'h5;
			push<=1;
			pop<=1;
		repeat(20)
		begin
			@(posedge clk);
			//data_in <= 'h5;
			//push<=1;
			//pop<=1;
		end
		
		$finish;
		
	end
	
	// Reloj
	initial	clk	<= 0;			// Valor inicial al reloj, sino siempre será indeterminado
	always  #10 clk 	<= ~clk;		// Hace "toggle" cada 4 segundos
	
	
	
	
	
endmodule
