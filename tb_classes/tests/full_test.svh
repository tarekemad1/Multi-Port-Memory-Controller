class full_test extends base_test;
    `uvm_component_utils(full_test);
    IdlSequence IdlSeq_h;
    Cpu1WriteSeq Cpu1WriteSeq_h; 
    Cpu1ReadSeq Cpu1ReadSeq_h ;
    Cpu2WriteSeq Cpu2WriteSeq_h ; 
    Cpu2ReadSeq Cpu2ReadSeq_h ; 
    Cpu1Cpu2ReadSeq Cpu1Cpu2ReadSeq_h ;
    function new(string name ="full_test",uvm_component parent);
        super.new(name,parent);
        IdlSeq_h=IdlSequence::type_id::create("IdlSeq_h");
        Cpu1WriteSeq_h=Cpu1WriteSeq::type_id::create("Cpu1WriteSeq_h");
        Cpu1ReadSeq_h=Cpu1ReadSeq::type_id::create("Cpu1ReadSeq_h");
        Cpu2WriteSeq_h=Cpu2WriteSeq::type_id::create("Cpu2WriteSeq_h");
        Cpu2ReadSeq_h=Cpu2ReadSeq::type_id::create("Cpu2ReadSeq_h");
        Cpu1Cpu2ReadSeq_h=Cpu1Cpu2ReadSeq::type_id::create("Cpu1Cpu2ReadSeq_h");
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        //#10;
        //IdlSeq_h.start(sequencer_h);
        #5
        Cpu1WriteSeq_h.start(sequencer_h);
        #40; 
        Cpu1ReadSeq_h.start(sequencer_h);
        #40;
        Cpu2WriteSeq_h.start(sequencer_h);
        #40;
        Cpu2ReadSeq_h.start(sequencer_h);
        #40;
        Cpu1Cpu2ReadSeq_h.start(sequencer_h);
        #40;
        phase.drop_objection(this);
    endtask
    
endclass