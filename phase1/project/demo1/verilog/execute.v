/*
   CS/ECE 552 Spring '22
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
`default_nettype none
module execute (clk, rst,
	        ReadData1, ReadData2, Imm, PC_cntrl_out,   //inputs from the Decode stage
		AluSrc1, AluSrc2, Branch, Jump, AluOp, Cin, inv1, inv2, B_sel, R_sel, shft_cntrl, BTR_signal,     //inputs from the control logic
		PC_out, Alu_out, c_out, zero, neg, ltz, ovf);  //diff_sign, ovf, rs_sign);
	

   // TODO: Your code here
   input wire clk, rst;
   input wire [15:0] ReadData1, ReadData2, Imm, PC_cntrl_out;
   input wire AluSrc1, AluSrc2, shft_cntrl, Branch, Jump, Cin, inv1, inv2, R_sel, BTR_signal;
   input wire [1:0] B_sel;
   input wire [2:0] AluOp;

   output wire [15:0] PC_out, Alu_out;
   output wire c_out, zero, neg, ltz, ovf; //diff_sign, ovf, rs_sign;

   wire [15:0] RD1_lshift, Alu_in1, Alu_in2;
   
   assign RD1_lshift = shft_cntrl ? {16'h0000} : {ReadData1[7:0], 8'h00}; //figure out how what this is shifted by!!!!!!!!!
   
   
   assign Alu_in1 = AluSrc1 ? RD1_lshift : ReadData1;
   assign Alu_in2 = AluSrc2 ? Imm : ReadData2;

   
   //ALU will always assumed to be performing signed logic when determining
   //overflow
   
   wire [15:0] temp_Alu_out, BTR_val; 
   assign BTR_val = {ReadData1[0], ReadData1[1], ReadData1[2], ReadData1[3], ReadData1[4], ReadData1[5], ReadData1[6], ReadData1[7],
	         ReadData1[8], ReadData1[9], ReadData1[10], ReadData1[11], ReadData1[12], ReadData1[13], ReadData1[14], ReadData1[15]};
   alu ALU(.InA(Alu_in1), .InB(Alu_in2), .Cin(Cin), .Oper(AluOp), .invA(inv1), .invB(inv2), .sign(1'b1), .Out(temp_Alu_out), .Zero(zero), .Ofl(ovf), .Neg(neg), .Cout(c_out));

   assign Alu_out = (BTR_signal) ? BTR_val : temp_Alu_out;

   //AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
   assign ltz = (ovf & (Alu_out[15] ^ (Alu_in1[15] ^ inv1))) ? ~neg : neg;

   //Pc and immediate adder
   wire [15:0] PC_Imm;
   wire useless;
   cla_16b PC_plus_Imm(.sum(PC_Imm), .c_out(useless), .a(PC_cntrl_out), .b(Imm), .c_in(1'b0));


   //branch logic 
   wire [1:0] PC_sel;
   wire b_out, BorJ;

   assign b_out = (B_sel == 2'b00) ? Branch & zero :
	          (B_sel == 2'b01) ? Branch & ~zero :
		  (B_sel == 2'b10) ? Branch & neg :
		  (B_sel == 2'b11) ? Branch & (!neg | zero) :
		  1'b0;
   
   assign BorJ = b_out | Jump;
   assign PC_sel = {R_sel, BorJ}; 

   

   //mux to select the next PC value based on brach logic
   assign PC_out = (PC_sel == 2'b00) ? PC_cntrl_out :
	           (PC_sel == 2'b01) ? PC_Imm : 
		   (PC_sel == 2'b10) ? Alu_out:
		   (PC_sel == 2'b11) ? Alu_out:
		   2'b00;


endmodule
`default_nettype wire
