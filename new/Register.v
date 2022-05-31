`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2021 08:15:29 PM
// Design Name: 
// Module Name: Register
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


module Register(clk,A_add,B_add,D_add,data_in,write_enable,data_a,data_b);
input clk;
input[2:0] A_add;
input[2:0] B_add;
input[2:0] D_add;
input[7:0] data_in;
input write_enable;
output reg[7:0] data_a;
output reg[7:0] data_b;

reg [7:0] rf [0:7];
always @(posedge clk)
   begin
   if(write_enable) 
           
   rf[D_add] <= data_in;
              
   assign data_a = (A_add == 3'b0) ? 8'b0:rf[A_add];
   assign data_b = (B_add == 3'b0) ? 8'b0 :rf[B_add];
end
endmodule
