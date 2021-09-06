`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2021 12:36:25 PM
// Design Name: 
// Module Name: float2init_tb
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


module float2init_tb(

    );

logic sign_in;
logic [30:23] exponent_in;
logic [22:0] mantissa;
logic sign_out;
logic [30:0] int_out;
logic overflow, underflow;
shortreal test_array[8] = {0, 3.14, 100, 1e6, -1e6, -100, -3.14, -0.12};
logic [31:0] temp_holder;
    
 float2int UUT (.sign_in(sign_in), .exponent_in(exponent_in), .mantissa(mantissa), .sign_out(sign_out), .int_out(int_out), .overflow(overflow), .underflow(underflow));

 
 always begin
    for(int i = 0; i<8; ++i) begin
        temp_holder = test_array[i];
        {exponent_in, mantissa} = temp_holder[30:0];
        if (i < 4)
            sign_in = 1'b0;
        else
            sign_in = 1'b1;
        #25;
    end
    $stop;
 end
endmodule