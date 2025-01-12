# Clean Work Library
if [file exists "work"] {vdel -all}
vlib work

# Compile Design Files
vlog -f rtl.f
vlog -f tb.f

# Compile the UVM Package

# TEST 1
vopt top  -o top_optimized +acc +cover=sbfec+MultiPortMemoryController
vsim top_optimized -coverage "+UVM_TESTNAME=full_test" 
set NoQuitOnFinish 1
onbreak {resume}

# Enable Logging
log /* -r
run -all

coverage save "logs/full_test.ucdb"
vcover report "logs/full_test.ucdb"  -details > "logs/coverage_report.txt"

quit
