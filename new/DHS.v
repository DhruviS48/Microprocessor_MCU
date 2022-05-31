`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2021 05:03:33 PM
// Design Name: 
// Module Name: DHS
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


module DHS(MA,MB,RW,AA,BA,DA,DHS_O,DHS_I);
//inputs
input wire MA,MB,RW;
input wire [2:0] AA,BA,DA;

//output
output wire DHS_O,DHS_I;

//Temp wires
wire HA,HB,CmpAOut,CmpBOut,NMA,NMB,DAOr;

//compa
assign CmpAOut = (AA == DA) ? 1:0;

//compb
assign CmpBOut = (BA == DA) ? 1:0;

//DAOr
assign DAOr = (DA[2] || DA[1] || DA[0]);

//NMA
assign NMA = ~MA;

//NMB
assign NMB = ~MB;

//HA
assign HA = RW && NMA && DAOr && CmpAOut;

//HB
assign HB = RW && NMB && DAOr && CmpBOut;

//DHS_O
assign DHS_O = HA || HB;

//DHS_I
assign DHS_I = ~DHS_O;
endmodule
