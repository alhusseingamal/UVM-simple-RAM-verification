vlog package.sv top.sv interface.sv memory.sv +cover
vsim top -coverage +UVM_TESTNAME=mem_test
add wave -position insertpoint sim:/top/mem_intf/*
run -all; coverage report -codeall -cvg -verbose -output coverage_report.txt