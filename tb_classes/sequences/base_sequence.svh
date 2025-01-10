class base_sequence extends uvm_sequence #(sequence_item);
    `uvm_object_utils(base_sequence);
    sequence_item item ; 
    parameter ACTIVE = 1'b1;
    parameter DEACTIVE =1'b0;
    function new(string name = "base_sequence");
        super.new(name);
    endfunction
endclass