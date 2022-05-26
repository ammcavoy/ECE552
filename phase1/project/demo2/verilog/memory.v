/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (clk, rst,
	       Addr, WriteData, zero, neg, c_out, ltz, ovf, //  diff_sign, ovf, rs_sign,//inputs from the Execute and Decode stages respectively
	       MemWrite, MemRead, MemReg, Set_cntrl, halt, //inputs from the control logic
               mem_out);

   // TODO: Your code here
   input wire clk, rst;
   input wire [15:0] Addr, WriteData;
   input wire zero, neg, c_out, ltz, ovf; //diff_sign, ovf, rs_sign;
   input wire MemWrite, MemRead, MemReg, halt;
   input wire [2:0] Set_cntrl;

   output wire [15:0] mem_out;

   //wire [15:0] mem_out;
   
   wire MemReadorWrite;
   assign MemReadorWrite = MemRead | MemWrite;
   memory2c DataMem(.data_out(mem_out), .data_in(WriteData), .addr(Addr), .enable(MemReadorWrite), .wr(MemWrite), .createdump(halt), .clk(clk), .rst(rst));

   //wire [15:0] WB_temp;
   //assign WB_temp = MemReg ? mem_out : Addr;
   //assign WB_out = (Set_cntrl == 3'b000) ? WB_temp :
//	           (Set_cntrl == 3'b001) ? { 15'h0000, zero} :
//		   (Set_cntrl == 3'b010) ? { 15'h0000, ltz} :
//		   (Set_cntrl == 3'b011) ? { 15'h0000, zero | ltz } : 
//		   (Set_cntrl == 3'b100) ? { 15'h0000, c_out} :
//		   16'hxxxx;
   
endmodule
`default_nettype wire
