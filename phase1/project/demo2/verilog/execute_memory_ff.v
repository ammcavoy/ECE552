module execute_memory_ff(clk, rst, //ff cntrl inputs
			 Alu_out_in, ReadData2_in, c_out_in, zero_in, neg_in, ltz_in, ovf_in,   //mem inputs
			 MemWrite_in, MemRead_in, MemReg_in, Set_cntrl_in, halt_in, //mem cntrl inputs
			 RegDst_in, RegWrite_in,
			 PC_out_in,
			 Rd_in, Rt_in, Rs_in,     //wb register values
			 hazRd_in, Rd_hazP_in, hazRt_in, Rt_hazP_in, hazRs_in, Rs_hazP_in, //values used in hazard detection                         
			 hazRd_out, Rd_hazP_out, hazRt_out, Rt_hazP_out, hazRs_out, Rs_hazP_out,  //values that are used in hazard detection
                         Rd_out, Rt_out, Rs_out,
			 Alu_out_out, ReadData2_out, c_out_out, zero_out, neg_out, ltz_out, ovf_out,   //mem outputs
                         MemWrite_out, MemRead_out, MemReg_out, Set_cntrl_out, halt_out, //mem cntrl output
                         RegDst_out, RegWrite_out,
			 PC_out_out);

  input wire clk, rst;  
  input wire [15:0] Alu_out_in, ReadData2_in;
  input wire c_out_in, zero_in, neg_in, ltz_in, ovf_in;
  input wire MemWrite_in, MemRead_in, MemReg_in, halt_in;
  input wire [2:0] Set_cntrl_in;
  //wb signals
  input wire [1:0] RegDst_in;
  input wire RegWrite_in;
  //pc
  input wire [15:0] PC_out_in;

  input wire [2:0] Rd_in, Rt_in, Rs_in;
  input wire [2:0] hazRd_in, hazRt_in, hazRs_in;
  input wire Rd_hazP_in, Rt_hazP_in, Rs_hazP_in;


  output wire [2:0] Rd_out, Rt_out, Rs_out;
  output wire [2:0] hazRd_out, hazRt_out, hazRs_out;
  output wire Rd_hazP_out, Rt_hazP_out, Rs_hazP_out;

  output wire [15:0] Alu_out_out, ReadData2_out;
  output wire c_out_out, zero_out, neg_out, ltz_out, ovf_out;
  output wire MemWrite_out, MemRead_out, MemReg_out, halt_out;
  output wire [2:0] Set_cntrl_out;
  //wb signals
  output wire [1:0] RegDst_out;
  output wire RegWrite_out;
  //pc
  output wire [15:0] PC_out_out;


  dff alu_ff [15:0] (.q(Alu_out_out), .d(Alu_out_in), .clk(clk), .rst(rst));
  dff RD2_ff [15:0] (.q(ReadData2_out), .d(ReadData2_in), .clk(clk), .rst(rst));
  
  dff cout_ff   (.q(c_out_out), .d(c_out_in), .clk(clk), .rst(rst));
  dff zero_ff   (.q(zero_out), .d(zero_in), .clk(clk), .rst(rst));
  dff n3t_ff    (.q(neg_out), .d(neg_in), .clk(clk), .rst(rst));
  dff ltz_ff    (.q(ltz_out), .d(ltz_in), .clk(clk), .rst(rst));
  dff ovf_ff    (.q(ovf_out), .d(ovf_in), .clk(clk), .rst(rst));
  dff halt_ff   (.q(halt_out), .d(halt_in), .clk(clk), .rst(rst));
  dff MemW_ff   (.q(MemWrite_out), .d(MemWrite_in), .clk(clk), .rst(rst));
  dff MemR_ff   (.q(MemRead_out), .d(MemRead_in), .clk(clk), .rst(rst));
  dff MemReg_ff (.q(MemReg_out), .d(MemReg_in), .clk(clk), .rst(rst));
  

  dff cntrl_ff [2:0] (.q(Set_cntrl_out), .d(Set_cntrl_in), .clk(clk), .rst(rst));

  //wb control signals 
  dff RDst_ff [1:0] (.q(RegDst_out), .d(RegDst_in), .clk(clk), .rst(rst));
  dff RWrite_ff     (.q(RegWrite_out), .d(RegWrite_in), .clk(clk), .rst(rst));

  //pc 
  dff PC_ff [15:0] (.q(PC_out_out), .d(PC_out_in), .clk(clk), .rst(rst));

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
