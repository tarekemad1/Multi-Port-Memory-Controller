class Cpu1Cpu2Test extends base_test;
    `uvm_component_utils(Cpu1Cpu2Test);
    Cpu1Cpu2ReadSeq Cpu1Cpu2ReadSeq_h; 
    function new(string name = "Cpu1Cpu2Test",uvm_component parent);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        Cpu1Cpu2ReadSeq_h=Cpu1Cpu2ReadSeq::type_id::create("Cpu1Cpu2ReadSeq_h");
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
            Cpu1Cpu2ReadSeq_h.start(sequencer_h);
        phase.drop_objection(this);
    endtask
endclass