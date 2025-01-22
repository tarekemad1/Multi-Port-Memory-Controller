class sequence_item extends uvm_sequence_item;
    `uvm_object_utils(sequence_item);
        rand bit   rst_n; 
    	rand bit   req_1,req_2; 
		rand bit   rw_1,rw_2;
		rand logic [3:0]  addr_1,addr_2;
		rand logic [7:0]  data_in_1; 
		rand logic [7:0]  data_in_2;
		
		logic mem_rw;
		logic grant_1,grant_2;
		logic [7:0]  data_out_1 ;
		logic [7:0]  data_out_2 ;
		logic [3:0]  mem_addr ; 
		logic [7:0]  mem_data_in ; 
		logic [7:0]  mem_data_out ;
        constraint REQ_CPU_1{req_1 dist {1:=60,0:=40};}
        constraint REQ_CPU_2{req_2 dist {1:=60,0:=40};}
        constraint RW_CPU_1{rw_1 dist {1:=50,0:=50};}
        constraint RW_CPU_2{rw_2 dist {1:=50,0:=50};}
        constraint RESET{rst_n dist{1:=95,0:=5};}

    function new(string name="sequence_item");
        super.new(name);
    endfunction
	function string convert2string();
		string s; 
		s=$sformatf("rst_n=%0b  req_1=%0b  req_2=%0b  rw_1=%0b  rw_2=%0b  addr_1=%0h  addr_2=%0h  data_in_1=%0h  data_in_2=%0h 
					mem_rw=%0b  grant_1=%0b  grant_2=%0b  data_out_1=%0h   data_out_2=%0h  mem_addr=%0h  mem_data_in=%0h  
					mem_data_out=%0h",rst_n,req_1,req_2,rw_1,rw_2,addr_1,addr_2,data_in_1,data_in_2,mem_rw,grant_1,grant_2,data_out_1,data_out_2,
										mem_addr,mem_data_in,mem_data_out);
		return s ; 
	endfunction :convert2string
	  
function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    sequence_item compared_item;
    bit same;

    // Check for null pointer
    if (rhs == null) begin
        `uvm_fatal("NULL_PTR", "Tried to do comparison to a null pointer");
        return 0;
    end

    // Cast the rhs object to sequence_item
    if (!$cast(compared_item, rhs)) begin
        `uvm_error("CAST_FAIL", "Failed to cast rhs object to sequence_item");
        return 0;
    end

    // Start with the superclass comparison
    same = super.do_compare(rhs, comparer);

    // Compare essential fields strictly
    same &= (compared_item.rst_n == rst_n) &&
            (compared_item.req_1 == req_1) &&
            (compared_item.req_2 == req_2) &&
            (compared_item.rw_1 == rw_1) &&
            (compared_item.rw_2 == rw_2) &&
            (compared_item.addr_1 == addr_1) &&
            (compared_item.addr_2 == addr_2) &&
            (compared_item.data_in_1 == data_in_1) &&
            (compared_item.data_in_2 == data_in_2) &&
            (compared_item.mem_rw == mem_rw) &&
            (compared_item.mem_addr == mem_addr);

    // Compare fields that may contain unknown ('x') values
    same &= (!$isunknown(compared_item.data_out_1) ? (compared_item.data_out_1 == data_out_1) : 1);
    same &= (!$isunknown(compared_item.data_out_2) ? (compared_item.data_out_2 == data_out_2) : 1);
    same &= (!$isunknown(compared_item.mem_data_in) ? (compared_item.mem_data_in == mem_data_in) : 1);
    same &= (!$isunknown(compared_item.mem_data_out) ? (compared_item.mem_data_out == mem_data_out) : 1);
    same &= (!$isunknown(compared_item.grant_2) ? (compared_item.grant_2 == grant_2) : 1);

    return same;
endfunction: do_compare





endclass