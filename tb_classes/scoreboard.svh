class scoreboard extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(scoreboard);

    uvm_analysis_imp#(sequence_item, scoreboard) scb_imp;

    sequence_item latest_transaction;

    reg [7:0] mem[15:0]='{default: 'h0};

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_imp = new("scb_imp", this);
    endfunction

    // Write method
    function void write(sequence_item t);
        sequence_item predicted_item;
        string data_str;
        uvm_comparer comparer;

        // Save the transaction for debugging in run_phase
        latest_transaction = t;

        predicted_item = golden_model(t);
        if (predicted_item == null) begin
            `uvm_error("SCOREBOARD", "Golden model returned null")
            return;
        end

        data_str = {" ==> Actual: ", t.convert2string(), " / Predicted: ", predicted_item.convert2string()};     
        if (!predicted_item.do_compare(t, comparer))
            `uvm_error("FAIL", {"SELF_CHECKER: ", data_str})
        else
            `uvm_info("PASS", {"SELF_CHECKER: ", data_str}, UVM_LOW)
    endfunction

    // Golden model
    function sequence_item golden_model(sequence_item txn);
        sequence_item predicted_item;

        predicted_item = sequence_item::type_id::create("predicted_item");
        predicted_item.req_1=txn.req_1;
        predicted_item.req_2=txn.req_2;
        predicted_item.rw_1 =txn.rw_1;
        predicted_item.rw_2=txn.rw_2;
        predicted_item.addr_1=txn.addr_1;
        predicted_item.addr_2=txn.addr_2;
        predicted_item.data_in_1=txn.data_in_1;
        predicted_item.data_in_2=txn.data_in_2;
        if (predicted_item.req_1) begin: CPU1
            predicted_item.grant_1 = 1'b1;
            predicted_item.grant_2 = 1'bx;
            if (txn.rw_1) begin: CP1_write
                mem[predicted_item.addr_1] = predicted_item.data_in_1;
                predicted_item.mem_rw = 1'b1;
                predicted_item.data_out_1 = 'hx;
                predicted_item.data_out_2 = 'hx;
                predicted_item.mem_addr = predicted_item.addr_1;
                predicted_item.mem_data_in = predicted_item.data_in_1;
                predicted_item.mem_data_out = 'hx;
            end: CP1_write
            else begin
                predicted_item.mem_rw = 1'b0;
                predicted_item.data_out_1 = mem[predicted_item.addr_1];
                predicted_item.data_out_2 = 'hx;
                predicted_item.mem_addr = predicted_item.addr_1;
                predicted_item.mem_data_in = 'hx;
                predicted_item.mem_data_out = predicted_item.data_out_1;  
            end
        end else if (predicted_item.req_2) begin: CPU2
            predicted_item.grant_2 = 1'b1;
            predicted_item.grant_1 = 1'bx;
            if (predicted_item.rw_2) begin: CPU2_write
                mem[predicted_item.addr_2] = predicted_item.data_in_2;
                predicted_item.mem_rw = 1'b1;
                predicted_item.data_out_1 = 'hx;
                predicted_item.data_out_2 = 'hx;
                predicted_item.mem_addr = predicted_item.addr_2;
                predicted_item.mem_data_in = predicted_item.data_in_2;
                predicted_item.mem_data_out = 'hx;
            end: CPU2_write
            else begin
                predicted_item.mem_rw = 1'b0;
                predicted_item.data_out_2 = mem[predicted_item.addr_2];
                predicted_item.data_out_1 = 'hx;
                predicted_item.mem_addr = predicted_item.addr_2;
                predicted_item.mem_data_in = 'hx;
                predicted_item.mem_data_out = predicted_item.data_out_2;
            end
        end else begin
            `uvm_error("GOLDEN MODEL", "No valid request detected in the transaction")
            return null;
        end
        return predicted_item;
    endfunction: golden_model

    // Run phase for debugging transactions
    /*task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        forever begin
            if (latest_transaction != null) begin
                `uvm_info("SCOREBOARD DEBUG", $sformatf("Received transaction: %s", latest_transaction.convert2string()), UVM_HIGH)
                latest_transaction = null; // Reset after debugging
            end
            // Small delay to prevent continuous busy-waiting
            #1ns;
        end
        phase.drop_objection(this);
    endtask*/

endclass
