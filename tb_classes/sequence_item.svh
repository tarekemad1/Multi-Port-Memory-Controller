class sequence_item extends uvm_sequence_item;
    `uvm_object_utils(sequence_item);
    	rand bit req_1,req_2; 
		rand bit  rw_1,rw_2;
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

    function new(string name="sequence_item");
        super.new(name);
    endfunction

endclass