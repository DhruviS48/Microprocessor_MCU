`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2021 05:19:23 PM
// Design Name: 
// Module Name: BranchDetection
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


module BranchDetection(BS_In,RW_In,MW_In,PS_In,Inst_In,BranchD_O,BS_N);
//Input
input wire [1:0] BS_In;
input wire  RW_In,MW_In,PS_In;
input wire [16:0] Inst_In;

//Output PS
output wire BS_N;
output wire [16:0] BranchD_O;

//Bstemp
wire  BSTemp;

//Orring BS_In
assign BSTemp = BS_In[0] || BS_In[1];

//Not BSTemp
assign BS_N = ~ BSTemp;

//And rw,mw,ps
assign RW_O = RW_In && BS_N;
assign MW_O = MW_In && BS_N;
assign PS_O = PS_In && BS_N;

//And Instr_In
assign BranchD_O = Inst_In & BS_N;
endmodule
