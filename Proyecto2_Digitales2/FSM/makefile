COMP = iverilog
RUN = vvp
WAVE = gtkwave
SYNTH = yosys
SCRIPT = yos.ys
RENAME = sed
COND = FSM_cond
ESTR = FSM_synth
TEST = test
TEST_BENCH = testBench
SIGNALS = generator.vcd
TARGET_ONE = test_0.gtkw

#gtk: autoinst
#	$(WAVE) $(SIGNALS)

#autoinst: vvp
#	emacs --batch $(TEST_BENCH).v -f verilog-batch-auto
	
#vvp: comp
#	$(RUN) $(COND)
#	$(RUN) $(TEST)
#	$(RUN) $(TEST_BENCH)
#comp:
#	$(COMP) -o $(COND) $(COND).v
#	$(COMP)	-o $(TEST) $(TEST).v
#	$(COMP) -o $(TEST_BENCH) $(TEST_BENCH).v

synth:
	$(SYNTH) $(SCRIPT)
	
sed:
	$(RENAME) -i 's/FSM_cond/FSM_synth/' $(ESTR).v
	
	$(RENAME) -i 's/MF_full_umbral_out_c/MF_full_umbral_out_e/' $(ESTR).v
	$(RENAME) -i 's/VC_full_umbral_out_c/VC_full_umbral_out_e/' $(ESTR).v
	$(RENAME) -i 's/D_full_umbral_out_c/D_full_umbral_out_e/' $(ESTR).v
	
	$(RENAME) -i 's/MF_empty_umbral_out_c/MF_empty_umbral_out_e/' $(ESTR).v
	$(RENAME) -i 's/VC_empty_umbral_out_c/VC_empty_umbral_out_e/' $(ESTR).v
	$(RENAME) -i 's/D_empty_umbral_out_c/D_empty_umbral_out_e/' $(ESTR).v
		
	$(RENAME) -i 's/error_out_c/error_out_e/' $(ESTR).v
	$(RENAME) -i 's/active_out_c/active_out_e/' $(ESTR).v
	$(RENAME) -i 's/idle_out_c/idle_out_e/' $(ESTR).v	

all:
	$(COMP) -o $(COND) $(COND).v
	$(COMP)	-o $(TEST) $(TEST).v
	$(COMP) -o $(TEST_BENCH) $(TEST_BENCH).v
	
	$(RUN) $(COND)
	$(RUN) $(TEST)
	$(RUN) $(TEST_BENCH)
	
	emacs --batch $(TEST_BENCH).v -f verilog-batch-auto
	
	$(WAVE) $(SIGNALS) $(TARGET_ONE) #test_0
	
	
