class Cpu1Cpu2ReadSeq extends base_sequence;
    `uvm_object_utils(Cpu1Cpu2ReadSeq);
    function new(string name ="Cpu1Cpu2ReadSeq");
        super.new(name);
    endfunction
    task body();
        item=sequence_item::type_id::create("item");
        Randomization: assert (item.randomize() with {req_1==ACTIVE;req_2==ACTIVE;rw_2==DEACTIVE;})
            else `uvm_fatal("CPU2_Write_SEQ","Assertion Randomization failed!");
    endtask
endclass