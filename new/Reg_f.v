`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 12:10:48 PM
// Design Name: 
// Module Name: Reg_f
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


module Reg_f(clk,A_add,B_add,D_add,Data_in,write_enable,A_data,B_data);
input clk;
input write_enable;
input [2:0] A_add,B_add,D_add;
input [7:0] Data_in;
output [7:0] A_data, B_data;
reg [7:0] Rf [0:7];

assign A_data = Rf[A_add];
assign B_data = Rf[B_add];
initial 
	begin
	Rf[0] = 8'b0;
	Rf[1] = 8'b0;
	Rf[2] = 8'b0;
	Rf[3] = 8'b0;
	Rf[4] = 8'b0;
	Rf[5] = 8'b0;
	Rf[6] = 8'b0;
	Rf[7] = 8'b0;
	end

always @(negedge clk)begin
    if(write_enable) begin
   // Rf[D_add] <= Data_in;
    case(D_add)
       0 : Rf[0] <= 8'b0;
    1 : Rf[1] <= 8'd1;
    2 : Rf[2] <= 8'd2;
    3 : Rf[3] <= 8'd3;
    4 : Rf[4] <= 8'd4;
    5 : Rf[5] <= 8'd5;
    6 : Rf[6] <= 8'd6;
    7 : Rf[7] <= 8'd7;
endcase
    end
    end
   //  (A_add == 3'b0)? 8'b0:
   //  = (B_add == 3'b0)? 8'b0:
endmodule
