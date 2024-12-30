Multi-Port Memory Controller
Overview
The Multi-Port Memory Controller is a Verilog-based design 
that allows two processors to access a shared memory system. 
It handles read and write requests from two processors, 
with simple state machine arbitration and a timeout mechanism to transition to low-power mode.
Module Description

Inputs:

clk, rst_n: Clock and reset signals.
req_1, req_2: Request signals from Processor 1 and Processor 2.
rw_1, rw_2: Read/Write control signals for each processor.
addr_1, addr_2: Memory addresses for each processor.
data_in_1, data_in_2: Data inputs for write operations.

Outputs:
grant_1, grant_2: Grant signals for memory access.
data_out_1, data_out_2: Data outputs for read operations.
mem_addr, mem_data_in, mem_data_out: Address and data for memory operations.

Memory Operations:
Read: Fetch data from memory when the processor sends a read request.
Write: Store data in memory when the processor sends a write request.

Example of Operation:
Processor 1 (Read):

req_1 asserted, grant_1 given, data read from memory.
Processor 2 (Write):

req_2 asserted, grant_2 given, data written to memory.

Conclusion
The Multi-Port Memory Controller is a flexible and efficient design for handling memory access from two processors.
It incorporates arbitration, a simple state machine, and a low-power state to ensure proper memory access and energy efficiency. You can further extend this design by implementing more sophisticated memory architectures, adding error handling, or integrating it into a larger system.