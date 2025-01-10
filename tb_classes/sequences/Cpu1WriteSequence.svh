class Cpu1WriteSeq extends base_sequence;
    `uvm_object_utils(Cpu1WriteSeq);
    function new(string name ="Cpu1WriteSeq");
        super.new(name);
    endfunction
    task body();
        item=sequence_item::type_id::create("item");
        start_item(item);
            Randomization: assert (item.randomize() with {req_1==ACTIVE;rw_1==ACTIVE;})
                else `uvm_fatal("CPU1_WRITE_SEQ","Assertion Randomization failed!");
        finish_item(item);
    endtask
endclass
