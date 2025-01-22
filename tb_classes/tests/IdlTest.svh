class IdlTest extends base_test;
    `uvm_component_utils(IdlTest);
    IdlSequence IdlSeq_h; 
    function new(string name ="IdlTest",uvm_component  parent);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        IdlSeq_h=IdlSequence::type_id::create("IdlSeq_h");
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        IdlSeq_h.start(sequencer_h);
        phase.drop_objection(this);
    endtask
endclass