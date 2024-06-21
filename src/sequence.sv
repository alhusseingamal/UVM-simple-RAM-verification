class mem_sequence extends uvm_sequence;
    `uvm_object_utils(mem_sequence)
    mem_sequence_item item;

    function new(string name = "mem_sequence");
        // do_not_randomize = 1'b1; // This line MUST be uncommented when using ModelSim
        super.new(name);
    endfunction

    task pre_body();
        item = mem_sequence_item::type_id::create("item");
    endtask : pre_body
    
    task body ();
        #(3 * CLK_PERIOD)
        for (int i = 0; i < mem_depth; i++) 
        begin
            start_item(item);
             if(!item.randomize() with {en == 1;})
                `uvm_fatal(get_full_name(), "Error!: randomization failed")
             finish_item(item);
        end

        for (int i = 0; i < mem_depth; i++) 
        begin
            start_item(item);
             if(!item.randomize() with {en == 0;})
                `uvm_fatal(get_full_name(), "Error!: randomization failed")
             finish_item(item);
        end

       for (int i = 0; i < iter_count; i++) 
        begin
            start_item(item);
             if(!item.randomize())
                `uvm_fatal(get_full_name(), "Error!: randomization failed")
             finish_item(item);
        end
    endtask
endclass : mem_sequence