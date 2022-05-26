module decode_execute_ff(clk, rst,  //ff cntrl inputs
      			 ReadData1_in, ReadData2_in, Imm_in, PC_cntrl_out_in,	//inputs
			 AluSrc1_in, AluSrc2_in, Branch_in, Jump_in, AluOp_in, Cin_in, inv1_in, inv2_in, B_sel_in, R_sel_in, shft_cntrl_in, BTR_signal_in, // EX control input
			 MemWrite_in, MemRead_in, MemReg_in, Set_cntrl_in, halt_in, //mem cntrl inputs
			 RegDst_in, RegWrite_in, //wb control inputs
			 Rd_in, Rt_in, Rs_in,     //wb register values
			 hazRd_in, Rd_hazP_in, hazRt_in, Rt_hazP_in, hazRs_in, Rs_hazP_in, //values used in hazard detection
			 hazRd_out, Rd_hazP_out, hazRt_out, Rt_hazP_out, hazRs_out, Rs_hazP_out,  //values that are used in hazard detection
			 Rd_out, Rt_out, Rs_out,  //wb register values
			 ReadData1_out, ReadData2_out, Imm_out, PC_cntrl_out_out,   //outputs
                         AluSrc1_out, AluSrc2_out, Branch_out, Jump_out, AluOp_out, Cin_out, inv1_out, inv2_out, B_sel_out, R_sel_out, shft_cntrl_out, BTR_signal_out,  //Ex control outputs
		         MemWrite_out, MemRead_out, MemReg_out, Set_cntrl_out, halt_out,
		         RegDst_out, RegWrite_out);  // memcontrol outputs


  input wire clk, rst;  //ff cntrl inputs
  input wire [15:0] ReadData1_in, ReadData2_in, Imm_in, PC_cntrl_out_in;  //inputs
  input wire AluSrc1_in, AluSrc2_in, Branch_in, Jump_in, Cin_in, inv1_in, inv2_in, R_sel_in, shft_cntrl_in, BTR_signal_in;  //control inputs
  input wire [1:0] B_sel_in;
  input wire [2:0] AluOp_in;
  //mem control inputs
  input wire MemWrite_in, MemRead_in, MemReg_in, halt_in;
  input wire [2:0] Set_cntrl_in;
  //wb control inputs
  input wire [1:0] RegDst_in;
  input wire RegWrite_in;

  input wire [2:0] Rd_in, Rt_in, Rs_in;
  input wire [2:0] hazRd_in, hazRt_in, hazRs_in;
  input wire Rd_hazP_in, Rt_hazP_in, Rs_hazP_in;

  output wire [2:0] Rd_out, Rt_out, Rs_out;
  output wire [2:0] hazRd_out, hazRt_out, hazRs_out;
  output wire Rd_hazP_out, Rt_hazP_out, Rs_hazP_out;

  output wire [15:0] ReadData1_out, ReadData2_out, Imm_out, PC_cntrl_out_out;  //outputs
  output wire AluSrc1_out, AluSrc2_out, Branch_out, Jump_out, Cin_out, inv1_out, inv2_out, R_sel_out, shft_cntrl_out, BTR_signal_out;  //control outputs
  output wire [1:0] B_sel_out;
  output wire [2:0] AluOp_out;
  //mem control outputs
  output wire MemWrite_out, MemRead_out, MemReg_out, halt_out;
  output wire [2:0] Set_cntrl_out;
  //wb control outputs
  output wire [1:0] RegDst_out;
  output wire RegWrite_out;


  dff RD1_ff [15:0] (.q(ReadData1_out), .d(ReadData1_in), .clk(clk), .rst(rst));
  dff RD2_ff [15:0] (.q(ReadData2_out), .d(ReadData2_in), .clk(clk), .rst(rst));
  dff Imm_ff [15:0] (.q(Imm_out), .d(Imm_in), .clk(clk), .rst(rst));
  dff PC_ff  [15:0] (.q(PC_cntrl_out_out), .d(PC_cntrl_out_in), .clk(clk), .rst(rst));

  dff Alu1_ff   (.q(AluSrc1_out), .d(AluSrc1_in), .clk(clk), .rst(rst));
  dff Alu2_ff   (.q(AluSrc2_out), .d(AluSrc2_in), .clk(clk), .rst(rst));
  dff Branch_ff (.q(Branch_out), .d(Branch_in), .clk(clk), .rst(rst));
  dff Jump_ff   (.q(Jump_out), .d(Jump_in), .clk(clk), .rst(rst));
  dff Cin_ff    (.q(Cin_out), .d(Cin_in), .clk(clk), .rst(rst));
  dff inv1_ff   (.q(inv1_out), .d(inv1_in), .clk(clk), .rst(rst));
  dff inv2_ff   (.q(inv2_out), .d(inv2_in), .clk(clk), .rst(rst));
  dff Rsel_ff   (.q(R_sel_out), .d(R_sel_in), .clk(clk), .rst(rst));
  dff shft_ff   (.q(shft_cntrl_out), .d(shft_cntrl_in), .clk(clk), .rst(rst));
  dff BTR_ff    (.q(BTR_signal_out), .d(BTR_signal_in), .clk(clk), .rst(rst));

  dff B_sel_ff [1:0] (.q(B_sel_out), .d(B_sel_in), .clk(clk), .rst(rst));
  dff AluOp_ff [2:0] (.q(AluOp_out), .d(AluOp_in), .clk(clk), .rst(rst));
  
  //mem control signals
  dff halt_ff   (.q(halt_out), .d(halt_in), .clk(clk), .rst(rst));
  dff MemW_ff   (.q(MemWrite_out), .d(MemWrite_in), .clk(clk), .rst(rst));
  dff MemR_ff   (.q(MemRead_out), .d(MemRead_in), .clk(clk), .rst(rst));
  dff MemReg_ff (.q(MemReg_out), .d(MemReg_in), .clk(clk), .rst(rst));

  dff cntrl_ff [2:0] (.q(Set_cntrl_out), .d(Set_cntrl_in), .clk(clk), .rst(rst));

  //wb control signals 
  dff RDst_ff [1:0] (.q(RegDst_out), .d(RegDst_in), .clk(clk), .rst(rst));
  dff RWrite_ff     (.q(RegWrite_out), .d(RegWrite_in), .clk(clk), .rst(rst));

  //wb registers
  dff RD_ff [2:0] (.q(Rd_out), .d(Rd_in), .clk(clk), .rst(rst));
  dff RT_ff [2:0] (.q(Rt_out), .d(Rt_in), .clk(clk), .rst(rst));
  dff RS_ff [2:0] (.q(Rs_out), .d(Rs_in), .clk(clk), .rst(rst));

  //hazard detection registers
  dff hazRD_ff [2:0] (.q(hazRd_out), .d(hazRd_in), .clk(clk), .rst(rst));
  dff hazRT_ff [2:0] (.q(hazRt_out), .d(hazRt_in), .clk(clk), .rst(rst));
  dff hazRS_ff [2:0] (.q(hazRs_out), .d(hazRs_in), .clk(clk), .rst(rst));

  dff RD_hazP_ff     (.q(Rd_hazP_out), .d(Rd_hazP_in), .clk(clk), .rst(rst));
  dff RT_hazP_ff     (.q(Rt_hazP_out), .d(Rt_hazP_in), .clk(clk), .rst(rst));
  dff RS_hazP_ff     (.q(Rs_hazP_out), .d(Rs_hazP_in), .clk(clk), .rst(rst));
  
endmodule
