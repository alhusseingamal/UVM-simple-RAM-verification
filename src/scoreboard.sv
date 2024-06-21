class mem_scoreboard extends uvm_scoreboard;                                                                                
    `uvm_component_utils(mem_scoreboard)                                            // Component registration with the UVM factory
    mem_sequence_item item;
    uvm_analysis_imp # (mem_sequence_item, mem_scoreboard) scb_port;                // create the analysis port

    function new(string name = "mem_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item = mem_sequence_item::type_id::create("item");
        scb_port = new("scb_port", this);                                           // initialize the analysis port using new method
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("SCOREBOARD", $sformatf("Success Count: %0d, Fail Count: %0d", successCount, failCount), UVM_LOW)
    endfunction

    logic [`MEM_DEPTH-1:0][`DATA_WIDTH-1:0] mem = 'b0;
    logic [`ADDR_WIDTH-1:0] prev_address = 'b0;

    int successCount = 0;
    int failCount = 0;
    
    function void write(mem_sequence_item item);
        if(item.valid_out) begin
            if(mem[prev_address] == item.data_out) begin
                successCount++;
                `uvm_info("READ SUCCESS", $sformatf("at address: %0h", prev_address), UVM_LOW)
            end
            else begin
                failCount++;
                `uvm_info("READ FAILURE", $sformatf("at address: %0h", prev_address), UVM_LOW)
            end
        end
        if (item.en) begin
            mem[item.address] = item.data_in;
        end
        prev_address = item.address;
    endfunction
endclass