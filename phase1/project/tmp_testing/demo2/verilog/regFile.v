/*
   CS/ECE 552, Spring '22
   Homework #3, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module regFile (
                // Outputs
                read1Data, read2Data, err,
                // Inputs
                clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                );

   input        clk, rst;
   input [2:0]  read1RegSel;
   input [2:0]  read2RegSel;
   input [2:0]  writeRegSel;
   input [15:0] writeData;
   input        writeEn;

   output [15:0] read1Data;
   output [15:0] read2Data;
   output        err;

   /* YOUR CODE HERE */
   
   wire [7:0] one_hot_sel;

   dec3_to_8 write_dec(.in(writeRegSel), .out(one_hot_sel));

   wire w_reg0, w_reg1, w_reg2, w_reg3, w_reg4, w_reg5, w_reg6, w_reg7;

   and2 reg0_and(.out(w_reg0), .in1(one_hot_sel[0]), .in2(writeEn));
   and2 reg1_and(.out(w_reg1), .in1(one_hot_sel[1]), .in2(writeEn));
   and2 reg2_and(.out(w_reg2), .in1(one_hot_sel[2]), .in2(writeEn));
   and2 reg3_and(.out(w_reg3), .in1(one_hot_sel[3]), .in2(writeEn));
   and2 reg4_and(.out(w_reg4), .in1(one_hot_sel[4]), .in2(writeEn));
   and2 reg5_and(.out(w_reg5), .in1(one_hot_sel[5]), .in2(writeEn));
   and2 reg6_and(.out(w_reg6), .in1(one_hot_sel[6]), .in2(writeEn));
   and2 reg7_and(.out(w_reg7), .in1(one_hot_sel[7]), .in2(writeEn));  

   wire [15:0] reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q;

   reg_16b reg0(.q_16b(reg0_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg0));
   reg_16b reg1(.q_16b(reg1_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg1));
   reg_16b reg2(.q_16b(reg2_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg2));
   reg_16b reg3(.q_16b(reg3_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg3));
   reg_16b reg4(.q_16b(reg4_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg4));
   reg_16b reg5(.q_16b(reg5_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg5));
   reg_16b reg6(.q_16b(reg6_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg6));
   reg_16b reg7(.q_16b(reg7_q), .d_16b(writeData), .clk(clk), .rst(rst), .write(w_reg7));

   
   mux8_1_16b read1_mux(.out(read1Data), .in1(reg0_q), .in2(reg1_q), .in3(reg2_q), .in4(reg3_q), .in5(reg4_q), .in6(reg5_q), .in7(reg6_q), .in8(reg7_q), .s(read1RegSel));
   mux8_1_16b read2_mux(.out(read2Data), .in1(reg0_q), .in2(reg1_q), .in3(reg2_q), .in4(reg3_q), .in5(reg4_q), .in6(reg5_q), .in7(reg6_q), .in8(reg7_q), .s(read2RegSel));



endmodule
