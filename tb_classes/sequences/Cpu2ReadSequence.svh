class Cpu2ReadSeq extends base_sequence;
    `uvm_object_utils(Cpu2ReadSeq);

    function new(string name = "Cpu2ReadSeq");
        super.new(name);
    endfunction
    task body();
    repeat(5) begin 
        item = sequence_item::type_id::create("item");
        start_item(item);
            Randomization: assert (item.randomize() with{req_2==ACTIVE;req_1==DEACTIVE;rw_2==DEACTIVE;})
                else `uvm_fatal("CPU2_READ_SEQ","Assertion Randomization failed!");
                `uvm_info("Read_Request","CPU2",UVM_LOW);
        finish_item(item);
    end 
    endtask
endclass