`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2021 03:44:41 PM
// Design Name: 
// Module Name: float2int
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


module float2int(
    input  logic sign_in,
    input  logic [30:23] exponent_in,
    input  logic [22:0] mantissa,
    output logic sign_out,
    output logic [30:0] int_out,
    output logic overflow, underflow
    );

   // signal declaration
   logic [30:0] s0, s1, s2, s3;
   logic [7:0] exponent;

assign sign_out = sign_in;

//mult by power    
always_comb begin
       exponent = exponent_in - 127;
       if (exponent[7] == 1'b0) begin
       // stage 0, shift 0 or 1 bit
       s0 = exponent[0] ? {7'b0, 1'b1, mantissa, 1'b0} : {7'b0, 1'b1, mantissa};
       // stage 1, shift 0 or 2 bits
       s1 = exponent[1] ? {s0[28:0], 2'b0} : s0;
       // stage 2, shift 0 or 4 bits
       s2 = exponent[2] ? {s1[26:0], 4'b0} : s1;
       // stage 3, shift 0 or 8 bits
       int_out = exponent[3] ? {s2[22:0], 8'b0} : s2;
       // overflow
       overflow = (|exponent[6:4]);
       underflow = 1'b0;
       end
       else begin
       // stage 0, shift 0 or 1 bit
       s0 = exponent[0] ? {9'b0, mantissa[22:1]} : {8'b0, mantissa};
       // stage 1, shift 0 or 2 bits
       s1 = exponent[1] ? {2'b0, s0[22:2]} : s0;
       // stage 2, shift 0 or 4 bits
       s2 = exponent[2] ? {4'b0, s1[22:4]} : s1;
       // stage 3, shift 0 or 8 bits
       s3 = exponent[3] ? {8'b0, s2[22:8]} : s2;
       // stage 4, shift 0 or 16 bits
       int_out = exponent[4] ? {16'b0, s3[22:16]} : s3;
       // overflow
       overflow = 1'b0;
       underflow = (|mantissa) & (~(|int_out) | (|exponent[6:5]));
       end
   end
endmodule
