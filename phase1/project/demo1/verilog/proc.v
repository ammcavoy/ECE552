/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
`default_nettype none
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input wire clk;
   input wire rst;

   output reg err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */
   


   //ERR SIGNALS NOT COMING FROM ANY SUB MODULES
   
   //Control outputs 
   //decode state
   wire ReadData2_sel, RegWrite, PC_cntrl, Link_cntrl;
   wire [1:0] RegDst;
   wire [2:0] Imm_cntrl;
   //execute state
   wire AluSrc1, AluSrc2, Branch, Jump, Cin, inv1, inv2, R_sel, shft_cntrl, BTR_signal;
   wire [1:0] B_sel;
   wire [2:0] AluOp;
   //mem stage
   wire MemWrite, MemRead, MemReg;
   wire [2:0] Set_cntrl;

   //Fetch Stage outputs
   wire [15:0] inst, pc_f_out, pc_inc;

   //Decode Stage outputs
   wire [15:0] ReadData1, ReadData2, Imm, PC_cntrl_out;

   //Execute Stage outpupts
   wire [15:0] PC_out, Alu_out;
   wire c_out, zero, neg, ltz, ovf; //diff_sign, ovf, rs_sign;

   //Memory/Writeback Stage outputs
   wire [15:0] WB_out;

   wire halt;

   
   //module instantiation area
   fetch IF(.pc_in(PC_out), .clk(clk), .rst(rst), .halt(halt), //inputs  :there are none from control???
	    .inst(inst), .pc_out(pc_f_out), .pc_inc(pc_inc));  //outputs

   decode ID(.clk(clk), .rst(rst), .curr_PC(pc_f_out), .inc_PC(pc_inc), .inst(inst), .WB_out(WB_out),  //inputs
	     .RegDst(RegDst), .RegWrite(RegWrite), .PC_cntrl(PC_cntrl), .Imm_cntrl(Imm_cntrl), .Link_cntrl(Link_cntrl), .RD2_sel(ReadData2_sel), //contol inputs
	     .ReadData1(ReadData1), .ReadData2(ReadData2), .Imm(Imm), .PC_cntrl_out(PC_cntrl_out));  //outputs

   execute EX(.clk(clk), .rst(rst), .ReadData1(ReadData1), .ReadData2(ReadData2), .Imm(Imm), .PC_cntrl_out(PC_cntrl_out), //inputs
	      .AluSrc1(AluSrc1), .AluSrc2(AluSrc2), .Branch(Branch), .Jump(Jump), .AluOp(AluOp), .Cin(Cin), .inv1(inv1), .inv2(inv2), .B_sel(B_sel), .R_sel(R_sel), .shft_cntrl(shft_cntrl), .BTR_signal(BTR_signal),//control inputs
	      .PC_out(PC_out), .Alu_out(Alu_out), .c_out(c_out), .zero(zero), .neg(neg), .ltz(ltz), .ovf(ovf));//  .diff_sign(diff_sign), .ovf(ovf), .rs_sign(rs_sign));  //outputs

   memory MEMWB(.clk(clk), .rst(rst), .Addr(Alu_out), .WriteData(ReadData2), .zero(zero), .neg(neg), .c_out(c_out), .ltz(ltz), .ovf(ovf), //  .diff_sign(diff_sign), .ovf(ovf), .rs_sign(rs_sign),//inputs
	        .MemWrite(MemWrite), .MemRead(MemRead), .MemReg(MemReg), .Set_cntrl(Set_cntrl), .halt(halt),//control inputs
		.WB_out(WB_out));  //output

   control CNTRL(.inst_op(inst[15:11]), .inst_op2(inst[1:0]), //inputs
	         .RegDst(RegDst), .ReadData2_sel(ReadData2_sel), .RegWrite(RegWrite), .PC_cntrl(PC_cntrl), .Imm_cntrl(Imm_cntrl), .Link_cntrl(Link_cntrl), //decode control signals
		 .AluSrc1(AluSrc1), .AluSrc2(AluSrc2), .inv1(inv1), .inv2(inv2), .Cin(Cin), .Branch(Branch), .Jump(Jump), .AluOp(AluOp), .R_sel(R_sel), .B_sel(B_sel), .shft_cntrl(shft_cntrl), .BTR_signal(BTR_signal), //execute control signals 
	         .MemWrite(MemWrite), .MemRead(MemRead), .MemReg(MemReg), .Set_cntrl(Set_cntrl), .halt(halt));  //mem/wb control signals


endmodule // proc
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:
