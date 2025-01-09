class scoreboard extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(scoreboard);
    
    uvm_analysis_imp#(sequence_item,scoreboard) scb_imp;
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_imp=new("scb_imp",this);
    endfunction
    function void write (sequence_item t);
        sequence_item predicted_item ;
        string data_str;
        uvm_comparer comparer; 
        predicted_item = golden_model(t);
        data_str = {" ==>  Actual ",t.convert2string(), "/Predicted ",predicted_item.convert2string()};     
      if (!predicted_item.do_compare(t,comparer))
        `uvm_error("SELF CHECKER", {"FAIL: ",data_str})
      else
        `uvm_info ("SELF CHECKER", {"PASS: ", data_str}, UVM_HIGH)

    endfunction
    function sequence_item golden_model(sequence_item txn);
        reg [7:0]mem[15:0];
        if (txn.req_1) begin:CPU1
            txn.grant_1=1'b1;
            txn.grant_2=1'b0;
            if (txn.rw_1) begin:CP1_write
                mem[txn.addr_1]=txn.data_in_1;
                txn.mem_rw=1'b1;
                txn.data_out_1='hx;
                txn.data_out_2='hx;
                txn.mem_addr=txn.addr_1;
                txn.mem_data_in=txn.data_in_1;
                txn.mem_data_out='hx;
            end:CP1_write
            else begin:CPU1_read
                txn.mem_rw=1'b0;
                txn.data_out_1=mem[txn.addr_1];
                txn.data_out_2='hx;
                txn.mem_addr=txn.addr_1;
                txn.mem_data_in='hx;
                txn.mem_data_out=txn.data_out_1;  
            end:CPU1_read
        end
        else if (txn.req_2) begin:CPU2
            txn.grant_2=1'b0;
            txn.grant_1=1'b1;
            if (txn.rw_2) begin:CPU2_write
                mem[txn.addr_2]=txn.data_in_2;
                txn.mem_rw=1'b1;
                txn.data_out_1='hx;
                txn.data_out_2='hx;
                txn.mem_addr=txn.addr_2;
                txn.mem_data_in=txn.data_in_2;
                txn.mem_data_out='hx;
            end:CPU2_write
            else begin:CPU2_read
                txn.mem_rw=1'b0;
                txn.data_out_2=mem[txn.addr_2];
                txn.data_out_1='hx;
                txn.mem_addr=txn.addr_2;
                txn.mem_data_in='hx;
                txn.mem_data_out=txn.data_out_2;
            end:CPU2_read
        end
    endfunction:golden_model
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass