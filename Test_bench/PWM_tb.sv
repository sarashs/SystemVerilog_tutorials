`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2021 11:53:24 PM
// Design Name: 
// Module Name: PWM_tb
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


module PWM_tb(

    );
 localparam  T=20; // clock period
 localparam max_count = 15;
 
logic clk;
logic rst;
logic [$clog2(max_count) - 1:0] duty_cycle;
logic out_clk;
 
 PWM #(.max_count(max_count)) UUT(.*);
 
   //****************************************************************
   // clock
   //****************************************************************
   // 20 ns clock running forever
   always
   begin
      clk = 1'b1;
      #(T/2);
      clk = 1'b0;
      #(T/2);
   end
   
    //****************************************************************
   // reset for the first half cycle
   //****************************************************************
   initial
   begin
     rst = 1'b1;
     #(T/2);
     rst = 1'b0;
   end
 
 initial
 begin
    @(negedge rst);  // wait reset to deassert
    repeat(2) @(negedge clk);    // wait for one clock

    duty_cycle = 4'b0001;
    repeat(5) @(negedge out_clk);
    
    duty_cycle = 4'b0010;
    repeat(5) @(negedge out_clk);
        
    duty_cycle = 4'b0100;
    repeat(5) @(negedge out_clk);
    
    duty_cycle = 4'b1000;
    repeat(5) @(negedge out_clk);    

    duty_cycle = 4'b1111;
    #(5*16*T);
    $stop;
 end  
 
endmodule
