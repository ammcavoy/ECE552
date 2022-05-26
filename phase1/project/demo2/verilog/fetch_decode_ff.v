module fetch_decode_ff(clk, rst,
		       inst_in, pc_out_in, pc_inc_in, stall_in,
                       hazRd_in, Rd_hazP_in, hazRt_in, Rt_hazP_in, hazRs_in, Rs_hazP_in, //values used in hazard detection
		       hazRd_out, Rd_hazP_out, hazRt_out, Rt_hazP_out, hazRs_out, Rs_hazP_out,  //values that are used in hazard detection
		       inst_out, pc_out_out, pc_inc_out, stall_out);

  input clk, rst, stall_in;
  input [15:0] inst_in;
  input [15:0] pc_out_in;
  input [15:0] pc_inc_in;

  input wire [2:0] hazRd_in, hazRt_in, hazRs_in;
  input wire Rd_hazP_in, Rt_hazP_in, Rs_hazP_in;

  output wire [2:0] hazRd_out, hazRt_out, hazRs_out;
  output wire Rd_hazP_out, Rt_hazP_out, Rs_hazP_out;

  output stall_out;
  output [15:0] inst_out;
  output [15:0] pc_out_out;
  output [15:0] pc_inc_out;

  wire [15:0] inst_in_temp;
  assign inst_in_temp = (rst) ? 15'h0800 : inst_in;

  dff inst_ff   [15:0] (.q(inst_out), .d(inst_in_temp), .clk(clk), .rst(1'b0));
  dff pc_out_ff [15:0] (.q(pc_out_out), .d(pc_out_in), .clk(clk), .rst(rst));
  dff pc_inc_ff [15:0] (.q(pc_inc_out), .d(pc_inc_in), .clk(clk), .rst(rst));
 
  dff stall_ff (.q(stall_out), .d(stall_in), .clk(clk), .rst(rst));  

  //hazard detection registers
  dff hazRD_ff [2:0] (.q(hazRd_out), .d(hazRd_in), .clk(clk), .rst(rst));
  dff hazRT_ff [2:0] (.q(hazRt_out), .d(hazRt_in), .clk(clk), .rst(rst));
  dff hazRS_ff [2:0] (.q(hazRs_out), .d(hazRs_in), .clk(clk), .rst(rst));

  dff RD_hazP_ff     (.q(Rd_hazP_out), .d(Rd_hazP_in), .clk(clk), .rst(rst));
  dff RT_hazP_ff     (.q(Rt_hazP_out), .d(Rt_hazP_in), .clk(clk), .rst(rst));
  dff RS_hazP_ff     (.q(Rs_hazP_out), .d(Rs_hazP_in), .clk(clk), .rst(rst));
  
endmodule

