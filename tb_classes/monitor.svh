class monitor  extends uvm_monitor;
    `uvm_component_utils (monitor)

    // Declare the virtual interface
    virtual IF vif;

    uvm_analysis_port #(sequence_item) mon_port;

    // constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        mon_port = new("mon_port", this);

        if(!(uvm_config_db #(virtual IF)::get(this, "*", "vif", vif)))
            `uvm_fatal(get_type_name(),"Couldn't get handle to vif")
      
    endfunction :build_phase

    // run_phase
task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
        @(negedge vif.clk);
        if (vif.req_1 || vif.req_2) begin
            sequence_item  item;
            item = sequence_item::type_id::create("item");
                	item.req_1       = vif.req_1;
                    item.req_2       = vif.req_2;
		            item.rw_1        = vif.rw_1 ; 
                    item.rw_2        = vif.rw_2 ; 
		            item.addr_1      = vif.addr_1 ;
                    item.addr_2      = vif.addr_2 ;
		            item.data_in_1   = vif.data_in_1;
		            item.data_in_2   = vif.data_in_2 ; 
		            item.grant_1     = vif.grant_1;
                    item.grant_2     = vif.grant_2;
            		item.mem_rw      = vif.mem_rw;
		            item.data_out_1  = vif.data_out_1 ;
		            item.data_out_2  = vif.data_out_2 ;
		            item.mem_addr    = vif.mem_addr ; 
		            item.mem_data_in = vif.mem_data_in ; 
		            item.mem_data_out= vif.mem_data_out ;
                // Delay to allow `data_out` to stabilize after `rd_en`
                
                //@(negedge vif.clk);
                
                `uvm_info("Monitor",
                          $sformatf("Captured Transaction: grant_1=%0b  grant_2=%0b  
                                        mem_rw=%0b  data_out_1=%0h  data_out_2=%0h
                                        mem_addr=%0h   mem_data_in=%0h  mem_data_out=%0h ",item.grant_1,item.grant_2,
                                        item.mem_rw,item.data_out_1,item.data_out_2,item.mem_addr,
                                        item.mem_data_in,item.mem_data_out),
                          UVM_LOW); 

            // Write transaction to analysis port
            mon_port.write(item);
        end
    end
endtask :run_phase
endclass :monitor