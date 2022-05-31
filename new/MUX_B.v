`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 10:33:16 AM
// Design Name: 
// Module Name: MUX_B
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


module MUX_B(registerB,CS,MB,bus_B);
input [7 :0] registerB;
    input [7:0] CS;
    input MB;
    output reg [7:0]bus_B;
    always@(MB or registerB or CS)
    begin
        if(MB == 0)
        begin
            bus_B = registerB;
        end
       else
        begin
            bus_B = CS;
        end
        end
endmodule
