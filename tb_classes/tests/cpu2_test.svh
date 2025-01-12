class Cpu2Test extends base_test;
    `uvm_component_utils(Cpu2Test);
    Cpu2WriteSeq Cpu2WriteSeq_h ; 
    Cpu2ReadSeq Cpu2ReadSeq_h; 

    function new(string name = "Cpu2Test",uvm_component parent);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        Cpu2WriteSeq_h=Cpu2WriteSeq::type_id::create("Cpu2WriteSeq_h");
        Cpu2ReadSeq_h=Cpu2ReadSeq::type_id::create("Cpu2ReadSeq_h");        
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        Cpu2WriteSeq_h.start(sequencer_h);
            #40;
        Cpu2ReadSeq_h.start(sequencer_h);
        phase.drop_objection(this);
    endtask
endclass