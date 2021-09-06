`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2021 11:56:36 PM
// Design Name: 
// Module Name: Advance_barrel_shifter_tb
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


module Advance_barrel_shifter_tb(

    );
localparam signal_length = 8;
logic [(signal_length-1):0] in_sig;
logic lr; // left(0)-right(1) signal
logic [2:0] amt; //amount of shift
logic [(signal_length-1):0] y;

// instantiate shifter
Advanced_barrel_shifter #(.signal_length(signal_length)) UUT (.in_sig(in_sig), .lr(lr), .amt(amt), .y(y));

initial
in_sig = 2'h01;

always
begin
lr = 1'b1;
#100;
lr = 1'b0;
#100;
$stop;
end

always
begin
amt = 3'b001;
#25;
amt = 3'b000;
#25;
amt = 3'b011;
#25;
amt = 3'b111;
#25;
amt = 3'b100;
#25;
amt = 3'b010;
#25;
amt = 3'b101;
#25;
amt = 3'b110;
#25;
end
endmodule

