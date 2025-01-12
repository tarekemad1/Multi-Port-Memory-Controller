class IdlSequence extends base_sequence;
    `uvm_object_utils(IdlSequence);
    function new(string name = "IdlSequence");
        super.new(name);
    endfunction
    task body();
        sequence_item iitem ;
        item=sequence_item::type_id::create("item");
        start_item(item);
            #50;
        finish_item(item);
    endtask
endclass