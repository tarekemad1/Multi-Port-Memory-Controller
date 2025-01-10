class Cpu1Cpu2Test extends base_test;
    `uvm_component_utils(Cpu1Cpu2Test);
    Cpu1ReadSeq Cpu1ReadSeq_h;
    Cpu2ReadSeq Cpu2ReadSeq_h;
    function new(string name = "Cpu1Cpu2Test",uvm_component parent);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        Cpu1ReadSeq_h=Cpu1ReadSeq::type_id::create("Cpu1ReadSeq_h");
        Cpu2ReadSeq_h=Cpu2ReadSeq::type_id::create("Cpu2ReadSeq_h");
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
            fork
                Cpu1ReadSeq_h.start(sequencer_h);
                Cpu2ReadSeq_h.start(sequencer_h);
            join
        phase.drop_objection(this);
    endtask
endclass