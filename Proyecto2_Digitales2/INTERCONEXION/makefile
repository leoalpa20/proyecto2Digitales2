objetivo1: dependencia1 dependencia2
	gtkwave Transaction.vcd test_0.gtkw
	
dependencia1:

	yosys -s script.ys
	
	#FSM.
	sed -i 's/MF_empty_umbral_out_c/MF_empty_umbral_out_es/g' Transaction_STRUC.v
	sed -i 's/D_empty_umbral_out_c/D_empty_umbral_out_es/g' Transaction_STRUC.v
	sed -i 's/VC_empty_umbral_out_c/VC_empty_umbral_out_es/g' Transaction_STRUC.v
	sed -i 's/MF_full_umbral_out_c/MF_full_umbral_out_es/g' Transaction_STRUC.v
	sed -i 's/D_full_umbral_out_c/D_full_umbral_out_es/g' Transaction_STRUC.v
	sed -i 's/VC_full_umbral_out_c/VC_full_umbral_out_es/g' Transaction_STRUC.v
	sed -i 's/idle_out_c/idle_out_es/g' Transaction_STRUC.v
	sed -i 's/active_out_c/active_out_es/g' Transaction_STRUC.v
	sed -i 's/error_out_c/error_out_es/g' Transaction_STRUC.v
	
	#FIFO.
	sed -i 's/data_out_c/data_out_es/g' Transaction_STRUC.v
	sed -i 's/error_c/error_es/g' Transaction_STRUC.v
	sed -i 's/almost_empty_c/almost_empty_es/g' Transaction_STRUC.v
	sed -i 's/almost_full_c/almost_full_es/g' Transaction_STRUC.v
	sed -i 's/empty_c/empty_es/g' Transaction_STRUC.v
	
	
	#Transaction.
	sed -i 's/Transaction_COND/Transaction_STRUC/g' Transaction_STRUC.v
	sed -i 's/data_out_0_c/data_out_0_es/g' Transaction_STRUC.v
	sed -i 's/data_out_1_c/data_out_1_es/g' Transaction_STRUC.v
	sed -i 's/error_out_c/error_out_es/g' Transaction_STRUC.v
	sed -i 's/active_out_c/active_out_es/g' Transaction_STRUC.v
	sed -i 's/idle_out_c/idle_out_es/g' Transaction_STRUC.v
	sed -i 's/almost_full_MF_c/almost_full_MF_es/g' Transaction_STRUC.v
	sed -i 's/almost_D0_empty_sig_in/almost_D0_empty_sig_in_es/g' Transaction_STRUC.v
	sed -i 's/almost_D1_empty_sig_in/almost_D1_empty_sig_in_es/g' Transaction_STRUC.v


	emacs --batch tb_Transaction.v -f verilog-batch-auto
	
dependencia2:
	iverilog -o resultado tb_Transaction.v
	vvp resultado
	
