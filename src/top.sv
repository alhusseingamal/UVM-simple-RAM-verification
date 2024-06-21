module top;
    import uvm_pkg::*;
    import mem_package::*;

    bit clk;
    logic reset_n;

    mem_interface mem_intf(.clk(clk), .reset_n(reset_n));
    memory dut(mem_intf); // instead of passing each signal to the memory module, we pass the interface instance as described by the modport mp1
    initial begin
        uvm_config_db #(virtual mem_interface)::set(null, "uvm_test_top", "vif", mem_intf); // set the virtual interface instance in the configuration database
        run_test("mem_test"); 
        // Remember that there is a $finish statement in the run_test method, hence it should be the last statement in the testbench, this could also be passed from the command line
    end

    // Reset generation
    initial begin
        clk = 0;
        reset_n = 0;
        #(CLK_PERIOD) reset_n = 1;
    end

    // Clock generation
    always begin
        #(CLK_PERIOD/2) clk = ~clk;
    end

    // Max Number of iterations
    initial begin
        // to be done later
    end
endmodule: top