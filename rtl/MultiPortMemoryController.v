module MultiPortMemoryController(clk,rst_n,req_1,req_2,rw_1,rw_2,addr_1,addr_2,grant_1,grant_2,data_out_1,data_out_2,mem_addr,mem_rw,mem_data_in,mem_data_out);
		input clk , rst_n;
		input req_1,req_2; 
		input rw_1,rw_2;
		input [3:0]addr_1,addr_2;
		input [7:0] data_in_1; 
		input [7:0] data_in_2;
		
		output grant_1,grant_2;
		output [7:0] data_out_1 ;
		output [7:0] data_out_2 ;
		output [3:0] mem_addr ; 
		output [7:0] mem_data_in ; 
		output [7:0] mem_data_out ;
		parameter MEM_SIZE =16;			
		parameter TIMEOUT = 10 ;
		parameter TIME_PROCESSING =2 ; 
		typedef enum{IDLE,PROC1_READ,PROC1_WRITE,PROC2_READ,PROC2_WRITE,LOW_POWER} state; 
		state current_state,next_state;
		reg [3:0]timecntr;
		reg [7:0]mem[MEM_SIZE-1:0];

		always @(posedge clk or negedge rst_n)begin
			if(!rst_n)begin
				current_state<=IDLE;
				timecntr <='h0;
				end
			else begin 
				current_state<=next_state; 
				if(current_state==IDLE || current_state ==LOW_POWER)begin 
					timecntr<=0;
				end
				else 
						timecntr <= timecntr+1;
			end 
					
		end
		
		always_comb begin 
			grant_1      = 1'b0;
			grant_2      = 1'b0;
			data_out_1   ='h0;
		 	data_out_2   ='h0;
		 	mem_addr     ='h0;
			mem_rw	     ='b0;
		 	mem_data_in  ='h0;
			mem_data_out ='h0;
			next_state=current_state;
			case(current_state)
				IDLE: begin 
					if(req_1)begin 
						grant_1  =1'b1; 
						mem_rw   =rw_1; 
						mem_addr =addr_1; 
						if(!rw_1)
							begin 
							mem_data_out =mem[addr_1];
							data_out_1   =mem[addr_1];
							next_state=PROC1_READ;
							end
						 else 
							begin 
							mem_data_in=data_in_1; 
							next_state=PROC1_WRITE;
							end
					end 
					else if(req_2)begin 
						grant_2  =1'b1; 
						mem_rw   =rw_2; 
						mem_addr =addr_2; 
						if(!rw_2)begin 
							data_out_2=mem[addr_2];
							mem_data_out =mem[addr_2];
							next_state=PROC2_READ;
							end 
						 else begin 
							mem_data_in = data_in_2; 
							next_state=PROC2_WRITE;
							end 
					end
					else 
						if(timecntr==TIMEOUT) begin
								next_state=LOW_POWER;
								
						end
						else			next_state=IDL;
											
					end	
				PROC1_READ:
						if(timecntr==TIME_PROCESSING)	begin 
							next_state=IDLE;
					
						end 
				PROC1_WRITE:
						if(timecntr==TIME_PROCESSING)begin 
							mem[addr_1] <=data_in_1 ;
							next_state=IDLE;
					
						end 
				PROC2_READ:
						if(timecntr==TIME_PROCESSING)begin 
							next_state=IDLE;
					
						end
				PROC2_WRITE:	if(timecntr==TIME_PROCESSING)begin 	
							mem[addr_2] <= data_in_2;	
							next_state=IDLE;
							
						end
				LOW_POWER:
						if(req_1 || req_2)
							next_state=IDLE;
				default:
						next_state=IDLE;
			endcase
		end 


endmodule