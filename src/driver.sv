class mem_driver extends uvm_driver #(mem_sequence_item);
    `uvm_component_utils(mem_driver)
    virtual mem_interface mem_intf;
    mem_sequence_item item;
    
    function new(string name = "mem_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item = mem_sequence_item::type_id::create("item", this);
        assert(uvm_config_db#(virtual mem_interface)::get(this, "", "vif", mem_intf))
        else
            `uvm_fatal(get_full_name(), "Virtual interface not set in the configuration database by the mem_agent class")
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(item); // Get the next item from the sequencer
            @(posedge mem_intf.clk)
            mem_intf.en <= item.en;
            mem_intf.address <= item.address;
            mem_intf.data_in <= item.data_in;
            seq_item_port.item_done();
        end
    endtask
endclass