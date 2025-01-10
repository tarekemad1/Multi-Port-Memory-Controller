class Cpu2WriteSeq extends base_sequence;
    `uvm_object_utils(Cpu2WriteSeq);
    function new(string name ="Cpu2WriteSeq");
        super.new(name);
    endfunction
    task body();
        item=sequence_item::type_id::create("item");
        Randomization: assert (item.randomize() with {req_2==ACTIVE;rw_2==ACTIVE;})
            else `uvm_fatal("CPU2_Write_SEQ","Assertion Randomization failed!");
    endtask
endclass