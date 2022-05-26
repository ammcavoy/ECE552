/*
   CS/ECE 552 Spring '22
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
`default_nettype none
module wb (clk, rst,
	   Addr, mem_out, zero, neg, c_out, ltz, ovf,  //inputs
	   Set_cntrl, MemReg, //control inputs
	   WB_out);  //outputs

   // TODO: Your code here
  input wire clk, rst;
  input wire [15:0] Addr, mem_out;
  input wire zero, neg, c_out, ltz, ovf;
  input wire MemReg;
  input wire [2:0] Set_cntrl;

  output wire [15:0] WB_out;

  wire [15:0] WB_temp;
  assign WB_temp = MemReg ? mem_out : Addr;
  assign WB_out = (Set_cntrl == 3'b000) ? WB_temp :
                   (Set_cntrl == 3'b001) ? { 15'h0000, zero} :
                   (Set_cntrl == 3'b010) ? { 15'h0000, ltz} :
                   (Set_cntrl == 3'b011) ? { 15'h0000, zero | ltz } :
                   (Set_cntrl == 3'b100) ? { 15'h0000, c_out} :
                   16'hxxxx;  

endmodule
`default_nettype wire
