module Probador(
	//Salidas
	output reg clk,                
	output reg reset_L,
	output reg enable,                     
	output reg [1:0] state,                  
	output reg [3:0] data_in,
	output reg [2: 0] addr_in,
	output reg [2: 0] addr_out,
	//Entradas
	input	[3:0] data_out_c,
	input [3:0] data_out_c_Estruc);
	
	initial begin
		$dumpfile("Ram.vcd");
		$dumpvars;
		$display ("\t\t\tclk,\treset_L,\tstate,\tdata_in,\taddr_in,\taddr_out,\tdata_out_c_Estruc,\tenable");
		$monitor($time,"\t%b\t%b\t\t%b\t\t%b\t%b\t%b\t%b",clk,reset_L,state,data_in,addr_in,addr_out,data_out_c_Estruc,enable);           
		
		enable = 'b0;
		reset_L = 'b0;
		data_in = 'b0;
		state = 'b0;
		addr_in = 'b0;
		addr_out = 'b0;
		
		#7 reset_L = 'b1;
		enable = 'b1;
		
        		repeat(8) begin
        		@(posedge clk);
        		state <= 2;
        		data_in <= data_in+1;
        		addr_in <= addr_in+1;
        		end
        		
        		repeat(8) begin
        		@(posedge clk);
        		state <= 1;
        		
        		addr_out <= addr_out+1;
        		end
        		
        		
        		repeat(8) begin
        		@(posedge clk);
        		state <= 3;
        		
        		data_in <= data_in+2;
        		addr_in <= addr_in+1;
        		#2 addr_out <= addr_out+1;
        		end
        		
        		
        		
        		
        		
        		@(posedge clk);
        		data_in <= data_in+1;
        		
        		@(posedge clk);
        		state <= 2;
        		
        		@(posedge clk);
        		addr_out <= 'b011;
        		
        		@(posedge clk);
        		state <= 1;
        		
        		@(posedge clk);
        		addr_out <= 'b101;
        		
        		@(posedge clk);
        		state <= 1;
		
		
		#30 enable = 'b0;
		#6  data_in <= data_in+1;
        	state <= state+1;
        	addr_in <= addr_in+1;
        	addr_out <= addr_out+1;
		
		
		$finish;
		
	end
	
	// Reloj
	initial	clk	<= 0;			// Valor inicial al reloj, sino siempre será indeterminado
	always  #1 clk 	<= ~clk;		// Hace "toggle" cada 4 segundos
	
	
	
	
	
endmodule
