`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2021 07:31:10 PM
// Design Name: 
// Module Name: Register_file
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


module Register_file(
input clk,
input[2:0] A_add,
input[2:0] B_add,
input[2:0] D_add,
input[7:0] data_in,
input write_enable,
output reg[7:0] data_a,
output reg[7:0] data_b);

reg [7:0] rf [7:0];
always @(posedge clk)
   begin
   if(write_enable) begin
           
   rf[D_add] <= data_in;
               end
   assign data_a = rf[A_add];
   assign data_b = rf[B_add];
end
endmodule
