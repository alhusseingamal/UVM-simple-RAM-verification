interface mem_interface #(parameter ADDR_WIDTH = 4, parameter DATA_WIDTH = 32) (input bit clk, input logic reset_n);
	logic en;
	logic [DATA_WIDTH-1:0]data_in;
    logic [ADDR_WIDTH-1:0]address;
	logic [DATA_WIDTH-1:0]data_out;
	logic valid_out;

	modport mp1
	(
		input data_in, address, clk, en, reset_n,
		output data_out, valid_out
	);

    clocking CB @(posedge clk);
        input data_out, valid_out;
        output data_in, address, en;
    endclocking
	
endinterface: mem_interface