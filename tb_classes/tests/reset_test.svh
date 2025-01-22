class ResetTest extends base_test;
    `uvm_component_utils(ResetTest);
    ResetSequence RstSeq_h; 
    function new(string name = "ResetTest",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        RstSeq_h=ResetSequence::type_id::create("RstSeq_h");
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        RstSeq_h.start(sequencer_h);
        `uvm_info("Reset_TEST","RST",UVM_LOW);
        phase.drop_objection(this);
    endtask

endclass