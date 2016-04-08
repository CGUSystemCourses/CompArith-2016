`include "acc.vinc"

module target_design (acc_data, acc_en, clear, dout, reset, clk);

input	[`DATA_WIDTH-1:0]	acc_data;
input						acc_en;
input						clear;
output	[`DATA_WIDTH-1:0]	dout;
input						reset;
input						clk;

reg		[`DATA_WIDTH-1:0]	acc_data_reg;
reg							acc_en_reg;
reg							clear_reg;

always @(posedge clk) begin
	acc_data_reg <= acc_data;
	acc_en_reg <= acc_en;
	clear_reg <= clear;
end

acc u_accumulator (
	.data_in (acc_data_reg),
	.acc_enable (acc_en_reg),
	.clear (clear_reg),
	.data_out (dout),
	.reset (reset),
	.clk (clk)
);

endmodule


















