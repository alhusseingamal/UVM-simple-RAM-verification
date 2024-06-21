class mem_subscriber extends uvm_subscriber #(mem_sequence_item);
    `uvm_component_utils(mem_subscriber)
    mem_sequence_item item;

    covergroup mem_coverage;
        option.per_instance = 1;
        data_out: coverpoint item.data_out {
            bins bin_1[] = {32'h0, 32'hffff_ffff};
            bins bin_2[] = (32'h0, 32'hffff_ffff => 32'h0, 32'hffff_ffff);
        }

        valid_out: coverpoint item.valid_out {
           bins bin_1[] = (1, 0 => 0, 1);
           bins bin_2 = (1[*3]);
           bins bin_3 = (0[*3]);
        }
    endgroup

    function void write(mem_sequence_item t);
        item = t;
        mem_coverage.sample();
    endfunction

    function new(string name = "mem_subscriber", uvm_component parent = null);
        super.new(name, parent);
        mem_coverage = new();
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item = mem_sequence_item::type_id::create("item");
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask
endclass : mem_subscriber