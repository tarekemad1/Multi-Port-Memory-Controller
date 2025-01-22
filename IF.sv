interface IF (input logic clk);
		logic rst_n;
		logic req_1,req_2; 
		logic rw_1,rw_2;
		logic [3:0]  addr_1,addr_2;
		logic [7:0]  data_in_1; 
		logic [7:0]  data_in_2;
		
		logic mem_rw;
		logic grant_1,grant_2;
		logic [7:0]  data_out_1 ;
		logic [7:0]  data_out_2 ;
		logic [3:0]  mem_addr ; 
		logic [7:0]  mem_data_in ; 
		logic [7:0]  mem_data_out ;
endinterface :IF