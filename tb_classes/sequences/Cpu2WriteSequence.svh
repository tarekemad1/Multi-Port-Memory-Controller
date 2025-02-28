class Cpu2WriteSeq extends base_sequence;
    `uvm_object_utils(Cpu2WriteSeq);
    function new(string name ="Cpu2WriteSeq");
        super.new(name);
    endfunction
    task body();
    repeat(5) begin 
        item=sequence_item::type_id::create("item");
        start_item(item);
        Randomization: assert (item.randomize() with {req_2==ACTIVE;req_1==DEACTIVE;rw_2==ACTIVE;})
            else `uvm_fatal("CPU2_Write_SEQ","Assertion Randomization failed!");
            `uvm_info("Write_Request","CPU2",UVM_LOW);
        finish_item(item);
    end
    endtask
endclass