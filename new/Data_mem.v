`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2021 11:02:33 AM
// Design Name: 
// Module Name: Data_mem
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


module Data_mem(
input clk,
 input[7:0] address,
 input write_enable,
 input [7:0] data_input,
 output[7:0] data_output

 );
   reg[7:0] data_output;
   reg[7:0] memo[255 :0]; 
   //integer i;
   always @(negedge clk)
   begin
   if(write_enable) begin
           
   memo[address] <= data_input;
               end
    
   data_output <= memo[address];
     end      
endmodule
