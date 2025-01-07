module top;
    import uvm_pkg::*;
    import MPMC_pkg::*;
    parameter HALF_CYCLE =5 ; 
    parameter rst_n_TIME  =20 ; 
    logic rst_n , clk ; 

    IF vif (clk , rst_n );
    MPMC   dut(clk,rst_n, vif.req_1 , vif.req_2 , vif.rw_1, vif.rw_2 , 
                    vif.addr_1 , vif.addr_2,vif.data_in_1,vif.data_in_2,vif.grant_1,vif.grant_2
                    ,vif.data_out_1,vif.data_out_2,vif.mem_addr,vif.mem_rw,vif.mem_data_in,vif.mem_data_out);


    initial begin
        clk = 0 ;
        forever begin
            #HALF_CYCLE; clk = ~clk;
        end
    end

    initial begin
        rst_n = 1;
        #rst_n_TIME ;
        rst_n=0;
        #20 rst_n = 1; // Keep reset asserted for 2 clock cycles
    end

    initial begin
        uvm_config_db #(virtual IF)::set(null, "*", "vif", vif);
        run_test();
    end

endmodule