`timescale 	1s				/ 100ps
// escala	unidad temporal (valor de "#4") / precisión
// Pueden omitirse y llamarse desde el testbench

`include "fifo_cond.v"
`include "fifo_estruc.v"
`include "probador_FIFO.v"
`include "cmos_cells.v"

module BancoPrueba_Mux;
	
    wire clk;
    wire reset_L;
    wire enable2;
    wire [ADDR_W-1:0] buffer_empty; 
    wire [ADDR_W-1:0] buffer_full; 
    wire push;        
    wire pop;         
    wire [DATA_W-1:0] data_in; 
    
    wire [DATA_W-1:0] data_out_c;
    wire error_c;
    wire almost_empty_c; 
    wire almost_full_c; 
    wire empty_c;       
    wire full_out_c;
    	
    wire [DATA_W-1:0] data_out_c_estruc;
    wire error_c_estruc;
    wire almost_empty_c_estruc; 
    wire almost_full_c_estruc; 
    wire empty_c_estruc;       
    wire full_out_c_estruc;
    	
    	
    	
    	
    parameter DATA_W = 6;
    parameter ADDR_W = 2;
    

	fifo_cond fifo_cond_inst( /*AUTOINST*/
				 // Outputs
				 .data_out_c		(data_out_c[DATA_W-1:0]),
				 .error_c		(error_c),
				 .almost_empty_c	(almost_empty_c),
				 .almost_full_c		(almost_full_c),
				 .empty_c		(empty_c),
				 .full_out_c		(full_out_c),
				 // Inputs
				 .clk			(clk),
				 .reset_L		(reset_L),
				 .enable2		(enable2),
				 .buffer_empty		(buffer_empty[ADDR_W-1:0]),
				 .buffer_full		(buffer_full[ADDR_W-1:0]),
				 .push			(push),
				 .pop			(pop),
				 .data_in		(data_in[DATA_W-1:0]));
						     
	
	fifo_estruc fifo_estruc_inst(/*AUTOINST*/
				     // Outputs
				     .almost_empty_c_estruc(almost_empty_c_estruc),
				     .almost_full_c_estruc(almost_full_c_estruc),
				     .data_out_c_estruc	(data_out_c_estruc[5:0]),
				     .empty_c_estruc	(empty_c_estruc),
				     .error_c_estruc	(error_c_estruc),
				     .full_out_c_estruc	(full_out_c_estruc),
				     // Inputs
				     .buffer_empty	(buffer_empty[1:0]),
				     .buffer_full	(buffer_full[1:0]),
				     .clk		(clk),
				     .data_in		(data_in[5:0]),
				     .enable2		(enable2),
				     .pop		(pop),
				     .push		(push),
				     .reset_L		(reset_L));
	
	
	
	
	// Probador: generador de señales y monitor
	probador_FIFO Probador_Inst( /*AUTOINST*/
				    // Outputs
				    .clk		(clk),
				    .reset_L		(reset_L),
				    .enable2		(enable2),
				    .buffer_empty	(buffer_empty[2-1:0]),
				    .buffer_full	(buffer_full[2-1:0]),
				    .push		(push),
				    .pop		(pop),
				    .data_in		(data_in[6-1:0]),
				    // Inputs
				    .data_out_c		(data_out_c[6-1:0]),
				    .error_c		(error_c),
				    .almost_empty_c	(almost_empty_c),
				    .almost_full_c	(almost_full_c),
				    .empty_c		(empty_c),
				    .full_out_c		(full_out_c),
				    .data_out_c_estruc	(data_out_c_estruc[6-1:0]),
				    .error_c_estruc	(error_c_estruc),
				    .almost_empty_c_estruc(almost_empty_c_estruc),
				    .almost_full_c_estruc(almost_full_c_estruc),
				    .empty_c_estruc	(empty_c_estruc),
				    .full_out_c_estruc	(full_out_c_estruc));
endmodule
