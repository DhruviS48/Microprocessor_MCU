`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2021 11:33:46 AM
// Design Name: 
// Module Name: Program_memory
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


module Program_memory(address,instruct);
input [7:0] address;
output reg [16:0] instruct;
reg [16:0] mem [255:0] ; // 256*17 mem

// PARAMETERS
parameter NOP = 5'b00000; // value 0 eg:NOP
parameter ADD = 5'b00001; //value 1 eg: ADD 
parameter ANI = 5'b00010; //value 2 eg: ANI 
parameter ADI = 5'b00011; // value 3 eg: ADI
parameter SUB = 5'b00100; //value 4 eg: SUB
parameter SLT = 5'b00101; //value 5 eg: SLT
parameter IN = 5'b00110; //value 6 eg: IN
parameter OUT = 5'b00111; //value 7 eg: OUT
parameter NOT = 5'b01000; //value 8 eg: NOT
parameter LD = 5'b10001; //value 9 eg: LD
parameter ST = 5'b01010; //value 10 eg: ST
parameter MOV = 5'b11011; // value 11 eg: MOV 
parameter JMP = 5'b01100; // value 12 eg: JMP
parameter JMR = 5'b01101; // value 13 eg: JMR
parameter JML = 5'b01110; // value 14 eg: JML 
parameter ORI =  5'b01111; // value 15 eg: ORI
parameter XOR = 5'b11011; // value 16 eg: XOR
parameter LSR = 5'b11111; // value 17 eg: LSR
parameter LSL  = 5'b11101; // value 18 eg: LSL 
parameter BZ = 5'b10011; // value 19 eg: BZ 
parameter BNZ  = 5'b10100; // value 20 eg: BNZ

always @(*)
begin
case (address)
// (opcode, DR,DA,DB)
//mem[0] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[1] = {ADI, 3'b001, 3'b000, 3'b000, 3'b001}; // R1 = R0+ 1 // r2 = 1
//mem[2] = {ADI, 3'b010, 3'b000, 3'b000, 3'b100}; // R2 = R0+ 4 // r3 = 4




//mem[3] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[4] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[5] = {ADD, 3'b011, 3'b001, 3'b010, 3'b000}; // R3 = R1+ R2 = 5
//mem[6] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};





//mem[4] = {ADD, 3'b101, 3'b010, 3'b100, 3'b000}; // r5 = r2 + r3
//mem[5] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};





//mem[7] = {ANI, 3'b100, 3'b001, 3'b010, 3'b000}; // R4 = R1 | R2

//mem[8] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[9] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[10] = {LSL, 3'b101, 3'b011, 3'b000, 3'b011};// R5 = R3<SH
//mem[11] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[12] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[13] = {SLT, 3'b000, 3'b000, 3'b000, 3'b000}; // R6= 1 , IF R1<R2
//mem[14] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[15] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[16] = {SUB, 3'b111, 3'b010, 3'b001, 3'b000}; // R7 = R2-R1 =3
//mem[17] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[18] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[19] = {LD, 3'b010, 3'b111, 3'b000, 3'b000}; // R2 = Mmem[r7]
//mem[20] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};

//mem[8] = {MOV, 3'b001, 3'b111, 3'b000, 3'b000}; // MOV R7 TO R1







//mem[11] = {NOP, 3'b000, 3'b000, 3'b000, 3'b000};
//mem[13] ={ADD, 3'b101, 3'b010, 3'b011, 3'b000}; // R4 = R1+ R2
//mem[14]={ADD, 3'b011, 3'b010, 3'b101, 3'b000}; // r5 = r1 + r3
        0 : instruct = {IN, 3'b001, 3'b000, 3'b000, 3'b000};
        1 : instruct = {LSL, 3'b010, 3'b001, 3'b000, 3'b100};
        2 : instruct = {LSR, 3'b010, 3'b010, 3'b000, 3'b100}; 
        3 : instruct = {LSR, 3'b100, 3'b001, 3'b000, 3'b100};
        4 : instruct = {OUT, 3'b000, 3'b010, 3'b100, 3'b000};
        5 : instruct = {JMR, 3'b000, 3'b000, 3'b000, 3'b000};



endcase
end

//always@(address)
	//begin
		// instruct = mem[address];
	//end
endmodule
