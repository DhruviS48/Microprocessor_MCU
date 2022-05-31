`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 04:00:02 PM
// Design Name: 
// Module Name: ALU
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


module ALU(function_select,shift,A,B,F,zero,neg,carry,overflow,X);
    input [3:0] function_select;
    input [2:0] shift;
    input [7:0] A,B;
    output reg [7:0] X;
    output wire [7:0] F;
    output zero,neg,carry,overflow;
    
     reg zero,neg,carry,overflow;
    reg [8:0] regcarry; // 9 bits
    always@(A,B,function_select)begin
        case(function_select)
            //Addition
            4'b0000: regcarry = A+B;
            // AND Immediate and And Immediate
            4'b0001: regcarry = A&B;
            //Subtract
            4'b0010: regcarry[7:0] = A+ (~B +1);
            //Set if Less Than
            4'b0011: regcarry = A<B;
            // Compliment
            4'b0100: regcarry = ~A;
            // OR Immediate
            4'b0101: regcarry = A|B;
            // Exclusive-OR
            4'b0110: regcarry = A^B;
            // Logical Shift Right
            4'b0111: regcarry = A<< shift;
            // Logical Shift Left
            4'b1000: regcarry = A>> shift; 
            // default
            4'b1001: regcarry = (A == A) && (B ==B);
        endcase
        // Zero flag
        if(regcarry == 0)
        begin
           zero <= 1; 
        end
        else 
        begin 
            zero <= 0;
         end
        // Negative flag
        if( regcarry[7]== 1 )
            begin 
            neg <= 1;
            end
        else
            begin
            neg <= 0;
            end
        // Carry Flag
        if(regcarry[8]== 1'b1)
        begin
            carry <= 1;
        end
        else
        begin
            carry <= 0;
        end 
        // Overflow Flag
        if(function_select == 4'b0010)
        begin
             X = ~B+1;
            if(A[7]== X[7] && regcarry[7]!=A[7])
                begin
                overflow <= 1;
                end
           else
                begin
                overflow <= 0;
                end
        end
        else
        if(A[7]== B[7]&& regcarry[7]!=A[7])
        begin
            overflow <= 1;
        end
        else
        begin
            overflow <= 0;
        end
     end
    // Assign
    assign F = regcarry[7:0];
    
endmodule
