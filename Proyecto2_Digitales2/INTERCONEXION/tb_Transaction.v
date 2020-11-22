// Banco de Pruebas para el modulo

`timescale 10ns/1ns
`include "t_Transaction.v"
`include "Transaction_COND.v"
`include "Transaction_STRUC.v"
`include "cmos_cells.v"

module Transaction_tb;
     parameter RESET = 'b00001;  //1
     parameter INIT = 'b00010;   //2
     parameter IDLE = 'b00100;   //4
     parameter ACTIVE = 'b01000; //8
     parameter ERROR = 'b10000;  //10
     parameter DATA_W = 6;
     parameter MF_SIZE = 2;
     parameter VC_SIZE = 3;
     parameter D_SIZE = 2;

    
    
    wire		active_out_c;		// From Transaction_COND_ of Transaction_COND.v
    wire		almost_D0_empty_sig_in;	// From Transaction_COND_ of Transaction_COND.v
    wire		almost_D1_empty_sig_in;	// From Transaction_COND_ of Transaction_COND.v
    wire		almost_full_MF_c;	// From Transaction_COND_ of Transaction_COND.v
    wire		clk;			// From t_Transaction_ of t_Transaction.v
    wire [DATA_W-1:0]	data_in;		// From t_Transaction_ of t_Transaction.v
    wire [DATA_W-1:0]	data_out_0_c;		// From Transaction_COND_ of Transaction_COND.v
    wire [DATA_W-1:0]	data_out_1_c;		// From Transaction_COND_ of Transaction_COND.v
    wire		error_out_c;		// From Transaction_COND_ of Transaction_COND.v
    wire		idle_out_c;		// From Transaction_COND_ of Transaction_COND.v
    
    
    	wire  [DATA_W-1: 0] data_out_0_es; 	// principales salidas
	wire  [DATA_W-1: 0] data_out_1_es;
	wire error_out_es;			// error de salida
	wire active_out_es;
	wire idle_out_es; 			// Pausa, estar quieto sin hacer nada
	wire almost_full_MF_es;
	wire almost_D0_empty_sig_in_es; 	// FIFO D0 casi vacio
	wire almost_D1_empty_sig_in_es; 	// FIFO D1 casi vacio
    
    
    wire		init;			// From t_Transaction_ of t_Transaction.v
    wire		pop_D0;			// From t_Transaction_ of t_Transaction.v
    wire		pop_D1;			// From t_Transaction_ of t_Transaction.v
    wire		push_MF;		// From t_Transaction_ of t_Transaction.v
    wire		reset;			// From t_Transaction_ of t_Transaction.v
    wire [D_SIZE-1:0]	D_full_umbral_in;	// From t_Transaction_ of t_Transaction.v
    wire [MF_SIZE-1:0]	MF_full_umbral_in;	// From t_Transaction_ of t_Transaction.v
    wire [VC_SIZE-1:0]	VC_full_umbral_in;	// From t_Transaction_ of t_Transaction.v
    wire [D_SIZE-1:0]	D_empty_umbral_in;	// From t_Transaction_ of t_Transaction.v
    wire [MF_SIZE-1:0]	MF_empty_umbral_in;	// From t_Transaction_ of t_Transaction.v
    wire [VC_SIZE-1:0]	VC_empty_umbral_in;	// From t_Transaction_ of t_Transaction.v
    
    t_Transaction #(/*AUTOINSTPARAM*/
		    // Parameters
		    .DATA_W		(DATA_W),
		    .MF_SIZE		(MF_SIZE),
		    .VC_SIZE		(VC_SIZE),
		    .D_SIZE		(D_SIZE)) t_Transaction_
    (/*AUTOINST*/
     // Outputs
     .clk				(clk),
     .reset				(reset),
     .init				(init),
     .MF_full_umbral_in			(MF_full_umbral_in[MF_SIZE-1:0]),
     .VC_full_umbral_in			(VC_full_umbral_in[VC_SIZE-1:0]),
     .D_full_umbral_in			(D_full_umbral_in[D_SIZE-1:0]),
     .MF_empty_umbral_in		(MF_empty_umbral_in[MF_SIZE-1:0]),
     .VC_empty_umbral_in		(VC_empty_umbral_in[VC_SIZE-1:0]),
     .D_empty_umbral_in			(D_empty_umbral_in[D_SIZE-1:0]),
     .enable				(enable),
     .push_MF				(push_MF),
     .pop_D0				(pop_D0),
     .pop_D1				(pop_D1),
     .data_in				(data_in[DATA_W-1:0]),
     // Inputs
     .data_out_0_c			(data_out_0_c[DATA_W-1:0]),
     .data_out_1_c			(data_out_1_c[DATA_W-1:0]),
     .error_out_c			(error_out_c),
     .active_out_c			(active_out_c),
     .idle_out_c			(idle_out_c),
     .almost_full_MF_c			(almost_full_MF_c),
     .almost_D0_empty_sig_in		(almost_D0_empty_sig_in),
     .almost_D1_empty_sig_in		(almost_D1_empty_sig_in),
     .data_out_0_es			(data_out_0_es[DATA_W-1:0]),
     .data_out_1_es			(data_out_1_es[DATA_W-1:0]),
     .error_out_es			(error_out_es),
     .active_out_es			(active_out_es),
     .idle_out_es			(idle_out_es),
     .almost_full_MF_es			(almost_full_MF_es),
     .almost_D0_empty_sig_in_es		(almost_D0_empty_sig_in_es),
     .almost_D1_empty_sig_in_es		(almost_D1_empty_sig_in_es));

	Transaction_COND #(/*AUTOINSTPARAM*/
			   // Parameters
			   .DATA_W		(DATA_W),
			   .MF_SIZE		(MF_SIZE),
			   .VC_SIZE		(VC_SIZE),
			   .D_SIZE		(D_SIZE),
			   .RESET		(RESET),
			   .INIT		(INIT),
			   .IDLE		(IDLE),
			   .ACTIVE		(ACTIVE),
			   .ERROR		(ERROR)) Transaction_COND_
    (/*AUTOINST*/
     // Outputs
     .data_out_0_c			(data_out_0_c[DATA_W-1:0]),
     .data_out_1_c			(data_out_1_c[DATA_W-1:0]),
     .error_out_c			(error_out_c),
     .active_out_c			(active_out_c),
     .idle_out_c			(idle_out_c),
     .almost_full_MF_c			(almost_full_MF_c),
     .almost_D0_empty_sig_in		(almost_D0_empty_sig_in),
     .almost_D1_empty_sig_in		(almost_D1_empty_sig_in),
     // Inputs
     .clk				(clk),
     .reset				(reset),
     .init				(init),
     .MF_full_umbral_in			(MF_full_umbral_in[MF_SIZE-1:0]),
     .VC_full_umbral_in			(VC_full_umbral_in[VC_SIZE-1:0]),
     .D_full_umbral_in			(D_full_umbral_in[D_SIZE-1:0]),
     .MF_empty_umbral_in		(MF_empty_umbral_in[MF_SIZE-1:0]),
     .VC_empty_umbral_in		(VC_empty_umbral_in[VC_SIZE-1:0]),
     .D_empty_umbral_in			(D_empty_umbral_in[D_SIZE-1:0]),
     .enable				(enable),
     .push_MF				(push_MF),
     .pop_D0				(pop_D0),
     .pop_D1				(pop_D1),
     .data_in				(data_in[DATA_W-1:0]));

    Transaction_STRUC #(/*AUTOINSTPARAM*/) Transaction_STRUC_
    (/*AUTOINST*/
     // Outputs
     .active_out_es			(active_out_es),
     .almost_D0_empty_sig_in_es		(almost_D0_empty_sig_in_es),
     .almost_D1_empty_sig_in_es		(almost_D1_empty_sig_in_es),
     .almost_full_MF_es			(almost_full_MF_es),
     .data_out_0_es			(data_out_0_es[5:0]),
     .data_out_1_es			(data_out_1_es[5:0]),
     .error_out_es			(error_out_es),
     .idle_out_es			(idle_out_es),
     // Inputs
     .D_empty_umbral_in			(D_empty_umbral_in[1:0]),
     .D_full_umbral_in			(D_full_umbral_in[1:0]),
     .MF_empty_umbral_in		(MF_empty_umbral_in[1:0]),
     .MF_full_umbral_in			(MF_full_umbral_in[1:0]),
     .VC_empty_umbral_in		(VC_empty_umbral_in[2:0]),
     .VC_full_umbral_in			(VC_full_umbral_in[2:0]),
     .clk				(clk),
     .data_in				(data_in[5:0]),
     .enable				(enable),
     .init				(init),
     .pop_D0				(pop_D0),
     .pop_D1				(pop_D1),
     .push_MF				(push_MF),
     .reset				(reset));
	

	

endmodule
