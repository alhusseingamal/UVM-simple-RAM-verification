class mem_environment extends uvm_env;
    `uvm_component_utils(mem_environment) // register mem_agent class with the UVM factory
    virtual mem_interface mem_intf;
    mem_agent mem_agnt;
    mem_scoreboard mem_scb;
    mem_subscriber mem_sub; 

    function new(string name = "mem_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

// During the build phase, create instances of mem_agent, mem_subscriber and mem_scoreboard classes using the UVM factory's create method
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mem_agnt = mem_agent::type_id::create("mem_agnt", this);
        mem_scb = mem_scoreboard::type_id::create("mem_scb", this);
        mem_sub = mem_subscriber::type_id::create("mem_sub", this);
        
        // get the virtual interface instance from the configuration database 
        assert(uvm_config_db#(virtual mem_interface)::get(this, "", "vif", mem_intf))
        else
            `uvm_fatal(get_full_name(), "Virtual interface not set in the configuration database by the mem_test class")
        // set the virtual interface instance in the configuration database so it can be extracted by the mem_agent class later 
        uvm_config_db#(virtual mem_interface)::set(this, "mem_agnt", "vif", mem_intf);
    endfunction

    // Typically, the connect phase is used to connect the TLM ports of the components
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        mem_agnt.mem_mon.mon_port.connect(mem_scb.scb_port); // connect the analysis port of the monitor to the analysis port of the scoreboard
        mem_agnt.mem_mon.mon_port.connect(mem_sub.analysis_export); // connect the analysis port of the monitor to the analysis port of the subscriber
    endfunction

    // The run phase is where the testbench is stimulated with sequences
    // This is where the actual verification process starts
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask
endclass : mem_environment