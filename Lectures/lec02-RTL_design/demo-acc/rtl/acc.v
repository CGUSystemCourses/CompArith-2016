`include "acc.vinc"

module acc (data_in, acc_enable, clear, data_out, reset, clk);

input	[`DATA_WIDTH-1:0]	data_in;
input						acc_enable;
input						clear;
output	[`DATA_WIDTH-1:0]	data_out;
input						reset;
input						clk;

reg		[`DATA_WIDTH-1:0]	acc_reg;

always @(posedge clk) begin
	if (reset)
		acc_reg <= `DATA_WIDTH'h0;
	else if (clear)
		acc_reg <= `DATA_WIDTH'h0;
	else if (acc_enable)
		acc_reg <= acc_reg + data_in;
	else
		acc_reg <= acc_reg;
end

assign data_out = acc_reg;

endmodule


















