`timescale 1ns/100ps

`include "FSM_cond.v"
`include "FSM_synth.v"
`include "cmos_cells.v"
`include "test.v"

//Test-bench.
module testBench
#( 
	//Parameters.
	parameter MF_SIZE = 3,
	parameter VC_SIZE = 3,
	parameter D_SIZE = 3
);

//Cables internos.
wire clk, init, reset, MF_err_sig_in, VC0_err_sig_in, VC1_err_sig_in, D0_err_sig_in, D1_err_sig_in, MF_empty_sig_in, VC0_empty_sig_in, VC1_empty_sig_in, D0_empty_sig_in, D1_empty_sig_in, error_out_c, error_out_e, active_out_c, active_out_e, idle_out_c, idle_out_e, reset_out;
wire[MF_SIZE-1:0] MF_empty_umbral_in, MF_full_umbral_in, MF_full_umbral_out_c, MF_full_umbral_out_e, MF_empty_umbral_out_c, MF_empty_umbral_out_e;
wire[VC_SIZE-1:0] VC_empty_umbral_in, VC_full_umbral_in, VC_full_umbral_out_c, VC_full_umbral_out_e, VC_empty_umbral_out_c, VC_empty_umbral_out_e;
wire[D_SIZE-1:0] D_empty_umbral_in, D_full_umbral_in, D_full_umbral_out_c, D_full_umbral_out_e, D_empty_umbral_out_c, D_empty_umbral_out_e;

//Instanciación del módulo conductual.
FSM_cond COND
(
	/*AUTOINST*/
 // Outputs
 .MF_full_umbral_out_c			(MF_full_umbral_out_c[MF_SIZE-1:0]),
 .VC_full_umbral_out_c			(VC_full_umbral_out_c[VC_SIZE-1:0]),
 .D_full_umbral_out_c			(D_full_umbral_out_c[D_SIZE-1:0]),
 .MF_empty_umbral_out_c			(MF_empty_umbral_out_c[MF_SIZE-1:0]),
 .VC_empty_umbral_out_c			(VC_empty_umbral_out_c[VC_SIZE-1:0]),
 .D_empty_umbral_out_c			(D_empty_umbral_out_c[D_SIZE-1:0]),
 .error_out_c				(error_out_c),
 .active_out_c				(active_out_c),
 .idle_out_c				(idle_out_c),
 .reset_out				(reset_out),
 // Inputs
 .clk					(clk),
 .init					(init),
 .reset					(reset),
 .MF_empty_umbral_in			(MF_empty_umbral_in[MF_SIZE-1:0]),
 .VC_empty_umbral_in			(VC_empty_umbral_in[VC_SIZE-1:0]),
 .D_empty_umbral_in			(D_empty_umbral_in[D_SIZE-1:0]),
 .MF_full_umbral_in			(MF_full_umbral_in[MF_SIZE-1:0]),
 .VC_full_umbral_in			(VC_full_umbral_in[VC_SIZE-1:0]),
 .D_full_umbral_in			(D_full_umbral_in[D_SIZE-1:0]),
 .MF_err_sig_in				(MF_err_sig_in),
 .VC0_err_sig_in			(VC0_err_sig_in),
 .VC1_err_sig_in			(VC1_err_sig_in),
 .D0_err_sig_in				(D0_err_sig_in),
 .D1_err_sig_in				(D1_err_sig_in),
 .MF_empty_sig_in			(MF_empty_sig_in),
 .VC0_empty_sig_in			(VC0_empty_sig_in),
 .VC1_empty_sig_in			(VC1_empty_sig_in),
 .D0_empty_sig_in			(D0_empty_sig_in),
 .D1_empty_sig_in			(D1_empty_sig_in));

//Instanciación del módulo estructural.
FSM_synth SYNTH
(
	/*AUTOINST*/
 // Outputs
 .D_empty_umbral_out_e			(D_empty_umbral_out_e[2:0]),
 .D_full_umbral_out_e			(D_full_umbral_out_e[2:0]),
 .MF_empty_umbral_out_e			(MF_empty_umbral_out_e[2:0]),
 .MF_full_umbral_out_e			(MF_full_umbral_out_e[2:0]),
 .VC_empty_umbral_out_e			(VC_empty_umbral_out_e[2:0]),
 .VC_full_umbral_out_e			(VC_full_umbral_out_e[2:0]),
 .active_out_e				(active_out_e),
 .error_out_e				(error_out_e),
 .idle_out_e				(idle_out_e),
 .reset_out				(reset_out),
 // Inputs
 .D0_empty_sig_in			(D0_empty_sig_in),
 .D0_err_sig_in				(D0_err_sig_in),
 .D1_empty_sig_in			(D1_empty_sig_in),
 .D1_err_sig_in				(D1_err_sig_in),
 .D_empty_umbral_in			(D_empty_umbral_in[2:0]),
 .D_full_umbral_in			(D_full_umbral_in[2:0]),
 .MF_empty_sig_in			(MF_empty_sig_in),
 .MF_empty_umbral_in			(MF_empty_umbral_in[2:0]),
 .MF_err_sig_in				(MF_err_sig_in),
 .MF_full_umbral_in			(MF_full_umbral_in[2:0]),
 .VC0_empty_sig_in			(VC0_empty_sig_in),
 .VC0_err_sig_in			(VC0_err_sig_in),
 .VC1_empty_sig_in			(VC1_empty_sig_in),
 .VC1_err_sig_in			(VC1_err_sig_in),
 .VC_empty_umbral_in			(VC_empty_umbral_in[2:0]),
 .VC_full_umbral_in			(VC_full_umbral_in[2:0]),
 .clk					(clk),
 .init					(init),
 .reset					(reset));

//Instanciación del probador.
test TEST_
(
	/*AUTOINST*/
 // Outputs
 .clk					(clk),
 .init					(init),
 .reset					(reset),
 .MF_empty_umbral_in			(MF_empty_umbral_in[MF_SIZE-1:0]),
 .VC_empty_umbral_in			(VC_empty_umbral_in[VC_SIZE-1:0]),
 .D_empty_umbral_in			(D_empty_umbral_in[D_SIZE-1:0]),
 .MF_full_umbral_in			(MF_full_umbral_in[MF_SIZE-1:0]),
 .VC_full_umbral_in			(VC_full_umbral_in[VC_SIZE-1:0]),
 .D_full_umbral_in			(D_full_umbral_in[D_SIZE-1:0]),
 .MF_err_sig_in				(MF_err_sig_in),
 .VC0_err_sig_in			(VC0_err_sig_in),
 .VC1_err_sig_in			(VC1_err_sig_in),
 .D0_err_sig_in				(D0_err_sig_in),
 .D1_err_sig_in				(D1_err_sig_in),
 .MF_empty_sig_in			(MF_empty_sig_in),
 .VC0_empty_sig_in			(VC0_empty_sig_in),
 .VC1_empty_sig_in			(VC1_empty_sig_in),
 .D0_empty_sig_in			(D0_empty_sig_in),
 .D1_empty_sig_in			(D1_empty_sig_in),
 // Inputs
 .MF_full_umbral_out_c			(MF_full_umbral_out_c[MF_SIZE-1:0]),
 .VC_full_umbral_out_c			(VC_full_umbral_out_c[VC_SIZE-1:0]),
 .D_full_umbral_out_c			(D_full_umbral_out_c[D_SIZE-1:0]),
 .MF_empty_umbral_out_c			(MF_empty_umbral_out_c[MF_SIZE-1:0]),
 .VC_empty_umbral_out_c			(VC_empty_umbral_out_c[VC_SIZE-1:0]),
 .D_empty_umbral_out_c			(D_empty_umbral_out_c[D_SIZE-1:0]),
 .error_out_c				(error_out_c),
 .active_out_c				(active_out_c),
 .idle_out_c				(idle_out_c),
 .MF_full_umbral_out_e			(MF_full_umbral_out_e[MF_SIZE-1:0]),
 .VC_full_umbral_out_e			(VC_full_umbral_out_e[VC_SIZE-1:0]),
 .D_full_umbral_out_e			(D_full_umbral_out_e[D_SIZE-1:0]),
 .MF_empty_umbral_out_e			(MF_empty_umbral_out_e[MF_SIZE-1:0]),
 .VC_empty_umbral_out_e			(VC_empty_umbral_out_e[VC_SIZE-1:0]),
 .D_empty_umbral_out_e			(D_empty_umbral_out_e[D_SIZE-1:0]),
 .error_out_e				(error_out_e),
 .active_out_e				(active_out_e),
 .idle_out_e				(idle_out_e),
 .reset_out				(reset_out));
endmodule
