`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2021 08:34:33 PM
// Design Name: 
// Module Name: muxed_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module muxed_counter #
    (
    parameter num_counters = 10
    )
	(
    input [num_counters-1:0] in_signal,
    input clk,
    input rst,
    output [num_counters*32 - 1:0] freq
    );

reg [num_counters*32 - 1 :0] freq_count;
reg [31:0] clk_count;
reg clk_done;
reg [num_counters*32 - 1:0] freq_out;
reg [31:0] selected_freq_out;
logic selected_signal;
reg [$clog2(num_counters):0] state; 

(*DONT_TOUCH= "true"*) assign freq = freq_out;

generate	
genvar i; 
for (i = 0; i < num_counters; i = i+1) begin
always_comb begin
    if (rst == 1'b1)
        freq_count[(i+1)*32 - 1 -: 32] <= 32'b0;
    else if (state == i)
        freq_count[(i+1)*32 - 1 -: 32] <= selected_freq_out;
end
end
endgenerate



always_comb begin
for (int i = 0; i < num_counters; i = i+1) begin
    case(state)
    i : selected_signal = in_signal[i];
    default : selected_signal = in_signal[0];
    endcase
end
end


always_ff @(posedge clk_done) begin
    if (state < num_counters && rst == 1'b0) begin
        state <= state + 1;
    end
    else begin
        state <= 0;
    end
end

always_ff @(posedge selected_signal) begin
    selected_freq_out <= selected_freq_out + 1;
    if (clk_done == 1) begin
        selected_freq_out <= 0; 
    end
end

always_ff @(posedge clk) begin
	if ((clk_count > 99998) & (clk_count < 100010) & rst == 1'b0) begin //we stop the count for a full milisecon
	    clk_done <= 1'b1;
	    clk_count <= clk_count + 1;
	end
	else if (clk_count == 100010 || rst == 1'b1) begin
		clk_count <= 0;
		clk_done <= 1'b0;
	end
	else begin
	   clk_count <= clk_count + 1;
       clk_done <= 1'b0;
    end
end

always_ff @(posedge clk_done) begin
   freq_out <= freq_count;
end

endmodule