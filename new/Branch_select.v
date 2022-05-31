`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 12:03:26 PM
// Design Name: 
// Module Name: Branch_select
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


module Branch_select(pc,bus_B,BrA);
input [7:0] pc,bus_B;
output reg [7:0]BrA;
always @(pc,bus_B)
begin
    BrA = pc + bus_B;
end
endmodule
