objetivo1: dependencia1 dependencia2
	gtkwave Ram.vcd
	
dependencia1:

	yosys -s script.ys
        
	sed -i 's/Ram/Ram_Estruc/g' Ram_Estruc.v
	sed -i 's/data_out_c/data_out_c_Estruc/g' Ram_Estruc.v

	emacs --batch Banco_de_Pruebas.v -f verilog-batch-auto
	
dependencia2:
	iverilog -o resultado Banco_de_Pruebas.v
	vvp resultado
	
