module Ram #(parameter RAM_WIDTH = 4,  parameter ADDR_SIZE = 3)
(clk, state,reset_L, enable, addr_out, addr_in, data_in, data_out_c);

 input clk, reset_L, enable;   			//Habilitar escritura y lectura
 input [1:0] state;           			// Habilitar escritura o lectura                     
 input [RAM_WIDTH-1:0] data_in;          	//Bus de entrada
 input [ADDR_SIZE-1:0] addr_out, addr_in;	//Direcciones
 output reg [RAM_WIDTH-1:0] data_out_c;    	//Bus salida
 
 reg [RAM_WIDTH-1:0] mem [RAM_DEPTH-1:0];
 integer i;


localparam RAM_DEPTH = 2**ADDR_SIZE;


always @(posedge clk) begin 
	if (~reset_L) begin
	
		for (i = 0; i < RAM_DEPTH; i = i + 1) 
			mem [i] <= 0; 
			
	 end 
	 else begin 
	 	if (state==2 || state ==3) 
	 		mem[addr_in] <= data_in;
	 		
	  end 
end 

always @(*) begin 

	if ((state==1 || state ==3) && enable==1) 
	 	data_out_c = mem [addr_out];

	else
		data_out_c = 'b0;
end

endmodule

