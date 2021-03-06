`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 11:42:20 AM
// Design Name: 
// Module Name: MUX_D
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


module MUX_D(alu_fs,datamem_out,MD,bus_D,Fpga_imp);
input [7:0] alu_fs,datamem_out,Fpga_imp;
//input [6:0] c;
input [1:0] MD;
output reg [7:0] bus_D;
//assign c = 7'b0000000;
always@(MD)
    begin
        if(MD == 0)
        begin
            bus_D = alu_fs;
        end
       else if (MD == 1)
        begin
            bus_D = datamem_out;
        end
        else if(MD == 2)
        begin 
            bus_D = Fpga_imp;
        end
        end
endmodule
