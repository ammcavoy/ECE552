/*
   CS/ECE 552 Spring '22
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
`default_nettype none
module fetch (pc_in, clk, rst, halt, inst, pc_out, pc_inc);  
   // TODO: Your code here
   input wire [15:0] pc_in;
   input wire clk, rst, halt;
   output wire [15:0] inst, pc_out, pc_inc;
   //output wire err;   //FIGURE OUT HOW TO USE THIS SIGNAL!!!!!!!!!!!!

   //wire [15:0] pc_q;

   dff pc_b0(.q(pc_out[0]), .d(pc_in[0]), .clk(clk), .rst(rst));
   dff pc_b1(.q(pc_out[1]), .d(pc_in[1]), .clk(clk), .rst(rst));
   dff pc_b2(.q(pc_out[2]), .d(pc_in[2]), .clk(clk), .rst(rst));
   dff pc_b3(.q(pc_out[3]), .d(pc_in[3]), .clk(clk), .rst(rst));
   dff pc_b4(.q(pc_out[4]), .d(pc_in[4]), .clk(clk), .rst(rst));
   dff pc_b5(.q(pc_out[5]), .d(pc_in[5]), .clk(clk), .rst(rst));
   dff pc_b6(.q(pc_out[6]), .d(pc_in[6]), .clk(clk), .rst(rst));
   dff pc_b7(.q(pc_out[7]), .d(pc_in[7]), .clk(clk), .rst(rst));
   dff pc_b8(.q(pc_out[8]), .d(pc_in[8]), .clk(clk), .rst(rst));
   dff pc_b9(.q(pc_out[9]), .d(pc_in[9]), .clk(clk), .rst(rst));
   dff pc_b10(.q(pc_out[10]), .d(pc_in[10]), .clk(clk), .rst(rst));
   dff pc_b11(.q(pc_out[11]), .d(pc_in[11]), .clk(clk), .rst(rst));
   dff pc_b12(.q(pc_out[12]), .d(pc_in[12]), .clk(clk), .rst(rst));
   dff pc_b13(.q(pc_out[13]), .d(pc_in[13]), .clk(clk), .rst(rst));
   dff pc_b14(.q(pc_out[14]), .d(pc_in[14]), .clk(clk), .rst(rst));
   dff pc_b15(.q(pc_out[15]), .d(pc_in[15]), .clk(clk), .rst(rst));


   wire [15:0] two;
   wire cin;
   assign two = 16'h0002;
   assign cin = 1'b0;

   wire err;
   //is c_out supposed to be err??  / how do I use err in the other sections
   cla_16b adder(.sum(pc_inc), .c_out(err), .a(pc_out), .b(two), .c_in(cin));

   wire [15:0] data_in;
   wire enable, wr, createdump;
   assign data_in = 16'h0000;
   assign enable = 1'b1; //~halt; //1'b1;   //do we always want this to be on since will only be reading???
   assign wr = 1'b0; 
   assign createdump = 1'b0;   //when do we want this to be 1?????????

   memory2c read_inst(.data_out(inst), .data_in(data_in), .addr(pc_out), .enable(enable), .wr(wr), .createdump(createdump), .clk(clk), .rst(rst));



endmodule
`default_nettype wire
