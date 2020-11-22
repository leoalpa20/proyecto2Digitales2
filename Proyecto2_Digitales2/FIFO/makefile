objetivo1: dependencia1 dependencia2
	gtkwave FIFO.vcd
	
dependencia1:

	yosys -s script.ys
	
	sed -i 's/fifo_cond/fifo_estruc/g' fifo_estruc.v
	sed -i 's/data_out_c/data_out_c_estruc/g' fifo_estruc.v
	sed -i 's/error_c/error_c_estruc/g' fifo_estruc.v
	sed -i 's/almost_full_c/almost_full_c_estruc/g' fifo_estruc.v
	
	sed -i 's/empty_c/empty_c_estruc/g' fifo_estruc.v
	sed -i 's/full_out_c/full_out_c_estruc/g' fifo_estruc.v

	emacs --batch Banco_de_Pruebas.v -f verilog-batch-auto
	
dependencia2:
	iverilog -o resultado Banco_de_Pruebas.v
	vvp resultado
	
