# Multi-Port-Memory-Controller UVM Testbench

Overview

This phase involves developing a UVM-based testbench environment to verify the functionality and performance of the Multi-Port Memory Controller (DUT). 
The testbench will simulate realistic scenarios and ensure the DUT operates as expected under various conditions.

Testbench Architecture

Components :

1. DUT (Device Under Test): The Multi-Port Memory Controlle 
module.

2.Driver: Drives stimulus (requests, addresses, data) to the DUT inputs.

3.Sequencer: Generates sequences of transactions (read/write operations).

4.Monitor: Observes DUT responses and outputs for verification.

5.Scoreboard: Compares actual DUT outputs with expected results to check correctness.

6.Environment: Encapsulates all UVM components.

Test Scenarios: 

    Planned Scenarios:

       1. Read Operation: Validate correct data is retrieved for a given address.

       2. Write Operation: Confirm data is correctly stored at the specified address.

       3. Arbitration: Ensure proper handling of simultaneous requests from both processors.

       4. Low-Power Transition: Verify the DUT transitions to  low-power mode after the timeout period.

Features to Verify
    Accurate memory read/write operations.

    Correct arbitration between Processor 1 and Processor 2.

    Timeout handling and low-power state transition.

    Functional correctness under various workloads.

How to Run the Simulation
    1.Set Up the Environment:

        Ensure the UVM library and the DUT Verilog module are included in your simulation environment.

    2.Compile the Code

        Use a simulator (e.g., QuestaSim) to compile both the DUT and the UVM components.

    3.Execute Tests

        Run the testbench with different test cases to verify all scenarios.

    4.Analyze Results:

        Review scoreboard comparisons and coverage metrics.

        Debug any mismatches or failures in DUT behavior.

Tools and Dependencies

        UVM Library: For building the testbench components.

        Simulation Tool: QuestaSim or any compatible simulator.
        Coverage Analysis: To ensure full functional verification.
