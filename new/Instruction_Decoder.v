`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 05:58:24 PM
// Design Name: 
// Module Name: Instruction_Decoder
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


module Instruction_Decoder(instruct,RW,DA,MD,BS,PS,MW,FS,MA,MB,AA,BA,CS,fpga_wrt);
    input [16:0] instruct;
    output reg [1:0] MD,BS;
    output reg [3:0] FS;
    output reg RW,PS,MW,MA,MB,CS;
    output reg [2:0] DA,AA,BA;
    output reg fpga_wrt; // FPGA write enable bit
    reg [4:0] OPCODE;
    
    always@(*)
    begin
    AA = instruct[8:6];
    BA = instruct[5:3];
    DA = instruct[11:9];
    OPCODE=instruct[16:12];
    case(OPCODE)
  //  reg RW,PS,MW,MA,MB,CS;
    //No operation
    5'b00000: begin
     FS = 4'b1001; 
     MD = 2'b00;
     BS = 2'b00; 
     RW = 1'b0;
     PS = 1'b0; 
     MW = 1'b0;
     MA = 1'b0; 
     MB = 1'b0; 
     CS = 1'b0;
     AA = 3'b000;
     BA = 3'b000;
     DA = 3'b000;
     end
    // Addition
    5'b00001: begin 
    FS = 4'b0000; 
    MD = 2'b00 ; 
    BS = 2'b00;
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0; 
    AA = instruct[8:6];
    BA = instruct[5:3];
    DA = instruct[11:9];
    end
    //AND Immediate
    5'b00010: begin 
    FS = 4'b0001; 
    MD = 2'b00 ; 
    BS = 2'b00;
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b1; 
    CS = 1'b0;
    BA = 3'b000; 
    AA = instruct[8:6];
    DA = instruct[11:9];
    end
    //Add immediate
    5'b00011: begin 
    FS = 4'b0001; 
    MD = 2'b00; 
    BS = 2'b00; 
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b1; 
    CS = 1'b1;
    BA = 3'b000;
    AA = instruct[8:6];
    DA = instruct[11:9];
    end
    //Subract
    5'b00100: begin 
    FS = 4'b0010; 
    MD = 2'b00 ; 
    BS = 2'b00;
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0; 
    AA = instruct[8:6];
    BA = instruct[5:3];
    DA = instruct[11:9];
    end
    //Set if less that
    5'b00101: begin 
    FS = 4'b0011; 
    MD = 2'b10; 
    BS = 2'b00; 
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0; 
    AA = instruct[8:6];
    BA = instruct[5:3];
    DA = instruct[11:9];
    end
    
    
    // Compliment
    5'b00110: begin 
    FS = 4'b0100;
    MD = 2'b00; 
    BS = 2'b00; 
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0;
    BA = 3'b000; 
    AA = instruct[8:6];
    DA = instruct[11:9];
    end
    //Load
    5'b00111: begin 
    FS = 4'b1001; 
    MD = 2'b01; 
    BS = 2'b00;
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0;
    BA = 3'b000;
    AA = instruct[8:6];
    DA = instruct[11:9];
    end
    // Store
    5'b01000: begin 
    FS = 4'b1001; 
    MD = 2'b00; 
    BS = 2'b00; 
    RW = 1'b0;
    PS = 1'b0; 
    MW = 1'b1;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0;
    DA = 3'b000;
    AA = instruct[8:6]; 
    BA = 3'b000;
    end
    //Move
    5'b01001: begin 
    FS = 4'b1001; 
    MD = 2'b00; 
    BS = 2'b00; 
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0;
    BA = 3'b000; 
    AA = instruct[8:6];
    DA = instruct[11:9];
    end
    //Jump        
    5'b01010: begin 
    FS = 4'b1001; 
    MD = 2'b00; 
    BS = 2'b11; 
    RW = 1'b0;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b1; 
    MB = 1'b1; 
    CS = 1'b1;
    DA = 3'b000;
    AA = 3'b000;
    BA = 3'b000; 
    end
    //Jump Register
    5'b01011:begin 
    FS = 4'b1001; 
    MD = 2'b00; 
    BS = 2'b10; 
    RW = 1'b0;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b1;
    DA = 3'b000;
    BA = instruct[5:3];
    AA = 3'b000; 
    end
    //Jump and Link
    5'b01100: begin 
    FS = 4'b1001; 
    MD = 2'b00; 
    BS = 2'b11; 
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b1; 
    MB = 1'b1; 
    CS = 1'b1;
    DA = instruct[11:9]; 
    AA = 3'b000;
    BA = 3'b000;
    end
    // OR Immediate
    5'b01101: begin 
    FS = 4'b0101; 
    MD = 2'b00; 
    BS = 2'b00;
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b1; 
    CS = 1'b0;
    BA = 3'b000; 
    AA = instruct[8:6];
    DA = instruct[11:9];
    end 
    //Exclusive-OR
    5'b01110: begin 
    FS = 4'b0110; 
    MD = 2'b00; 
    BS = 2'b00; 
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0; 
    AA = instruct[8:6];
    BA = instruct[5:3];
    end
    //Logical shift Right 
    5'b01111: begin 
    FS = 4'b0111; 
    MD = 2'b00; 
    BS = 2'b00; 
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0;
    BA = 3'b000;  
    AA = instruct[8:6];
    DA = instruct[11:9];
    end
    // Logical shift left 
    5'b10001: begin 
    FS = 4'b1000; 
    MD = 2'b00; 
    BS = 2'b00;
    RW = 1'b1;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b0; 
    CS = 1'b0;
    BA = 3'b000;
    AA = instruct[8:6];
    DA = instruct[11:9]; 
    end
    // Branch if Zero  
    5'b10010: begin 
    FS = 4'b1001; 
    MD = 2'b00; 
    BS = 2'b01; 
    RW = 1'b0;
    PS = 1'b0; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b1; 
    CS = 1'b1;
    DA = 3'b000;
    AA = 3'b000;
    BA = 3'b000; 
    end
    // Branch if nonzero
    5'b10011: begin 
    FS = 4'b1001; 
    MD = 2'b00; 
    BS = 2'b01;
    RW = 1'b0;
    PS = 1'b1; 
    MW = 1'b0;
    MA = 1'b0; 
    MB = 1'b1; 
    CS = 1'b1;
    DA = 3'b000;
    AA = 3'b000;
    BA = 3'b000; 
    end
    // Input
    5'b10100: begin
    FS = 4'b0000; MD = 2'b11 ; BS = 2'b00; DA = instruct[11:9]; AA = instruct[8:6]; BA = instruct[5:3]; 
    RW = 1'b1;PS = 1'b0; MW = 1'b0;MA = 1'b0; MB = 1'b0; CS = 1'b0; fpga_wrt = 1'b0;
    end
    
    // Output
    5'b10101: begin
     FS = 4'b0000; MD = 2'b00 ; BS = 2'b00; DA = 3'b000; AA = instruct[8:6]; BA = instruct[5:3]; 
    RW = 1'b1;PS = 1'b0; MW = 1'b0;MA = 1'b0; MB = 1'b0; CS = 1'b0; fpga_wrt = 1'b1;
    end
    
   // default : begin
   // RW=1'b0; DA=3'b000; MD=2'b00; BS=2'b00; PS=1'b0; MW=1'b0; FS=4'b1001; MA=1'b0; MB=1'b0; AA=3'b000; BA=3'b000; CS=1'b0; end
    endcase
    end
    
endmodule
