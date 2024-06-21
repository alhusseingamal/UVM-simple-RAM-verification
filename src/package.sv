`define DATA_WIDTH 32
`define ADDR_WIDTH 4
`define MEM_DEPTH  16
`include "uvm_macros.svh"
package mem_package; 
    import uvm_pkg::*;
    int T;
    parameter CLK_PERIOD = 10;
    parameter mem_width = 32;
    parameter mem_depth = 16;
    parameter iter_count = 2000;
    `include "sequence_item.sv"
    `include "sequence.sv"
    `include "sequencer.sv"   
    `include "driver.sv"    
    `include "monitor.sv"
    `include "scoreboard.sv"
    `include "subscriber.sv"
    `include "agent.sv"
    `include "env.sv"
    `include "test.sv"
endpackage : mem_package