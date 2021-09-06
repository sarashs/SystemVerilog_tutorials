`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2021 04:14:45 PM
// Design Name: 
// Module Name: Advanced_barrel_shifter
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


module Advanced_barrel_shifter#( parameter signal_length = 8
    )
    (
    input  logic [(signal_length-1):0] in_sig,
    input  logic lr, // left(0)-right(1) signal
    input  logic [3:0] amt, //amount of shift
    output logic [(signal_length-1):0] y
   );

   // signal declaration
   logic [(signal_length-1):0] s0, s1;

always_comb
   // body
   if (lr == 1'b1) begin
       // stage 0, shift 0 or 1 bit
       s0 = amt[0] ? {in_sig[0], in_sig[(signal_length-1):1]} : in_sig;
       // stage 1, shift 0 or 2 bits
       s1 = amt[1] ? {s0[1:0], s0[(signal_length-1):2]} : s0;
       // stage 2, shift 0 or 4 bits
       y = amt[2] ? {s1[3:0], s1[(signal_length-1):4]} : s1;
   end
   else if (lr == 1'b0) begin
       // stage 0, shift 0 or 1 bit
       s0 = amt[0] ? {in_sig[(signal_length-2):0], in_sig[(signal_length-1)]} : in_sig;
       // stage 1, shift 0 or 2 bits
       s1 = amt[1] ? {s0[(signal_length-3):0], s0[(signal_length-1):(signal_length-2)]} : s0;
       // stage 2, shift 0 or 4 bits
       y = amt[2] ? {s1[(signal_length-5):0], s1[(signal_length-1):(signal_length-4)]} : s1;
   end
endmodule
