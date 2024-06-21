class mem_monitor extends uvm_monitor;
    `uvm_component_utils(mem_monitor)
    virtual mem_interface mem_intf;
    mem_sequence_item item;
    uvm_analysis_port#(mem_sequence_item) mon_port;

    function new(string name = "mem_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item = mem_sequence_item::type_id::create("item");
        mon_port = new("mon_port", this);
        assert(uvm_config_db#(virtual mem_interface)::get(this, "", "vif", mem_intf))
        else
            `uvm_fatal(get_full_name(), "Virtual interface not set in the configuration database by the my_agent class")
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        wait(mem_intf.reset_n == 1); // Wait for the reset to be de-asserted
        forever
            begin
                @(mem_intf.valid_out)
                monitor_transaction();
            end
    endtask

    task monitor_transaction();
        begin
            item.data_out = mem_intf.data_out;
            item.valid_out = mem_intf.valid_out;
            #1step  // advance the simulation time by the smallest possible time unit, Delay to allow the data to be written to the item
            mon_port.write(item);
        end
    endtask : monitor_transaction

endclass : mem_monitor