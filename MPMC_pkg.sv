package MPMC_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "sequence_item.svh"
    `include "base_sequence.svh"
    `include "Cpu1WriteSequence.svh"    
    `include "Cpu1ReadSequence.svh"
    `include "Cpu2WriteSequence.svh"    
    `include "Cpu2ReadSequence.svh"
    `include "sequencer.svh"
    `include "driver.svh"    
    `include "monitor.svh"   
    `include "agent.svh"   
    `include "scoreboard.svh"   
    `include "coverage.svh"     
    `include "env.svh"   
    `include "base_test.svh"
    `include "cpu1_test.svh" 
    `include "cpu2_test.svh"
    `include "cpu1_cpu2_test.svh"
endpackage :MPMC_pkg