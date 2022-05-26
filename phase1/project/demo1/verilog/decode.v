/*
   CS/ECE 552 Spring '22
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (clk, rst,
	       curr_PC, inc_PC, inst,  //inputs from Fetch Stage
	       WB_out,		       //inputs from the Memory/Write stage
	       RegDst, RegWrite, PC_cntrl, Imm_cntrl, Link_cntrl, RD2_sel, //inputs from control
	       ReadData1, ReadData2, Imm, PC_cntrl_out); 	  //outputs 

    // TODO: Your code here
    input wire clk, rst;
    input wire [15:0] curr_PC, inc_PC, inst, WB_out; //inputs from the Fetch and Memory/Write stages
    //inputs from the control block
    input wire [1:0] RegDst;
    input wire RegWrite, PC_cntrl, Link_cntrl, RD2_sel;
    input wire [2:0] Imm_cntrl;
    //outputs
    output wire [15:0] ReadData1, ReadData2, Imm, PC_cntrl_out;


    //2 - 1 mux for the PC value
    assign PC_cntrl_out = PC_cntrl ? curr_PC : inc_PC;
    
    //input signals and mux's for the write signals to regFile
    wire [15:0] WriteData;
    wire [2:0]  WriteReg;
    assign WriteData = Link_cntrl ? PC_cntrl_out : WB_out;
    assign WriteReg = (RegDst == 2'b00) ? inst[4:2] : //Rd
	              (RegDst == 2'b01) ? inst[7:5] : //Rt
		      (RegDst == 2'b10) ? inst[10:8] : //Rs
		      (RegDst == 2'b11) ? 3'b111 :  //R7
		      3'bxxx;
   
    wire [2:0] read2_sel, read1_sel;
    assign read2_sel = (RD2_sel) ? inst[10:8] : inst[7:5];
    assign read1_sel = inst[10:8];
    //reg File
    wire err;  //AHHHHHHHHHHHHHH I dont know what to do with you!!!!!!!!!
    regFile RegiterFile(.read1Data(ReadData1), .read2Data(ReadData2), .err(err), .clk(clk), .rst(rst), .writeEn(RegWrite),
	                .read1RegSel(read1_sel), .read2RegSel(read2_sel), .writeRegSel(WriteReg), .writeData(WriteData));


    //Immediate value is calulated here based on the instruction from Fetch
    //and control signals
    wire [15:0] s_ext_11b, s_ext_8b, z_ext_8b, s_ext_5b, z_ext_5b;
    
    assign s_ext_11b = { {5{inst[10]}}, inst[10:0] };
    assign s_ext_8b = { {8{inst[7]}}, inst[7:0] };
    assign z_ext_8b = { {8{1'b0}}, inst[7:0] };
    assign s_ext_5b = { {11{inst[4]}}, inst[4:0] };
    assign z_ext_5b = { {11{1'b0}}, inst[4:0] };
    //assign lower_4b    AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHh
    //assign lower_4_rt AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

   assign Imm = (Imm_cntrl == 3'b000) ? s_ext_5b :
	        (Imm_cntrl == 3'b001) ? z_ext_5b :
	        (Imm_cntrl == 3'b010) ? s_ext_8b :
	        (Imm_cntrl == 3'b011) ? z_ext_8b :
	        (Imm_cntrl == 3'b100) ? s_ext_11b :
	        16'b0000000000000000;	

endmodule
`default_nettype wire
