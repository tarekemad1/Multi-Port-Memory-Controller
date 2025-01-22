class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils (driver)

    // Declare the virtual interface
    virtual IF  vif;


    // constructor
    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        // Get the interface handle
        if (!(uvm_config_db #(virtual IF)::get(this, "*", "vif", vif)))
            `uvm_fatal(get_type_name(),"Couldn't get handle to vif")

    endfunction :build_phase

    // run_phase
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
        forever begin
            sequence_item  item;
            item=sequence_item::type_id::create("item");
            seq_item_port.get_next_item(item);
            drive_item(item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive_item (sequence_item item);
        @(posedge vif.clk);
        //#10;
            vif.rst_n <=item.rst_n;
            vif.req_1 <=item.req_1;
            vif.req_2  <= item.req_2;
		    vif.rw_1   <= item.rw_1;
            vif.rw_2   <= item.rw_2;
		    vif.addr_1 <=  item.addr_1;
            vif.addr_2 <= item.addr_2;
		    vif.data_in_1 <=item.data_in_1;
		    vif.data_in_2 <= item.data_in_2;
         `uvm_info("DRIVER", $sformatf("Driver Received: srt_n=%0b req1=%0d,req2=%0d , rw_1=%0h,rw_2=%0b ,addr_1=%0h
                                        addr_2=%0h,data_in_1=%0h,data_in_2=%0h",item.rst_n,
                                        item.req_1,item.req_2 ,item.rw_1,item.rw_2,item.addr_1
                                            ,item.addr_2,item.data_in_1,item.data_in_2), UVM_LOW);
            @(posedge vif.clk); // Wait for the next clock cycle
            vif.req_1   <= 0;
            vif.req_2   <= 0;
        if (item.rw_1 || item.rw_2) begin
            @(posedge vif.clk);
            vif.data_in_1 <= 'hX;
            vif.data_in_2 <= 'hx; 
            end
    endtask :drive_item
endclass :driver