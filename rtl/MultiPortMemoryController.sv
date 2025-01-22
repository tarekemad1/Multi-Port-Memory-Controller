module MultiPortMemoryController(clk,rst_n,req_1,req_2,rw_1,rw_2,addr_1,addr_2,data_in_1,data_in_2,grant_1,grant_2,data_out_1,data_out_2,mem_addr,mem_rw,mem_data_in,mem_data_out);
		input clk , rst_n;
		input req_1,req_2; 
		input  rw_1,rw_2;
		input [3:0]  addr_1,addr_2;
		input logic [7:0]  data_in_1; 
		input logic [7:0]  data_in_2;
		
		output logic mem_rw;
		output logic grant_1,grant_2;
		output logic [7:0]  data_out_1 ;
		output logic [7:0]  data_out_2 ;
		output logic [3:0]  mem_addr ; 
		output logic [7:0]  mem_data_in ; 
		output logic [7:0]  mem_data_out ;
		parameter MEM_SIZE =16;			
		parameter TIMEOUT = 10 ;
		parameter TIME_PROCESSING =2 ; 
		typedef enum { IDLE , PROC1_READ , PROC1_WRITE , PROC2_READ , PROC2_WRITE , LOW_POWER } state; 
		state current_state ;
		state   next_state ;
		reg [3:0]timecntr;
		reg [7:0]mem[MEM_SIZE-1:0]='{default: 'h0};

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
		
		always_comb
		begin 
			grant_1      = 1'bx;
			grant_2      = 1'bx;
			data_out_1   ='hx;
		 	data_out_2   ='hx;
		 	mem_addr     ='hx;
			mem_rw	     ='bx;
		 	mem_data_in  ='hx;
			mem_data_out ='hx;
			next_state=current_state;

			if(!rst_n)
			begin 
				grant_1      = 1'bx;
				grant_2      = 1'bx;
				data_out_1   ='hx;
				data_out_2   ='hx;
				mem_addr     ='hx;
				mem_rw	     ='bx;
				mem_data_in  ='hx;
				mem_data_out ='hx;
			end
			else
			begin
				case(current_state)
					IDLE: begin 
						if(req_1)begin 
							grant_1  =1'b1; 
							mem_rw   =rw_1; 
							mem_addr =addr_1; 
							if(!mem_rw)
								begin :CPU1_Read
								mem_data_out =mem[mem_addr];
								data_out_1   =mem[mem_addr];
								next_state=PROC1_READ;
								end
							else 
								begin :CPU1_Write
								mem_data_in=data_in_1;
								mem[mem_addr] <=data_in_1 ; 
								next_state=PROC1_WRITE;
								end
						end 
						else if(req_2)begin 
							grant_2  =1'b1; 
							mem_rw   =rw_2; 
							mem_addr =addr_2; 
							if(!mem_rw)begin :CPU2_Read
								data_out_2=mem[mem_addr];
								mem_data_out =mem[mem_addr];
								next_state=PROC2_READ;
								end 
							else begin :CPU2_Write
								mem_data_in = data_in_2; 			
								mem[mem_addr] <= data_in_2;	
								next_state=PROC2_WRITE;
								end 
						end
						else 
							if(timecntr==TIMEOUT) begin
									next_state=LOW_POWER;
									
							end
							else			next_state=IDLE;
												
						end	
					PROC1_READ: next_state=IDLE;
					PROC1_WRITE:next_state=IDLE;
					PROC2_READ:next_state=IDLE;
					PROC2_WRITE:next_state=IDLE;
					LOW_POWER:
							if(req_1 || req_2)
								next_state=IDLE;
				endcase				
			end 
		end 
endmodule