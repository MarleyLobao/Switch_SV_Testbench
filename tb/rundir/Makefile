PATHS = +incdir+../../rtl/ \
				+incdir+../src/

IFS = ../src/switch_if.sv

PKGS = ../src/switch_pkg.sv

TOP = ../src/top.sv

RTL = ../../rtl/switch.sv

RUN_ARGS_COMMON = -access +r -input ../scripts/shm.tcl

sim:
		xrun -64bit $(PATHS) $(IFS) $(PKGS) $(RTL) $(TOP) $(RUN_ARGS_COMMON)

clean:
		@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .bpad/ .simvision/ simvision* xcelium.d .reinvoke.sim simv.daidir *.so *.o *.err *.vcd

gui:
		xrun -64bit $(PATHS) $(IFS) $(PKGS) $(RTL) $(TOP) $(RUN_ARGS_COMMON) -gui