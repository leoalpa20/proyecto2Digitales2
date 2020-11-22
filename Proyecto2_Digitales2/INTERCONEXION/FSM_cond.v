
module FSM_cond#(
	parameter MF_SIZE = 3,
	parameter VC_SIZE = 3,
	parameter D_SIZE = 3		//Done.
)
(
	//Inputs.
	input clk,
	input init,
	input reset,
	
	//Umbrals.
	//empties.
	input[MF_SIZE-1:0] MF_empty_umbral_in,
	input[VC_SIZE-1:0] VC_empty_umbral_in,
	input[D_SIZE-1:0] D_empty_umbral_in,
	
	//fulls.
	input[MF_SIZE-1:0] MF_full_umbral_in,
	input[VC_SIZE-1:0] VC_full_umbral_in,
	input[D_SIZE-1:0] D_full_umbral_in,
	
	//Error signals.
	input MF_err_sig_in,
	input VC0_err_sig_in,
	input VC1_err_sig_in,
	input D0_err_sig_in,
	input D1_err_sig_in,
	
	//Empty signals.
	input MF_empty_sig_in,
	input VC0_empty_sig_in,
	input VC1_empty_sig_in,
	input D0_empty_sig_in,
	input D1_empty_sig_in,
	
	//Outputs.
	//Umbrals.
	output reg[MF_SIZE-1:0] MF_full_umbral_out_c,
	output reg[VC_SIZE-1:0] VC_full_umbral_out_c,
	output reg[D_SIZE-1:0] D_full_umbral_out_c,
	
	output reg[MF_SIZE-1:0] MF_empty_umbral_out_c,
	output reg[VC_SIZE-1:0] VC_empty_umbral_out_c,
	output reg[D_SIZE-1:0] D_empty_umbral_out_c,	
	
	//state signals.
	output reg error_out_c,
	output reg active_out_c,
	output reg idle_out_c,
	output reg reset_out						//Done.
);

//one-hot states.
parameter RESET = 'b00001;  //1
parameter INIT = 'b00010;   //2
parameter IDLE = 'b00100;   //4
parameter ACTIVE =  'b01000; //8
parameter ERROR = 'b10000;  //10

reg[4:0] state, nxt_state;						//Done.

//Umbrals output signals. 
always@(posedge clk)
begin
	if(~reset)
	begin
		state <= 1;
		//umbral outputs.
		MF_full_umbral_out_c <= 0;
		VC_full_umbral_out_c <= 0;
		D_full_umbral_out_c <= 0;
		
		MF_empty_umbral_out_c <= 0;
		VC_empty_umbral_out_c <= 0;
		D_empty_umbral_out_c <= 0;		
	end
	else
	begin
		state <= nxt_state;
	end
		if(state == INIT)
		begin
			//Empties.
			MF_empty_umbral_out_c <= MF_empty_umbral_in;
			VC_empty_umbral_out_c <= VC_empty_umbral_in;
			D_empty_umbral_out_c <= D_empty_umbral_in;
			
		
			//Fulls.
			MF_full_umbral_out_c <= MF_full_umbral_in;
			VC_full_umbral_out_c <= VC_full_umbral_in;
			D_full_umbral_out_c <= D_full_umbral_in;
		end
end						//Done.


//FSM outputs.
always@(*)
begin
	if(~reset)
	begin
		//state outputs.
		error_out_c = 0;
		active_out_c = 0;
		idle_out_c = 0;
		reset_out = 0;
	end
	else
	begin
		if(state == IDLE)
		begin
			error_out_c = 0;
			active_out_c = 0;
			idle_out_c = 1;
			reset_out = 1;
		end
		else if(state == ERROR)
		begin
			error_out_c = 1;
			active_out_c = 0;
			idle_out_c = 0;	
			reset_out = 1;
		end
		else if(state == ACTIVE)
		begin
			error_out_c = 0;
			active_out_c = 1;
			idle_out_c = 0;	
			reset_out = 1;
		end
		else
		begin
			error_out_c = 0;
			active_out_c = 0;
			idle_out_c = 0;	
			reset_out = 1;
		end
	end
end

//Next state combinational logic.
always@(*)
begin
	/*if(~reset)
	begin
		//state outputs.
		error_out_c = 0;
		active_out_c = 0;
		idle_out_c = 0;
		reset_out = 0;
	end
	else
	begin
		if(state == IDLE)
		begin
			error_out_c = 0;
			active_out_c = 0;
			idle_out_c = 1;
			reset_out = 1;
		end
		else if(state == ERROR)
		begin
			error_out_c = 1;
			active_out_c = 0;
			idle_out_c = 0;	
			reset_out = 1;
		end
		else if(state == ACTIVE)
		begin
			error_out_c = 0;
			active_out_c = 1;
			idle_out_c = 0;	
			reset_out = 1;
		end
		else
		begin
			error_out_c = 0;
			active_out_c = 0;
			idle_out_c = 0;	
			reset_out = 0;
		end
	end*/
	
	nxt_state = state;
	case (state)

		RESET:
		begin
			if(~reset)
			begin
				nxt_state = RESET;
			end
			else
			begin
				nxt_state = INIT;
			end
		end
		
		INIT:
		begin
			if(~reset)
			begin
				nxt_state = RESET;
			end
			else
			begin
				if(~init)
				begin
					nxt_state = IDLE;
				end
				else
				begin
					nxt_state = INIT;
				end
			end
		end
		
		IDLE:
		begin
			if(~reset)
			begin
				nxt_state = RESET;
			end
			else
			begin
				if(~init)
				begin
					if(MF_empty_sig_in & VC0_empty_sig_in & VC1_empty_sig_in & D0_empty_sig_in & D1_empty_sig_in)
					begin
						nxt_state = IDLE;
					end
					else
					begin
						nxt_state = ACTIVE;
					end
				end
				else
				begin
					nxt_state = INIT;
				end
			end
		end
		
		ACTIVE:
		begin
			if(~reset)
			begin
				nxt_state = RESET;
			end
			else
			begin
				if(~init)
				begin
					if(MF_empty_sig_in & VC0_empty_sig_in & VC1_empty_sig_in & D0_empty_sig_in & D1_empty_sig_in)
					begin
						nxt_state = IDLE;
					end	
					if(MF_err_sig_in | VC0_err_sig_in | VC1_err_sig_in | D0_err_sig_in | D1_err_sig_in)
					begin
						nxt_state = ERROR;
					end
					else
					begin
						nxt_state = ACTIVE;
					end
				end
				else
				begin
					nxt_state = INIT;
				end
			end 
		end
		
		ERROR:
		begin
			if(~reset)
			begin
				nxt_state = RESET;
			end
			else
			begin
				if(MF_err_sig_in | VC0_err_sig_in | VC1_err_sig_in | D0_err_sig_in | D1_err_sig_in)
				begin
					nxt_state = ERROR;
				end
				else
				begin
					if(~init)
					begin
						if(MF_empty_sig_in & VC0_empty_sig_in & VC1_empty_sig_in & D0_empty_sig_in & D1_empty_sig_in)
						begin
							nxt_state = IDLE;
						end	
						else
						begin
							nxt_state = ACTIVE;
						end
					end
					else
					begin
						nxt_state = INIT;
					end
				end
			end
		end
	endcase
end
endmodule

