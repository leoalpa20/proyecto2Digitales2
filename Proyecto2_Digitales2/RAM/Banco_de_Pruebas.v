`timescale 	1s				/ 100ps
// escala	unidad temporal (valor de "#4") / precisión
// Pueden omitirse y llamarse desde el testbench

`include "Ram.v"
`include "Ram_Estruc.v"
`include "Probador.v"
`include "cmos_cells.v"

module BancoPruebas;
	wire clk, reset_L;       			//Habilitar escritura y lectura
 	wire [1:0] state;           			// Habilitar escritura o lectura
 	wire enable;                             
 	wire [3:0] data_in;          	//Bus de entrada
 	wire [2: 0] addr_out, addr_in;	//Direcciones
 	wire [3:0] data_out_c;    	//Bus salida
 	wire [3:0] data_out_c_Estruc;
    	
    	parameter RAM_WIDTH = 4; 			//Cantidad de bits
 	parameter RAM_DEPTH = 8; 			//Numero de entradas
 	parameter ADDR_SIZE = 3; 			//Bits de las direcciones

	Ram Ram_inst( /*AUTOINST*/
		     // Outputs
		     .data_out_c	(data_out_c[RAM_WIDTH-1:0]),
		     // Inputs
		     .clk		(clk),
		     .reset_L		(reset_L),
		     .enable		(enable),
		     .state		(state[1:0]),
		     .data_in		(data_in[RAM_WIDTH-1:0]),
		     .addr_out		(addr_out[ADDR_SIZE-1:0]),
		     .addr_in		(addr_in[ADDR_SIZE-1:0]));
						  
	
	Ram_Estruc Ram_Estruc_inst( /*AUTOINST*/
				   // Outputs
				   .data_out_c_Estruc	(data_out_c_Estruc[3:0]),
				   // Inputs
				   .addr_in		(addr_in[2:0]),
				   .addr_out		(addr_out[2:0]),
				   .clk			(clk),
				   .data_in		(data_in[3:0]),
				   .enable		(enable),
				   .reset_L		(reset_L),
				   .state		(state[1:0]));
	
	
	// Probador: generador de señales y monitor
	Probador Probador_Instanciado( /*AUTOINST*/
				      // Outputs
				      .clk		(clk),
				      .reset_L		(reset_L),
				      .enable		(enable),
				      .state		(state[1:0]),
				      .data_in		(data_in[3:0]),
				      .addr_in		(addr_in[2:0]),
				      .addr_out		(addr_out[2:0]),
				      // Inputs
				      .data_out_c	(data_out_c[3:0]),
				      .data_out_c_Estruc(data_out_c_Estruc[3:0]));
endmodule
