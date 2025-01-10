class Cpu1Test extends base_test;
    `uvm_component_utils(Cpu1Test);
    Cpu1WriteSeq Cpu1WriteSeq_h; 
    Cpu1ReadSeq  Cpu1ReadSeq_h ; 
    function new(string name="Cpu1Test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        Cpu1WriteSeq_h=Cpu1WriteSeq::type_id::create("Cpu1WriteSeq_h");
        Cpu1ReadSeq_h =Cpu1ReadSeq::type_id::create("Cpu1ReadSeq_h");
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        Cpu1WriteSeq_h.start(sequencer_h);
        #40;
        Cpu1ReadSeq_h.start(sequencer_h);
        phase.drop_objection(this);
    endtask

endclass