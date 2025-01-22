class ResetSequence extends base_sequence;
    `uvm_object_utils(ResetSequence);
    function new(string name = "ResetSequence");
        super.new(name);
    endfunction
    task body();
        item=sequence_item::type_id::create("item");
        start_item(item);
        Randomization: assert (item.randomize() with{rst_n == 1'b0;})
            else $error("Assertion Randomization failed!");
        finish_item(item);
    endtask
endclass