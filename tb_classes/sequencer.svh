class sequencer extends uvm_sequencer#(sequence_item);
    `uvm_component_utils(sequencer);
    function new(string name , uvm_component parent );
        super.new(name,parent);
    endfunction
endclass