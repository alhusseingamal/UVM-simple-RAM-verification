class mem_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(mem_sequence_item)

    function new(string name = "mem_sequence_item");
        super.new(name);
    endfunction

    // request items
    rand logic [31:0] data_in;
    rand bit en;
    randc bit [3:0]address;

    // response items
    logic [31:0] data_out;
    logic valid_out;

    constraint c_data_in {
        data_in dist {[1:32'hffff_ffff-1] :/ 90 , 32'hffff_ffff := 5, 32'h0 := 5};
    }

endclass : mem_sequence_item