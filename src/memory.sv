module memory #(parameter ADDR_WIDTH = 4, parameter DATA_WIDTH = 32) (mem_interface.mp1 X);
// this strongly defines any parameter to the memory unit as a modport of type mp1
    logic [DATA_WIDTH - 1 : 0] memory [0 : 2**ADDR_WIDTH - 1];    
    always_ff @(posedge X.clk, negedge X.reset_n)
    begin
        if (~X.reset_n)                             // active low reset
        begin
            foreach (memory[i])
                memory[i] <= '0;   
            X.data_out <= '0;
            X.valid_out <= 1'b0; 
        end
        else if (X.en)                              // @ en = 1, write to memory
            begin
                memory[X.address] <= X.data_in;
                X.valid_out <= 1'b0;                
            end
        else                                        // @ en = 0, read from memory
            begin
                X.data_out <= memory[X.address];
                X.valid_out <= (X.address >= 0 && X.address < (1 << ADDR_WIDTH)) ? 1'b1 : 1'b0;
            end
    end

endmodule : memory