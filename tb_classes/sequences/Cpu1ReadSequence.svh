 
class Cpu1ReadSeq extends base_sequence;

    `uvm_object_utils(Cpu1ReadSeq);
    function new(string name="Cpu1ReadSeq");
        super.new(name);
    endfunction
    task body();
    repeat(5) begin 
        item=sequence_item::type_id::create("item");
        start_item(item);
        assert(item.randomize() with{req_1==ACTIVE;req_2==DEACTIVE;rw_1==DEACTIVE;})
            else `uvm_fatal("CPU1_READ_SEQ","Error in Asserting read");
            `uvm_info("Read_Request","CPU2",UVM_LOW);
        finish_item(item);
    end 
    endtask
endclass
   	