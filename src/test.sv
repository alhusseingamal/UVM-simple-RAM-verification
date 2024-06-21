    class mem_test extends uvm_test;
    `uvm_component_utils(mem_test)
    virtual mem_interface mem_intf;
    mem_environment mem_env;
    mem_sequence mem_seq;

    function new(string name = "mem_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // In the build phase, lower level components are instantiated
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mem_env = mem_environment::type_id::create("mem_env", this);
        mem_seq = mem_sequence::type_id::create("mem_seq");
        // get the virtual interface instance from the configuration database
        // we first check if the virtual interface instance is set in the configuration database by the testbench module
        assert(uvm_config_db#(virtual mem_interface)::get(this, "", "vif", mem_intf))
        else
            `uvm_fatal(get_full_name(), "Virtual interface not set in the configuration database by the top module")

        uvm_config_db#(virtual mem_interface)::set(this, "mem_env", "vif", mem_intf); // set the virtual interface instance in the configuration database so it can be extracted by the mem_env class later 
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
            mem_seq.start(mem_env.mem_agnt.mem_seqr);
        phase.drop_objection(this);
    endtask

    endclass : mem_test