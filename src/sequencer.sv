class mem_sequencer extends uvm_sequencer #(mem_sequence_item);
    `uvm_component_utils(mem_sequencer)

    function new(string name = "mem_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask
    
endclass : mem_sequencer