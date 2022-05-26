module hazard_detection(clk, rst,
	                hazRd_if, hazRd_id, hazRd_ex, hazRd_mem, hazRd_wb,
                        hazRt_if, hazRt_id, hazRt_ex, hazRt_mem, hazRt_wb,
                        hazRs_if, hazRs_id, hazRs_ex, hazRs_mem, hazRs_wb,
                        Rd_hazP_if, Rd_hazP_id, Rd_hazP_ex, Rd_hazP_mem, Rd_hazP_wb,
                        Rt_hazP_if, Rt_hazP_id, Rt_hazP_ex, Rt_hazP_mem, Rt_hazP_wb,
                        Rs_hazP_if, Rs_hazP_id, Rs_hazP_ex, Rs_hazP_mem, Rs_hazP_wb,
	                RegDst_id, RegDst_ex, RegDst_mem, RegDst_wb,
			jump,
			stall);
  //most of these wont be used, but they might be needed in forwarding??????
  //or am i crazy
  //I think im crazy theses are useless but they are here
  input wire [2:0] hazRd_if, hazRd_id, hazRd_ex, hazRd_mem, hazRd_wb,  //signals containing the Rs, Rt, and Rd registers from each stage
                   hazRt_if, hazRt_id, hazRt_ex, hazRt_mem, hazRt_wb,
                   hazRs_if, hazRs_id, hazRs_ex, hazRs_mem, hazRs_wb;
	 
  input wire Rd_hazP_if, Rd_hazP_id, Rd_hazP_ex, Rd_hazP_mem, Rd_hazP_wb,  //signals specifiying if the register at its stage is valid, and a hazard potental
             Rt_hazP_if, Rt_hazP_id, Rt_hazP_ex, Rt_hazP_mem, Rt_hazP_wb,
             Rs_hazP_if, Rs_hazP_id, Rs_hazP_ex, Rs_hazP_mem, Rs_hazP_wb;

  input wire [1:0] RegDst_id, RegDst_ex, RegDst_mem, RegDst_wb;
  input wire clk, rst, jump;

  output wire stall;


  wire [2:0] trueRd_id, trueRd_ex, trueRd_mem, trueRd_wb;
  wire trueRd_hazP_id, trueRd_hazP_ex, trueRd_hazP_mem, trueRd_hazP_wb;

  //what was this thought process?????? dummy
  //wire [1:0] RegDst_wb2;

  //dff WORK [1:0] (.q(RegDst_wb2), .d(RegDst_wb), .clk(clk), .rst(rst));


  assign trueRd_id = (RegDst_id == 2'b00) ? hazRd_id : //Rd
                      (RegDst_id == 2'b01) ? hazRt_id : //Rt
                      (RegDst_id == 2'b10) ? hazRs_id : //Rs
                      (RegDst_id == 2'b11) ? 3'b111 :  //R7
                      3'bxxx;

  assign trueRd_ex = (RegDst_ex == 2'b00) ? hazRd_ex : //Rd
                      (RegDst_ex == 2'b01) ? hazRt_ex : //Rt
                      (RegDst_ex == 2'b10) ? hazRs_ex : //Rs
                      (RegDst_ex == 2'b11) ? 3'b111 :  //R7
                      3'bxxx;

  assign trueRd_mem = (RegDst_mem == 2'b00) ? hazRd_mem : //Rd
                      (RegDst_mem == 2'b01) ? hazRt_mem : //Rt
                      (RegDst_mem == 2'b10) ? hazRs_mem : //Rs
                      (RegDst_mem == 2'b11) ? 3'b111 :  //R7
                      3'bxxx;

  assign trueRd_wb = (RegDst_wb == 2'b00) ? hazRd_wb : //Rd
                      (RegDst_wb == 2'b01) ? hazRt_wb : //Rt
                      (RegDst_wb == 2'b10) ? hazRs_wb : //Rs
                      (RegDst_wb == 2'b11) ? 3'b111 :  //R7
                      3'bxxx;

  assign trueRd_hazP_id = (RegDst_id == 2'b00) ? Rd_hazP_id : //Rd
                          (RegDst_id == 2'b01) ? Rt_hazP_id : //Rt
                          (RegDst_id == 2'b10) ? Rs_hazP_id : //Rs
                          (RegDst_id == 2'b11) ? 1'b1 :  //R7
                           3'bxxx;


  assign trueRd_hazP_ex = (RegDst_ex == 2'b00) ? Rd_hazP_ex : //Rd
                          (RegDst_ex == 2'b01) ? Rt_hazP_ex : //Rt
                          (RegDst_ex == 2'b10) ? Rs_hazP_ex : //Rs
                          (RegDst_ex == 2'b11) ? 1'b1 :  //R7
                           3'bxxx;

  assign trueRd_hazP_mem = (RegDst_mem == 2'b00) ? Rd_hazP_mem : //Rd
                          (RegDst_mem == 2'b01) ? Rt_hazP_mem : //Rt
                          (RegDst_mem == 2'b10) ? Rs_hazP_mem : //Rs
                          (RegDst_mem == 2'b11) ? 1'b1 :  //R7
                           3'bxxx;

  assign trueRd_hazP_wb = (RegDst_wb == 2'b00) ? Rd_hazP_wb : //Rd
                          (RegDst_wb == 2'b01) ? Rt_hazP_wb : //Rt
                          (RegDst_wb == 2'b10) ? Rs_hazP_wb : //Rs
                          (RegDst_wb == 2'b11) ? 1'b1 :  //R7
                           3'bxxx;



  assign stall = ( (Rt_hazP_if & trueRd_hazP_id & (hazRt_if == trueRd_id))
                 | (Rs_hazP_if & trueRd_hazP_id & (hazRs_if == trueRd_id))
	         | (Rt_hazP_if & trueRd_hazP_ex & (hazRt_if == trueRd_ex))
                 | (Rs_hazP_if & trueRd_hazP_ex & (hazRs_if == trueRd_ex))
		 | (Rt_hazP_if & trueRd_hazP_mem & (hazRt_if == trueRd_mem))
		 | (Rs_hazP_if & trueRd_hazP_mem & (hazRs_if == trueRd_mem))
		 | jump);
		 // | (Rt_hazP_if & trueRd_hazP_wb & (hazRt_if == trueRd_wb))
                 // | (Rs_hazP_if & trueRd_hazP_wb & (hazRs_if == trueRd_wb)));





endmodule
