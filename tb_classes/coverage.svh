class cvarg extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(cvarg);
    sequence_item item;
    sequence_item queue[$];
    uvm_analysis_imp #(sequence_item,cvarg) cov_imp;

    covergroup CPU1;
        REQ1: coverpoint item.req_1 {
            bins ACTIVE={1'b1};
            bins DEACTIVE={1'b0};
        }
        RW1: coverpoint item.rw_1 {
            bins RD_FOR_CPU1 ={1'b0};
            bins WR_FOR_CPU1 ={1'b1};
        }
        ADDR1: coverpoint item.addr_1 {
            bins ADDRS_ALL_ZEROS={'h0};  
            bins ADDRS = default;  
        }
    endgroup
        covergroup CPU2;
        REQ2: coverpoint item.req_2{
            bins ACTIVE={1'b1};
            bins DEACTIVE={1'b0};
        }
        RW2: coverpoint item.rw_2{
            bins RD_FOR_CPU2 ={1'b0};
            bins WR_FOR_CPU2 ={1'b1};
        }
        ADDR2: coverpoint item.addr_2{
            bins ADDRS_ALL_ZEROS={'h0}; 
            bins ADDRS = default;  
        }
    endgroup
        // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        cov_imp = new("cov_imp", this);
    endfunction :build_phase

    function void write (sequence_item t);
        queue.push_front(t);
    endfunction :write
    function new(string name,uvm_component parent);
        super.new(name,parent);
        CPU1=new();
        CPU2=new();
    endfunction
    //run phase
	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
       `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
        forever begin
	      item = sequence_item::type_id::create("item",this);
          wait(queue.size!=0);
	     	item  = queue.pop_back();
	    CPU1.sample();  
        CPU2.sample();
        end 
    endtask :run_phase
endclass