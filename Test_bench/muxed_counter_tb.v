`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2021 02:12:02 PM
// Design Name: 
// Module Name: muxed_counter_tb
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


module muxed_counter_tb(

    );
    parameter half_period = 5; //period 10 * 1ns = 10 ns
    parameter num_counters = 4;
    reg [3:0] in_signal;
    wire [num_counters*32 - 1:0] freq;
    reg clk;
    reg rst;
    muxed_counter #(.num_counters(num_counters)) UUT (.in_signal(in_signal), .clk(clk), .rst(rst), .freq(freq));
    
    // counter clock signal
always 
begin
    clk = 1'b1; 
    #half_period; // high for 5 * timescale = 5 ns

    clk = 1'b0;
    #half_period; // low for 5 * timescale = 5 ns
end

    // input clocks
    
always 
begin
    in_signal[0] = 1'b1; 
    #1;

    in_signal[0] = 1'b0;
    #1;
end

always 
begin
    in_signal[1] = 1'b1; 
    #2;

    in_signal[1] = 1'b0;
    #2;
end

always 
begin
    in_signal[2] = 1'b1; 
    #3;

    in_signal[2] = 1'b0;
    #3;
end

always 
begin
    in_signal[3] = 1'b1; 
    #4;

    in_signal[3] = 1'b0;
    #4;
end

always @(posedge clk)
begin
    // value for rst
    rst = 1'b0;
    #30; // wait for period
    rst = 1'b1;
    #30; // wait for period
    
    rst = 1'b0;
    #10000000;
    $stop;
end
endmodule
