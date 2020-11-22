module test#(
	parameter MF_SIZE = 3,
	parameter VC_SIZE = 3,
	parameter D_SIZE = 3
)
(
	//Outputs.
	output reg clk,
	output reg init,
	output reg reset,
	
	//Umbrals.
	//empties.
	output reg[MF_SIZE-1:0] MF_empty_umbral_in,
	output reg[VC_SIZE-1:0] VC_empty_umbral_in,
	output reg[D_SIZE-1:0] D_empty_umbral_in,
	
	//fulls.
	output reg[MF_SIZE-1:0] MF_full_umbral_in,
	output reg[VC_SIZE-1:0] VC_full_umbral_in,
	output reg[D_SIZE-1:0] D_full_umbral_in,
	
	//Error signals.
	output reg MF_err_sig_in,
	output reg VC0_err_sig_in,
	output reg VC1_err_sig_in,
	output reg D0_err_sig_in,
	output reg D1_err_sig_in,
	
	//Empty signals.
	output reg MF_empty_sig_in,
	output reg VC0_empty_sig_in,
	output reg VC1_empty_sig_in,
	output reg D0_empty_sig_in,
	output reg D1_empty_sig_in,
	
	//Inputs.
	//Umbrals.
	input[MF_SIZE-1:0] MF_full_umbral_out_c,
	input[VC_SIZE-1:0] VC_full_umbral_out_c,
	input[D_SIZE-1:0] D_full_umbral_out_c,
	
	input[MF_SIZE-1:0] MF_empty_umbral_out_c,
	input[VC_SIZE-1:0] VC_empty_umbral_out_c,
	input[D_SIZE-1:0] D_empty_umbral_out_c,	
	
	//state signals.
	input error_out_c,
	input active_out_c,
	input idle_out_c,
	
	//Synth.
	//Umbrals.
	input[MF_SIZE-1:0] MF_full_umbral_out_e,
	input[VC_SIZE-1:0] VC_full_umbral_out_e,
	input[D_SIZE-1:0] D_full_umbral_out_e,
	
	input[MF_SIZE-1:0] MF_empty_umbral_out_e,
	input[VC_SIZE-1:0] VC_empty_umbral_out_e,
	input[D_SIZE-1:0] D_empty_umbral_out_e,	
	
	//state signals.
	input error_out_e,
	input active_out_e,
	input idle_out_e,
	
	input reset_out
);

initial
begin
	$dumpfile("generator.vcd");
	$dumpvars;

	//FSM outputs test.
	//Umbrals values.
	@(posedge clk);
	MF_empty_umbral_in='b0;
	VC_empty_umbral_in='b0;
	D_empty_umbral_in='b0;
	MF_full_umbral_in='b0;
	VC_full_umbral_in='b0;
	D_full_umbral_in='b0;
	/*@(posedge clk);
	MF_empty_umbral_in='b0;
	VC_empty_umbral_in='b0;
	D_empty_umbral_in='b0;
	MF_full_umbral_in='b0;
	VC_full_umbral_in='b0;
	D_full_umbral_in='b0;	*/
	@(posedge clk);
	MF_empty_umbral_in=3'b111;
	VC_empty_umbral_in=3'b010;
	D_empty_umbral_in=3'b001;
	MF_full_umbral_in=3'b010;
	VC_full_umbral_in=3'b101;
	D_full_umbral_in=3'b010;
/*	@(posedge clk);
	MF_empty_umbral_in=3'b011;
	VC_empty_umbral_in=3'b111;
	D_empty_umbral_in=3'b011;
	MF_full_umbral_in=3'b011;
	VC_full_umbral_in=3'b110;
	D_full_umbral_in=3'b110;*/
	/*@(posedge clk);
	MF_empty_umbral_in=3'b101;
	VC_empty_umbral_in=3'b110;
	D_empty_umbral_in=3'b001;
	MF_full_umbral_in=3'b010;
	VC_full_umbral_in=3'b011;
	D_full_umbral_in=3'b101;*/
	
	/*@(posedge clk);
	MF_empty_umbral_in=3'b001;
	VC_empty_umbral_in=3'b110;
	D_empty_umbral_in=3'b011;
	MF_full_umbral_in=3'b010;
	VC_full_umbral_in=3'b110;
	D_full_umbral_in=3'b111;*/
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	/*MF_empty_umbral_in=3'b001;
	VC_empty_umbral_in=3'b010;
	D_empty_umbral_in=3'b101;
	MF_full_umbral_in=3'b100;
	VC_full_umbral_in=3'b011;
	D_full_umbral_in=3'b001;*/
	
	MF_empty_sig_in='b1;
	VC0_empty_sig_in='b1;
	VC1_empty_sig_in='b1;
	D0_empty_sig_in='b1;
	D1_empty_sig_in='b1;
/*	@(posedge clk);
	MF_empty_umbral_in=3'b111;
	VC_empty_umbral_in=3'b110;
	D_empty_umbral_in=3'b001;
	MF_full_umbral_in=3'b010;
	VC_full_umbral_in=3'b011;
	D_full_umbral_in=3'b101;*/
	/*@(posedge clk);
	MF_empty_umbral_in=3'b001;
	VC_empty_umbral_in=3'b110;
	D_empty_umbral_in=3'b011;
	MF_full_umbral_in=3'b010;
	VC_full_umbral_in=3'b110;
	D_full_umbral_in=3'b111;*/
	/*@(posedge clk);
	MF_empty_umbral_in=3'b111;
	VC_empty_umbral_in=3'b010;
	D_empty_umbral_in=3'b001;
	MF_full_umbral_in=3'b010;
	VC_full_umbral_in=3'b101;
	D_full_umbral_in=3'b010;*/
	
	/*@(posedge clk);
	MF_empty_sig_in='b1;
	VC0_empty_sig_in='b1;
	VC1_empty_sig_in='b1;
	D0_empty_sig_in='b1;
	D1_empty_sig_in='b1;*/
	@(posedge clk);
	@(posedge clk);
	/*MF_empty_sig_in='b0;
	VC0_empty_sig_in='b0;
	VC1_empty_sig_in='b0;
	D0_empty_sig_in='b0;
	D1_empty_sig_in='b0;*/
	
	MF_err_sig_in='b1;
	
	#550
	D_full_umbral_in=3'b1;
	$finish;
end

//Control signals.
//Clock.
initial clk <= 0;
always	#1 clk <= ~clk;

//Reset.
initial
begin
	@(posedge clk);
	reset = 1'b0;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b1;
	@(posedge clk);
	reset = 1'b0;
end

//init.
initial
begin
	@(posedge clk);
	init = 1'b0;
	@(posedge clk);
	init = 1'b1;
	@(posedge clk);
	init = 1'b1;
	@(posedge clk);
	init = 1'b1;
	@(posedge clk);
	init = 1'b0;
end
endmodule
