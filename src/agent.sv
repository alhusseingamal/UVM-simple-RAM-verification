class mem_agent extends uvm_agent;
    `uvm_component_utils(mem_agent)
    virtual mem_interface mem_intf;
    mem_sequencer   mem_seqr;
    mem_driver      mem_drv;
    mem_monitor     mem_mon;

    function new(string name = "mem_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mem_seqr = mem_sequencer::type_id::create("mem_seqr", this);
        mem_drv = mem_driver::type_id::create("mem_drv", this);
        mem_mon = mem_monitor::type_id::create("mem_mon", this);

        assert(uvm_config_db#(virtual mem_interface)::get(this, "", "vif", mem_intf))
        else
            `uvm_fatal(get_full_name(), "Virtual interface not set in the configuration database by the mem_env class")

        uvm_config_db#(virtual mem_interface)::set(this, "mem_drv", "vif", mem_intf);
        uvm_config_db#(virtual mem_interface)::set(this, "mem_mon", "vif", mem_intf);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        // Connect the sequence item port in the driver to the sequence item export in the sequencer
        mem_drv.seq_item_port.connect(mem_seqr.seq_item_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask
endclass;