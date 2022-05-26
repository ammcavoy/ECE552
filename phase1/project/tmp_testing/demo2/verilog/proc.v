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
   wire ReadData2_sel, PC_cntrl, Link_cntrl;
   wire [2:0] Imm_cntrl;
   
   //decode controls from the wb state
   wire RegWrite_c, RegWrite_ex, RegWrite_mem, RegWrite_wb;
   wire [1:0] RegDst_c, RegDst_ex, RegDst_mem, RegDst_wb;

   //execute state
   wire AluSrc1_c, AluSrc2_c, Branch_c, Jump_c, Cin_c, inv1_c, inv2_c, R_sel_c, shft_cntrl_c, BTR_signal_c;
   wire [1:0] B_sel_c;
   wire [2:0] AluOp_c;

   wire AluSrc1_ex, AluSrc2_ex, Branch_ex, Jump_ex, Cin_ex, inv1_ex, inv2_ex, R_sel_ex, shft_cntrl_ex, BTR_signal_ex;
   wire [1:0] B_sel_ex;
   wire [2:0] AluOp_ex;

   //mem stage
   wire MemWrite_c, MemRead_c, MemReg_c;
   wire [2:0] Set_cntrl_c;

   wire MemWrite_ex, MemRead_ex, MemReg_ex;
   wire [2:0] Set_cntrl_ex;

   wire MemWrite_mem, MemRead_mem, MemReg_mem;
   wire [2:0] Set_cntrl_mem;
   
   //wb stage
   wire MemReg_wb;
   wire [2:0] Set_cntrl_wb;


   //Fetch Stage outputs
   wire [15:0] inst_if, pc_f_out_if, pc_inc_if;
   wire [15:0] inst_id_cntrl, pc_f_out_id, pc_inc_id;

   //Decode Stage outputs
   wire [15:0] ReadData1_id, ReadData2_id, Imm_id, PC_cntrl_out_id;
   wire [15:0] ReadData1_ex, ReadData2_ex, Imm_ex, PC_cntrl_out_ex;
   wire [15:0] ReadData2_mem;

   //Execute Stage outpupts
   wire [15:0] PC_out_ex, Alu_out_ex;
   wire c_out_ex, zero_ex, neg_ex, ltz_ex, ovf_ex;

   wire [15:0] PC_out_mem, Alu_out_mem;
   wire c_out_mem, zero_mem, neg_mem, ltz_mem, ovf_mem;
   wire c_out_wb, zero_wb, neg_wb, ltz_wb, ovf_wb;

   wire [15:0] PC_out_wb;
   wire [15:0] Addr_wb; //this is Alu_out_wb, but named Addr, dont really know why I did that. 

   //mem stage outputs
   wire [15:0] mem_out_mem;
   wire [15:0] mem_out_wb;

   //Writeback Stage outputs
   wire [15:0] WB_out;

   wire halt_c, halt_ex, halt_mem;

  
   //signals needed for the PC to bypass the pipeline 
   wire [15:0] Imm_PC,   PC_bypass_id, PC_bypass_ex;

   //Register signals used as WriteReg in the wb stage
   wire [2:0] wbRd_id, wbRd_ex, wbRd_mem, wbRd_wb,
	      wbRt_id, wbRt_ex, wbRt_mem, wbRt_wb,
	      wbRs_id, wbRs_ex, wbRs_mem, wbRs_wb;

   //Register signals that are used in hazard detection  
   wire [2:0] hazRd_if, hazRd_id, hazRd_ex, hazRd_mem, hazRd_wb,
              hazRt_if, hazRt_id, hazRt_ex, hazRt_mem, hazRt_wb,
              hazRs_if, hazRs_id, hazRs_ex, hazRs_mem, hazRs_wb;
   //signal that tell is the correcponsing hazRx value is valid, creating
   //a hazard potential with the register
   wire Rd_hazP_if, Rd_hazP_id, Rd_hazP_ex, Rd_hazP_mem, Rd_hazP_wb,
	Rt_hazP_if, Rt_hazP_id, Rt_hazP_ex, Rt_hazP_mem, Rt_hazP_wb,
	Rs_hazP_if, Rs_hazP_id, Rs_hazP_ex, Rs_hazP_mem, Rs_hazP_wb;
   wire Rd_hazP_temp, Rt_hazP_temp, Rs_hazP_temp;

   wire [2:0] RegDst_id;

   wire stall, stall_next;

   //module instantiation area
   //            was PC_out_wb if returning to old version
   fetch IF(.pc_in(PC_bypass_ex), .clk(clk), .rst(rst), .halt(halt_mem), .stall_next(stall_next), //inputs  :there are none from control???
	    .inst(inst_if), .pc_out(pc_f_out_if), .pc_inc(pc_inc_if));  //outputs

   hazard_helper HAZ_HELP(.inst(inst_if),
                          .Rs(hazRs_if), .Rt(hazRt_if), .Rd(hazRd_if), .Rs_hazP(Rs_hazP_if), .Rt_hazP(Rt_hazP_if), .Rd_hazP(Rd_hazP_if));


   hazard_detection HAZ_DET(.clk(clk), .rst(rst),
                            .hazRd_if(hazRd_if), .hazRd_id(hazRd_id), .hazRd_ex(hazRd_ex), .hazRd_mem(hazRd_mem), .hazRd_wb(hazRd_wb),
                            .hazRt_if(hazRt_if), .hazRt_id(hazRt_id), .hazRt_ex(hazRt_ex), .hazRt_mem(hazRt_mem), .hazRt_wb(hazRt_wb),
                            .hazRs_if(hazRs_if), .hazRs_id(hazRs_id), .hazRs_ex(hazRs_ex), .hazRs_mem(hazRs_mem), .hazRs_wb(hazRs_wb),
                            .Rd_hazP_if(Rd_hazP_if), .Rd_hazP_id(Rd_hazP_id), .Rd_hazP_ex(Rd_hazP_ex), .Rd_hazP_mem(Rd_hazP_mem), .Rd_hazP_wb(Rd_hazP_wb),
                            .Rt_hazP_if(Rt_hazP_if), .Rt_hazP_id(Rt_hazP_id), .Rt_hazP_ex(Rt_hazP_ex), .Rt_hazP_mem(Rt_hazP_mem), .Rt_hazP_wb(Rt_hazP_wb),
                            .Rs_hazP_if(Rs_hazP_if), .Rs_hazP_id(Rs_hazP_id), .Rs_hazP_ex(Rs_hazP_ex), .Rs_hazP_mem(Rs_hazP_mem), .Rs_hazP_wb(Rs_hazP_wb),
                            .RegDst_id(RegDst_c), .RegDst_ex(RegDst_ex), .RegDst_mem(RegDst_mem), .RegDst_wb(RegDst_wb),
                            .jump(Jump_c),
			    .stall(stall_next));

   fetch_decode_ff IF_ID(.clk(clk), .rst(rst),
                         .inst_in(inst_if), .pc_out_in(pc_f_out_if), .pc_inc_in(pc_inc_if), .stall_in(stall_next),
                         .hazRd_in(hazRd_if), .Rd_hazP_in(Rd_hazP_if), .hazRt_in(hazRt_if), .Rt_hazP_in(Rt_hazP_if), .hazRs_in(hazRs_if), .Rs_hazP_in(Rs_hazP_if),  //values that are used in hazard detection
			 .hazRd_out(hazRd_id), .Rd_hazP_out(Rd_hazP_temp), .hazRt_out(hazRt_id), .Rt_hazP_out(Rt_hazP_temp), .hazRs_out(hazRs_id), .Rs_hazP_out(Rs_hazP_temp),  //values that are used in hazard detection
			 .inst_out(inst_id_cntrl), .pc_out_out(pc_f_out_id), .pc_inc_out(pc_inc_id), .stall_out(stall));

   //signals that will be pipelined to the wb stage
   assign wbRd_id = inst_id_cntrl[4:2];
   assign wbRt_id = inst_id_cntrl[7:5];
   assign wbRs_id = inst_id_cntrl[10:8]; 

   //NEW INST_ID_CNTRL BASED ON STALL VALUE, REMOVE THE STALL SECTION ON CNTRL
   //!!!!!!!!!!
   wire [15:0] stall_inst;
   assign stall_inst = stall ? 16'h0800 : inst_id_cntrl;

   control CNTRL(.stall_needed(stall),  //useless   inst_op used to be inst_id_cntrl
	         .inst_op(stall_inst[15:11]), .inst_op2(stall_inst[1:0]), //inputs
                 .RegDst(RegDst_c), .ReadData2_sel(ReadData2_sel), .RegWrite(RegWrite_c), .PC_cntrl(PC_cntrl), .Imm_cntrl(Imm_cntrl), .Link_cntrl(Link_cntrl), //decode control signals
                 .AluSrc1(AluSrc1_c), .AluSrc2(AluSrc2_c), .inv1(inv1_c), .inv2(inv2_c), .Cin(Cin_c), .Branch(Branch_c), .Jump(Jump_c), .AluOp(AluOp_c), .R_sel(R_sel_c), .B_sel(B_sel_c), .shft_cntrl(shft_cntrl_c), .BTR_signal(BTR_signal_c), //execute control signals 
                 .MemWrite(MemWrite_c), .MemRead(MemRead_c), .MemReg(MemReg_c), .Set_cntrl(Set_cntrl_c), .halt(halt_c));  //mem/wb control signals

   


                                      //used to be _id, PC values.
				      //also used to be inst_id_cntrl not
				      //stall_inst
   decode ID(.clk(clk), .rst(rst), .curr_PC(pc_f_out_if), .inc_PC(pc_inc_if), .inst(stall_inst), .WB_out(WB_out),  //inputs
	     .Rd(wbRd_wb), .Rt(wbRt_wb), .Rs(wbRs_wb),  //register values used in the wb stage
             .RegDst(RegDst_wb), .RegWrite(RegWrite_wb), .PC_cntrl(PC_cntrl), .Imm_cntrl(Imm_cntrl), .Link_cntrl(Link_cntrl), .RD2_sel(ReadData2_sel), //contol inputs
	     .ReadData1(ReadData1_id), .ReadData2(ReadData2_id), .Imm(Imm_id), .PC_cntrl_out(PC_cntrl_out_id));  //outputs

   assign Imm_PC = Imm_id;
   assign PC_bypass_id = PC_cntrl_out_id;
   
   //mux to change the haz detection signals, so that infinite stalls are
   //avoided 
   assign Rd_hazP_id = stall ? 1'b0 : Rd_hazP_temp;
   assign Rt_hazP_id = stall ? 1'b0 : Rt_hazP_temp;
   assign Rs_hazP_id = stall ? 1'b0 : Rs_hazP_temp;


   decode_execute_ff ID_EX(.clk(clk), .rst(rst),  //ff cntrl inputs
	                   .Rd_in(wbRd_id), .Rt_in(wbRt_id), .Rs_in(wbRs_id),  //registers used for wb stage
                           .hazRd_in(hazRd_id), .Rd_hazP_in(Rd_hazP_id), .hazRt_in(hazRt_id), .Rt_hazP_in(Rt_hazP_id), .hazRs_in(hazRs_id), .Rs_hazP_in(Rs_hazP_id),  //values that are used in hazard detection
			   .ReadData1_in(ReadData1_id), .ReadData2_in(ReadData2_id), .Imm_in(Imm_id), .PC_cntrl_out_in(PC_cntrl_out_id),   //inputs
                           .AluSrc1_in(AluSrc1_c), .AluSrc2_in(AluSrc2_c), .Branch_in(Branch_c), .Jump_in(Jump_c), .AluOp_in(AluOp_c), .Cin_in(Cin_c), .inv1_in(inv1_c), .inv2_in(inv2_c), .B_sel_in(B_sel_c), .R_sel_in(R_sel_c), .shft_cntrl_in(shft_cntrl_c), .BTR_signal_in(BTR_signal_c), //EX control inputs
                           .MemWrite_in(MemWrite_c), .MemRead_in(MemRead_c), .MemReg_in(MemReg_c), .Set_cntrl_in(Set_cntrl_c), .halt_in(halt_c),//Mem control inputs
			   .RegDst_in(RegDst_c), .RegWrite_in(RegWrite_c),//reg dest inputs
			   .Rd_out(wbRd_ex), .Rt_out(wbRt_ex), .Rs_out(wbRs_ex),  //registers used for wb stage
		           .hazRd_out(hazRd_ex), .Rd_hazP_out(Rd_hazP_ex), .hazRt_out(hazRt_ex), .Rt_hazP_out(Rt_hazP_ex), .hazRs_out(hazRs_ex), .Rs_hazP_out(Rs_hazP_ex),  //values that are used in hazard detection
			   .ReadData1_out(ReadData1_ex), .ReadData2_out(ReadData2_ex), .Imm_out(Imm_ex), .PC_cntrl_out_out(PC_cntrl_out_ex),  //outputs
                           .AluSrc1_out(AluSrc1_ex), .AluSrc2_out(AluSrc2_ex), .Branch_out(Branch_ex), .Jump_out(Jump_ex), .AluOp_out(AluOp_ex), .Cin_out(Cin_ex), .inv1_out(inv1_ex), .inv2_out(inv2_ex), .B_sel_out(B_sel_ex), .R_sel_out(R_sel_ex), .shft_cntrl_out(shft_cntrl_ex), .BTR_signal_out(BTR_signal_ex),   //control outputs
		   	   .MemWrite_out(MemWrite_ex), .MemRead_out(MemRead_ex), .MemReg_out(MemReg_ex), .Set_cntrl_out(Set_cntrl_ex), .halt_out(halt_ex), //mem control outputs
                           .RegDst_out(RegDst_ex), .RegWrite_out(RegWrite_ex));  //reg dest outputs

														//was
														//PC_cntrl_out_ex,
   execute EX(.clk(clk), .rst(rst), .ReadData1(ReadData1_ex), .ReadData2(ReadData2_ex), .Imm(Imm_ex), .PC_cntrl_out(PC_bypass_id), .Imm_PC_in(Imm_PC), //inputs
	      .AluSrc1(AluSrc1_ex), .AluSrc2(AluSrc2_ex), .Branch(Branch_ex), .Jump(Jump_c), .AluOp(AluOp_ex), .Cin(Cin_ex), .inv1(inv1_ex), .inv2(inv2_ex), .B_sel(B_sel_ex), .R_sel(R_sel_ex), .shft_cntrl(shft_cntrl_ex), .BTR_signal(BTR_signal_ex),//control inputs
	      .PC_out(PC_out_ex), .Alu_out(Alu_out_ex), .c_out(c_out_ex), .zero(zero_ex), .neg(neg_ex), .ltz(ltz_ex), .ovf(ovf_ex));  //outputs

   wire [15:0] stall_pc;
   dff plz_work [15:0] (.q(stall_pc), .d(pc_f_out_if), .clk(clk), .rst(rst));
   assign PC_bypass_ex =  (stall_next) ? pc_f_out_if : PC_out_ex;
                           //maybe add & ~Jump_c ???????


   execute_memory_ff EX_MEM(.clk(clk), .rst(rst), //ff cntrl inputs
	                    .Rd_in(wbRd_ex), .Rt_in(wbRt_ex), .Rs_in(wbRs_ex),  //registers used for wb stage
                            .hazRd_in(hazRd_ex), .Rd_hazP_in(Rd_hazP_ex), .hazRt_in(hazRt_ex), .Rt_hazP_in(Rt_hazP_ex), .hazRs_in(hazRs_ex), .Rs_hazP_in(Rs_hazP_ex),  //values that are used in hazard detection
			    .Alu_out_in(Alu_out_ex), .ReadData2_in(ReadData2_ex), .c_out_in(c_out_ex), .zero_in(zero_ex), .neg_in(neg_ex), .ltz_in(ltz_ex), .ovf_in(ovf_ex),   //mem inputs
                            .MemWrite_in(MemWrite_ex), .MemRead_in(MemRead_ex), .MemReg_in(MemReg_ex), .Set_cntrl_in(Set_cntrl_ex), .halt_in(halt_ex), //mem cntrl inputs
                            .RegDst_in(RegDst_ex), .RegWrite_in(RegWrite_ex), //reg dest intputs
			    .PC_out_in(PC_out_ex),
			    .Rd_out(wbRd_mem), .Rt_out(wbRt_mem), .Rs_out(wbRs_mem),  //registers used for wb stage
			    .hazRd_out(hazRd_mem), .Rd_hazP_out(Rd_hazP_mem), .hazRt_out(hazRt_mem), .Rt_hazP_out(Rt_hazP_mem), .hazRs_out(hazRs_mem), .Rs_hazP_out(Rs_hazP_mem),  //values that are used in hazard detection
			    .Alu_out_out(Alu_out_mem), .ReadData2_out(ReadData2_mem), .c_out_out(c_out_mem), .zero_out(zero_mem), .neg_out(neg_mem), .ltz_out(ltz_mem), .ovf_out(ovf_mem),   //mem outputs                         
			    .MemWrite_out(MemWrite_mem), .MemRead_out(MemRead_mem), .MemReg_out(MemReg_mem), .Set_cntrl_out(Set_cntrl_mem), .halt_out(halt_mem), //mem cntrl output
                            .RegDst_out(RegDst_mem), .RegWrite_out(RegWrite_mem), //reg dest output
                            .PC_out_out(PC_out_mem));


   memory MEM(.clk(clk), .rst(rst), .Addr(Alu_out_mem), .WriteData(ReadData2_mem), .zero(zero_mem), .neg(neg_mem), .c_out(c_out_mem), .ltz(ltz_mem), .ovf(ovf_mem), //  .diff_sign(diff_sign), .ovf(ovf), .rs_sign(rs_sign),//inputs
	        .MemWrite(MemWrite_mem), .MemRead(MemRead_mem), .MemReg(MemReg_mem), .Set_cntrl(Set_cntrl_mem), .halt(halt_mem),//control inputs
		.mem_out(mem_out_mem));  //output

  
  memory_writeback_ff MEM_WB(.clk(clk), .rst(rst),
	                     .Rd_in(wbRd_mem), .Rt_in(wbRt_mem), .Rs_in(wbRs_mem),  //registers used for wb stage
                             .hazRd_in(hazRd_mem), .Rd_hazP_in(Rd_hazP_mem), .hazRt_in(hazRt_mem), .Rt_hazP_in(Rt_hazP_mem), .hazRs_in(hazRs_mem), .Rs_hazP_in(Rs_hazP_mem),  //values that are used in hazard detection
			     .Addr_in(Alu_out_mem), .mem_out_in(mem_out_mem), .Set_cntrl_in(Set_cntrl_mem), .MemReg_in(MemReg_mem), .zero(zero_mem), .neg(neg_mem), .c_out(c_out_mem), .ltz(ltz_mem), .ovf(ovf_mem),
                             .RegDst_in(RegDst_mem), .RegWrite_in(RegWrite_mem), //reg dset inputs 
			     .PC_out_in(PC_out_mem),
			     .Rd_out(wbRd_wb), .Rt_out(wbRt_wb), .Rs_out(wbRs_wb),  //registers used for wb stage
			     .hazRd_out(hazRd_wb), .Rd_hazP_out(Rd_hazP_wb), .hazRt_out(hazRt_wb), .Rt_hazP_out(Rt_hazP_wb), .hazRs_out(hazRs_wb), .Rs_hazP_out(Rs_hazP_wb),  //values that are used in hazard detection
			     .Addr_out(Addr_wb), .mem_out_out(mem_out_wb), .Set_cntrl_out(Set_cntrl_wb), .MemReg_out(MemReg_wb), .zero_out(zero_wb), .neg_out(neg_wb), .c_out_out(c_out_wb), .ltz_out(ltz_wb), .ovf_out(ovf_wb),
			     .RegDst_out(RegDst_wb), .RegWrite_out(RegWrite_wb), //reg dest and regWrite for wb in decode
                             .PC_out_out(PC_out_wb));

  wb WB(.clk(clk), .rst(rst), .Addr(Addr_wb), .mem_out(mem_out_wb), 
	.Set_cntrl(Set_cntrl_wb), .MemReg(MemReg_wb), .zero(zero_wb), .neg(neg_wb), .c_out(c_out_wb), .ltz(ltz_wb), .ovf(ovf_wb), 
	.WB_out(WB_out));



endmodule // proc
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:
