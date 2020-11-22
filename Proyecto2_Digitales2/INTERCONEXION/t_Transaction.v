// Probador para el modulo
module t_Transaction 
#(	
	parameter DATA_W = 6,
	parameter MF_SIZE = 2,
	parameter VC_SIZE = 3,
	parameter D_SIZE = 2
)
(		
	//Inputs
	input  [DATA_W-1: 0] data_out_0_c,
	input  [DATA_W-1: 0] data_out_1_c,
	input error_out_c,
	input active_out_c,
	input idle_out_c,
	input almost_full_MF_c,
	input almost_D0_empty_sig_in, 
	input almost_D1_empty_sig_in,

	input  [DATA_W-1: 0] data_out_0_es,
	input  [DATA_W-1: 0] data_out_1_es,
	input error_out_es,
	input active_out_es,
	input idle_out_es,
	input almost_full_MF_es,
	input almost_D0_empty_sig_in_es, 
	input almost_D1_empty_sig_in_es,
	//Outputs 
	output reg clk,                 
	output reg reset,
	output reg init,
	// Almost Full threshold in
	output reg [MF_SIZE-1:0] MF_full_umbral_in,
	output reg [VC_SIZE-1:0] VC_full_umbral_in,
	output reg [D_SIZE-1:0] D_full_umbral_in,
	// Almost Empty threshold in
	output reg [MF_SIZE-1:0] MF_empty_umbral_in,
	output reg [VC_SIZE-1:0] VC_empty_umbral_in,
	output reg [D_SIZE-1:0] D_empty_umbral_in,
	output reg enable,                     
	//output reg push,
	output reg push_MF,
	output reg pop_D0, 
	output reg pop_D1,
	output reg [DATA_W-1: 0] data_in   
);


	initial #31 clk <= 0;	
	always
	#10 clk <= ~clk;
	integer idx,idy,unit=0;
	
	initial 
	begin
		$dumpfile("Transaction.vcd");
	  	$dumpvars;
          	$display ("Transaction test");
		#50;
		
		/*----------------------------------------TEST_0-----------------------------------------------*/
		reset = 0;
		data_in = 0;
		init = 0;
		
		//UMBRALES
		MF_full_umbral_in = 0;
		VC_full_umbral_in = 0;
		D_full_umbral_in = 0;

		MF_empty_umbral_in = 0;
		VC_empty_umbral_in = 0;
		D_empty_umbral_in = 0;

		pop_D0<=0;
		pop_D1 <=0;
		push_MF<=0;
		

		@(posedge clk);
		/*------------------------TEST 2-----------------------------*/
		/*vc_id = 0;
		vc_id = 1;*/
		/*------------------------END--------------------------------*/
		@(posedge clk);
		enable = 1;
		/*------------------------TEST 1-----------------------------*/
		/* DATA_W = 6; MF_SIZE = 2; VC_SIZE = 3; D_SIZE = 2 */
		MF_full_umbral_in = 2;
		VC_full_umbral_in = 5;
		D_full_umbral_in = 2;

		MF_empty_umbral_in = 1;
		VC_empty_umbral_in = 2;
		D_empty_umbral_in = 1;
		/*------------------------END--------------------------------*/
	
		/*------------------------TEST 4-----------------------------*/	
		/* DATA_W = 6; MF_SIZE = 2; VC_SIZE = 3; D_SIZE = 2 */	
		/*MF_full_umbral_in <=3;
		VC_full_umbral_in <=4;
		D_full_umbral_in <=2;

		MF_empty_umbral_in <=2;
		VC_empty_umbral_in <=3;
		D_empty_umbral_in <=1;*/
		/*------------------------END--------------------------------*/
		
		init = 1;
        	reset = 1;
		pop_D0 = 0;
		pop_D1 = 0;
		push_MF= 0;
	
		@(posedge clk);
		init = 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		for (idx = 0; idx < 500; idx = idx + 1) 
		begin
			
			if (idx%2==0) 
			begin
				data_in=$urandom%63;
			end
			
			if (idx==8) 
			begin
				idy=1;
			end
			
			/*if (idx%2==0) 
			begin
				data_in[DATA_W-3:0]=$urandom%15;
				data_in[DATA_W-2] = 1;
				data_in[DATA_W-1] = 1;
			end*/
			
			@(posedge clk);
			if (almost_full_MF_c==0 & idx%2==0) 
			begin
				push_MF <=1;
			end 
			else 
			begin
				push_MF <=0;
			end
			/*if (!almost_empty_D0_e & almost_empty_D1_e & idy) 
			begin
				pop_D1 <=0;
				pop_D0 <=1;
			
			end else if (!almost_empty_D1_e & almost_empty_D0_e & idy) 
			begin
				pop_D1 <=1;
				pop_D0 <=0;
				
			end else if (!almost_empty_D0_e & !almost_empty_D1_e & idy) 
			begin
				pop_D1 <=1;
				pop_D0 <=1;
				
			end else begin
				pop_D1 <=0;
				pop_D0 <=0;
			end*/
		end
		/*------------------------TEST 3-----------------------------*/
		/* Si MF está casi lleno, entonces se puede mantener el push activo
		un intervalo de tiempo extra para forzar el desbordamiento del 
		FIFO y generar el error.*/
		/*if(almost_full_MF_c==1)
		begin
			@(posedge clk)
			push_MF = 1;
			@(posedge clk)
			push_MF = 1;
			@(posedge clk)
			push_MF = 1;
			@(posedge clk)
			push_MF = 1;
		end*/
		/*------------------------END--------------------------------*/		

		repeat(20)
		begin
			@(posedge clk);
			if (almost_full_MF_c==0) 
			begin
				push_MF	<=1;
			end 
			else 
			begin
				push_MF	<=0;
			end
			if (!almost_D0_empty_sig_in) 
			begin
				pop_D0 <=1;	
			end 
			else 
			begin
				pop_D0<=0;
			end
			if (!almost_D1_empty_sig_in) 
			begin
				pop_D1 <=1;	
			end 
			else 
			begin
				pop_D1 <=0;
			end
		end
		//#564
		//enable = 0;
		$finish;
	end
endmodule		



//init = 0
//vc_id bit mas significativo
