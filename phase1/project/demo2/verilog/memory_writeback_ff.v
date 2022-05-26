module memory_writeback_ff(clk, rst,
	                   Addr_in, mem_out_in, Set_cntrl_in, MemReg_in, zero, neg, c_out, ltz, ovf,
			   RegDst_in, RegWrite_in,
			   PC_out_in,
			   Rd_in, Rt_in, Rs_in,     //wb register values
                           hazRd_in, Rd_hazP_in, hazRt_in, Rt_hazP_in, hazRs_in, Rs_hazP_in, //values used in hazard detection                         
			   hazRd_out, Rd_hazP_out, hazRt_out, Rt_hazP_out, hazRs_out, Rs_hazP_out,  //values that are used in hazard detection
			   Rd_out, Rt_out, Rs_out,
			   Addr_out, mem_out_out, Set_cntrl_out, MemReg_out, zero_out, neg_out, c_out_out, ltz_out, ovf_out, 
		           RegDst_out, RegWrite_out,
         	           PC_out_out);

  input wire clk, rst;
  input wire [15:0] Addr_in, mem_out_in;
  input wire MemReg_in, zero, neg, c_out, ltz, ovf;
  input wire [2:0] Set_cntrl_in;
  input wire [1:0] RegDst_in;
  input wire RegWrite_in;
  input wire [15:0] PC_out_in;

  input wire [2:0] Rd_in, Rt_in, Rs_in;
  input wire [2:0] hazRd_in, hazRt_in, hazRs_in;
  input wire Rd_hazP_in, Rt_hazP_in, Rs_hazP_in;


  output wire [2:0] Rd_out, Rt_out, Rs_out;
  output wire [2:0] hazRd_out, hazRt_out, hazRs_out;
  output wire Rd_hazP_out, Rt_hazP_out, Rs_hazP_out;

  output wire [15:0] Addr_out, mem_out_out;
  output wire MemReg_out, zero_out, neg_out, c_out_out, ltz_out, ovf_out;
  output wire [2:0] Set_cntrl_out;
  output wire [1:0] RegDst_out;
  output wire RegWrite_out;
  output wire [15:0] PC_out_out;


  dff Addr_ff [15:0] (.q(Addr_out), .d(Addr_in), .clk(clk), .rst(rst));
  dff MemO_ff [15:0] (.q(mem_out_out), .d(mem_out_in), .clk(clk), .rst(rst));
  
  dff MemR_ff (.q(MemReg_out), .d(MemReg_in), .clk(clk), .rst(rst));
  dff SetC_ff [2:0] (.q(Set_cntrl_out), .d(Set_cntrl_in), .clk(clk), .rst(rst));
  dff zero_ff (.q(zero_out), .d(zero), .clk(clk), .rst(rst));
  dff neg_ff  (.q(neg_out), .d(neg), .clk(clk), .rst(rst));
  dff cout_ff (.q(c_out_out), .d(c_out), .clk(clk), .rst(rst));
  dff ltz_ff  (.q(ltz_out), .d(ltz), .clk(clk), .rst(rst));
  dff ovf_ff  (.q(ovf_out), .d(ovf), .clk(clk), .rst(rst));
  

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

