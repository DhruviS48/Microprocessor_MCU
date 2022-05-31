`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2021 11:43:31 AM
// Design Name: 
// Module Name: MCU
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


module MCU(clk,reset,fpga_in,fpga_out);
input clk,reset;

                                                                 // Initial Stage

// Register
reg [7:0] PC_R;
input[8:0] fpga_in;
output [9:0] fpga_out;

//Wire
wire [7:0] MuxC_Out;


                                                           //Instruction Fetch stage

   // Wire
wire [7:0] Pc_Fetch, Pc_pc1_Fetch;
wire [16:0] Inst_Fetch;
wire [16:0] Branch_Fetch;

    // Register
reg [7:0] Pc1_IF_R;
reg [16:0] IR_IF_R;

   // Assign PC_Fetch
assign Pc_Fetch = PC_R;

//PC_P1_Fetch Update
assign Pc_pc1_Fetch = PC_R + 8'h1;  

// Performing ProgramMem Fetch
Program_memory PmemFetch(.address(Pc_Fetch),.instruct(Inst_Fetch));

                                                                 // Decoder Stage

// WIRES
wire [2:0] AA_Decoder,BA_Decoder, DA_Dec, SH_Dec;
wire [7:0] A_Data_Decoder,B_Data_Decoder,PC1_Dec;
wire RW_Dec,PS_Dec,MW_Dec, MA_Dec, MB_Dec,CS_Dec,BS_Invert_wire;
wire [1:0] MD_Dec, BS_Dec;
wire [3:0] FS_Dec;
wire [7:0] busA_Dec, busB_Dec, constant_output_Dec;
wire [5:0] IM_Dec;
wire [16:0] IR_Dec;
wire FPGA_Dec; // FPGA write, wire out


// Register 
reg [7:0] PC2_Dec_R, busA_Dec_R,busB_Dec_R;
reg RW_Dec_R,PS_Dec_R,MW_Dec_R;
reg [2:0] DA_Dec_R,SH_Dec_R;
reg [1:0] MD_Dec_R, BS_Dec_R;
reg [3 :0] FS_Dec_R;

// Assignment of Wires
assign PC1_Dec = Pc1_IF_R;
assign IR_Dec = IR_IF_R;
assign IM_Dec = IR_IF_R[5:0];
assign SH_Dec = IR_IF_R[2:0];
//assign FS_Dec = FS_Dec_R;

//Call Functions

// MUX A
MUX_A MuxACall(.registerA(A_Data_Decoder),.pc_1(PC1_Dec),.bus_A(busA_Dec),.MA(MA_Dec));

//MUX B
MUX_B MuxBCall(.registerB(B_Data_Decoder),.CS(constant_output_Dec),.MB(MB_Dec),.bus_B(busB_Dec));

//Instruction Decoder
Instruction_Decoder InstructionDecoderCall(.instruct(IR_Dec),.RW(RW_Dec),.DA(DA_Dec),.MD(MD_Dec),.BS(BS_Dec),
           .PS(PS_Dec),.MW(MW_Dec),.FS(FS_Dec),.MA(MA_Dec),.MB(MB_Dec),.AA(AA_Decoder),.BA(BA_Decoder),.CS(CS_Dec),.fpga_wrt(FPGA_Dec));
           
           // Constant Unit Call
   Constant_unit ConstantunitCall(.IM(IM_Dec),.CS(CS_Dec),.cu_out(constant_output_Dec));
   
   //Branch Detection Call
BranchDetection BranchdetectCall(.BS_In(BS_Dec),.RW_In(RW_Dec),.MW_In(MW_Dec),.PS_In(PS_Dec),.Inst_In(Inst_Fetch),.BranchD_O(Branch_Fetch),.BS_N(BS_Invert_wire));   

                                                                // Execution Stage

// WIRES
wire RW_EX,PS_EX, MW_EX;
wire [2:0] DA_EX,SH_EX; 
wire [1:0] MD_EX,BS_EX;
wire [3:0] FS_EX; 
wire [7:0] PC2_EX;
wire [7:0] BrA_EX; 
wire [7:0] BusB_EX,RAA_EX;
wire [7:0] ALU_FS_EX,Datamem_EX;
wire Zero_EX,Carry_EX,Neg_EX,Overflow_EX;
wire DHS_Out, DHS_Not_W;
wire [8:0] fpga_in; // FPGA input pins
wire [9:0] fpga_out; // FPGA output pins
wire [7:0] Fpga_DataIO_Ex; //FPGA Dataout wire
// REGISTER
reg RW_EX_R;
reg [2:0] DA_EX_R;
reg [1:0] MD_EX_R;
reg [7:0] ALU_EX_R, Datamem_EX_R;
reg [7:0] FPGA_DataIO_R;

//Assignment of Wires
assign RW_EX = RW_Dec_R; 
assign PS_EX = PS_Dec_R;
assign MW_EX = MW_Dec_R;
assign DA_EX = DA_Dec_R; 
assign SH_EX = SH_Dec_R;
assign MD_EX = MD_Dec_R;
assign BS_EX = BS_Dec_R;
assign FS_EX = FS_Dec_R;
assign PC2_EX = PC2_Dec_R; 
assign BusB_EX = busB_Dec_R;
assign RAA_EX = busA_Dec_R;



// Adder Call
Branch_select AdderCall(.pc(PC2_EX),.bus_B(BusB_EX),.BrA(BrA_EX));

// ALU Call
ALU ALUCall(.function_select(FS_EX),.shift(SH_EX),.A(RAA_EX),.B(BusB_EX),.F(ALU_FS_EX),.zero(Zero_EX),.neg(Neg_EX),.carry(Carry_EX),.overflow(Overflow_EX));

// Data Memory Call
Data_mem DataMemCall(.clk(clk),.address(RAA_EX),.write_enable(MW_EX),.data_input(BusB_EX),.data_output(Datamem_EX));

// PC to MuxC used in iniital stage!!!!
MUX_C PC_Fetch(.BS(BS_EX),.PCIn(Pc_pc1_Fetch),.PCout(MuxC_Out),.BrA(BrA_EX),.RAA(RAA_EX),.PS(PS_EX),.Z(Zero_EX));

// DHS Call
DHS DHSCall(.MA(MA_Dec),.MB(MB_Dec),.RW(RW_EX),.AA(AA_Decoder),.BA(BA_Decoder),.DA(DA_EX),.DHS_O(DHS_Out),.DHS_I(DHS_Not_W));

// I/O Call
mcu_io IO_MODULE(.clk(clk),.reset(reset),.output_write_enable(FPGA_Dec),.output_data_in(BusB_EX),.output_data_address(RAA_EX),.input_data_out(Fpga_DataIO_Ex),.fpga_in(fpga_in),.fpga_out(fpga_out));

                                                           // Last stage -- Write Back //

///WIRES
wire [7:0] alu_wb,da_wb,busD_wb;
wire rw_wb;
wire [2:0] datamem_wb;
wire [1:0] md_wb;
wire [7:0] FPGA_wb;

//Assignment
assign alu_wb = ALU_EX_R;
assign da_wb = DA_EX_R;
assign rw_wb = RW_EX_R;
assign datamem_wb = Datamem_EX_R;
assign md_wb = MD_EX_R;
assign FPGA_wb = FPGA_DataIO_R;
// Register file call
Reg_f Regfile_Fetch(.clk(clk),.A_add(AA_Decoder),.B_add(BA_Decoder),.D_add(da_wb),.Data_in(busD_wb),.write_enable(rw_wb),.A_data(A_Data_Decoder),.B_data(B_Data_Decoder));
// MUX D Call
MUX_D MUX_D_Call(.alu_fs(alu_wb),.datamem_out(datamem_wb),.MD(md_wb),.bus_D(busD_wb),.Fpga_imp(FPGA_wb));

// Initilization of Registers

 
//always @(!reset)
//begin

//// Initial stage
//PC_R = 0;
//Pc1_IF_R = 0;
//IR_IF_R = 0;

// // Decoder stage

//PC2_Dec_R = 0;
//busA_Dec_R = 0;
//busB_Dec_R = 0;
//RW_Dec_R = 0;
//PS_Dec_R = 0;
//MW_Dec_R = 0;
//DA_Dec_R = 0;
//SH_Dec_R = 0;
//MD_Dec_R = 0;
//BS_Dec_R = 0;
//FS_Dec_R = 0;

//   // Execution stage
// RW_EX_R = 0;
// DA_EX_R = 0;
// MD_EX_R = 0;
// ALU_EX_R = 0;
// Datamem_EX_R = 0;
// FPGA_DataIO_R = 0;
//end
// Register Assignment
always @(posedge clk or negedge reset)
begin
if(!reset)
begin

// Initial stage
PC_R = 0;
Pc1_IF_R = 0;
IR_IF_R = 0;

 // Decoder stage

PC2_Dec_R = 0;
busA_Dec_R = 0;
busB_Dec_R = 0;
RW_Dec_R = 0;
PS_Dec_R = 0;
MW_Dec_R = 0;
DA_Dec_R = 0;
SH_Dec_R = 0;
MD_Dec_R = 0;
BS_Dec_R = 0;
FS_Dec_R = 0;

   // Execution stage
 RW_EX_R = 0;
 DA_EX_R = 0;
 MD_EX_R = 0;
 ALU_EX_R = 0;
 Datamem_EX_R = 0;
 FPGA_DataIO_R = 0;
end
else
begin
if((DHS_Out == 0) && (!(BS_Dec[0] || BS_Dec[1]))) // basic N
begin

// Initial stage
PC_R = MuxC_Out;

// Instruction fetch
Pc1_IF_R = Pc_pc1_Fetch;
IR_IF_R = Inst_Fetch;

 // Decode stage
PC2_Dec_R = PC1_Dec;
busA_Dec_R = busA_Dec;
busB_Dec_R = busB_Dec;
RW_Dec_R = RW_Dec;
PS_Dec_R = PS_Dec;
MW_Dec_R = MW_Dec;
DA_Dec_R = DA_Dec;
SH_Dec_R = SH_Dec;
MD_Dec_R = MD_Dec;
BS_Dec_R = BS_Dec;
FS_Dec_R = FS_Dec;

 // Execution stage
 RW_EX_R = RW_EX;
 DA_EX_R = DA_EX;
 MD_EX_R = MD_EX;
 ALU_EX_R = ALU_FS_EX;
 Datamem_EX_R = Datamem_EX;
 FPGA_DataIO_R = Fpga_DataIO_Ex;
 
end

else if((DHS_Out == 1) && (!(BS_Dec[0] || BS_Dec[1]))) // DHS

begin

 PC_R   = PC_R;
 
    // Instruction Fetch
 Pc1_IF_R = Pc1_IF_R;
 IR_IF_R = IR_IF_R;
 
       // Decode stage
 PC2_Dec_R = PC2_Dec_R;
 busA_Dec_R = busA_Dec;
 busB_Dec_R = busB_Dec;
 RW_Dec_R = RW_Dec && DHS_Not_W;
 DA_Dec_R = DA_Dec && DHS_Not_W;
 MD_Dec_R = MD_Dec;
 BS_Dec_R = BS_Dec && DHS_Not_W;
 PS_Dec_R = PS_Dec;
 MW_Dec_R = MW_Dec && DHS_Not_W;
 FS_Dec_R = FS_Dec;
 SH_Dec_R = SH_Dec;
 
     // Execution Stage
 RW_EX_R = RW_EX;
 DA_EX_R = DA_EX;
 MD_EX_R = MD_EX;
 ALU_EX_R = ALU_FS_EX;
 Datamem_EX_R = Datamem_EX;
 FPGA_DataIO_R = Fpga_DataIO_Ex;
  end 

else if ((DHS_Out == 0) && (BS_Dec[0] || BS_Dec[1])) // branch detection
begin

 // Initial stage
PC_R = MuxC_Out;

 // Instruction fetch
Pc1_IF_R = Pc_pc1_Fetch;
IR_IF_R = Branch_Fetch;

     // Decode stage
PC2_Dec_R = PC1_Dec;
busA_Dec_R = busA_Dec;
busB_Dec_R = busB_Dec;
RW_Dec_R = RW_Dec && BS_Invert_wire;
DA_Dec_R = DA_Dec;
MD_Dec_R = MD_Dec;
BS_Dec_R = BS_Dec && BS_Invert_wire;
PS_Dec_R = PS_Dec;
MW_Dec_R = MW_Dec && BS_Invert_wire;
FS_Dec_R = FS_Dec;
SH_Dec_R = SH_Dec;

    // Execution Stage
 RW_EX_R = RW_EX;
 DA_EX_R = DA_EX;
 MD_EX_R = MD_EX;
 ALU_EX_R = ALU_FS_EX;
 Datamem_EX_R = Datamem_EX;
 FPGA_DataIO_R = Fpga_DataIO_Ex;

end

end
end
endmodule
