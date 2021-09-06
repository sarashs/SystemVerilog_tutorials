`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2021 11:29:03 PM
// Design Name: 
// Module Name: PWM
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


module PWM #(parameter max_count = 16)(
    input logic clk,
    input logic rst,
    input logic [$clog2(max_count) - 1:0] duty_cycle,
    output logic out_clk
    );
localparam N = $clog2(max_count);
logic [N-1:0] current_state, next_state;
always_ff @(posedge clk, posedge rst)
begin 
    if (rst == 1'b1) 
    current_state <= 0; 
    else
    current_state <= next_state;
end

always_comb
begin
//Next state logic
    assign next_state = (current_state == max_count) ? 0 : current_state + 1;
// Output_logic
    assign out_clk = (current_state < duty_cycle) ? 1'b1 : 1'b0;
end

endmodule
