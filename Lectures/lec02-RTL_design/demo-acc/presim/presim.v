/*******************************************************************************
 *
 * file: [tg10::ts00-acc_synth/st02-synth/presim.v]
 *
 ******************************************************************************/

`include "acc.vinc"

module main;

//clock generation and simulation cycle counting
reg				clk;
reg		[31:0]	sim_cycle;

initial			clk = 1;
always			#5 clk = ~clk;

//instant the test target
reg		[`DATA_WIDTH-1:0]	acc_data;
reg							acc_en;
reg							clear;
wire	[`DATA_WIDTH-1:0]	dout;
reg							reset;

target_design u_target (
	.acc_data (acc_data),
	.acc_en (acc_en),
	.clear (clear),
	.dout (dout),
	.reset (reset),
	.clk (clk)
);

//simulation control
initial begin
	//load delay information
	//$sdf_annotate ("target_design.sdf", u_target);
	//$sdf_annotate ("u_acc.sdf", u_target.u_accumulator);

	//start waveform generation
	$vcdplusfile ("target_design.vpd");
	$vcdpluson;

	//initial control signal
	acc_en = 1'b0;
	clear = 1'b0;

	//reset the test target
	@(posedge clk);
	#3;
	reset = 1'b1;

	@(posedge clk);

	@(posedge clk);
	#3;
	reset = 1'b0;
	sim_cycle = 32'h0;

	while (sim_cycle<15) begin
		@(posedge clk);
		sim_cycle = sim_cycle+1;

		//feed test vectors
		#1;
		//feed test vectors
		case (sim_cycle)
			3: begin
				acc_en = 1'b1;
				acc_data = `DATA_WIDTH'h10;
			end

			4: begin
				acc_en = 1'b1;
				acc_data = `DATA_WIDTH'h20;
			end

			5: begin
				acc_en = 1'b1;
				acc_data = `DATA_WIDTH'h42;
			end

			8: begin
				acc_en = 1'b1;
				acc_data = `DATA_WIDTH'h19;
			end

			default: begin
				acc_en = 1'b0;
				acc_data = `DATA_WIDTH'hx;
			end
		endcase

		#7;
		$display ("%d: dout = 'h%h", sim_cycle, dout);
	end

	$finish (0);
end

endmodule
















