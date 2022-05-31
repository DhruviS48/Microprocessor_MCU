`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 12:23:24 PM
// Design Name: 
// Module Name: Constant_unit
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


module Constant_unit(IM,CS,cu_out);
input [5:0] IM;
input CS;
output reg [7:0] cu_out;
//always@(CS)
//if(CS == 1'b0)
 //   begin
//    cu_out = 8'b00000000 + IM;
 //   end
 //else if (CS == 1'b1 && IM[5]== 1'b0)
 //   begin
 //   cu_out = 8'b00000000 + IM;
  // end
 //else if (CS == 1'b1 && IM[5]== 1'b1)
  //  begin
   // cu_out = 8'b11000000 + IM;
 //   end   
    
    always @(CS or IM)
begin
if(CS==0)
     cu_out[7:0] = {2'b00,IM[5:0]};
else if(CS==1 && IM[5]==1'b1)
     cu_out[7:0] = {{2{IM[5]}},IM[5:0]};
else if(CS==1 && IM[5]==1'b0)
     cu_out[7:0] = {{2{IM[5]}},IM[5:0]};
end
endmodule
