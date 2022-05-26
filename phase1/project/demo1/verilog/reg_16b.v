/*
   CS/ECE 552, Spring '22
   homework #3, Problem #1
  
   This module creates an 16-bit register.

*/
module reg_16b (q_16b, d_16b, clk, rst, write);

    parameter N = 16;
    output [N - 1:0] q_16b;
    input [N -1:0] d_16b;
    input clk, rst, write;
    
    wire new_clk, not_clk2, new_clk2;

    //not1 nclk(.out(not_clk2), .in1(clk));
    
    wire [15:0] write_d;
    assign write_d = write ? d_16b : q_16b;
    //assign new_clk = rst ? clk : (clk & write);
    //assign new_clk2 = rst ? not_clk : (not_clk & write);

    //wire [15:0] temp_q;

    //genvar i;
    //generate
    //    for(i=0; i<N; i=i+1) begin: dffs_16
            //dff flop(.q(temp_q[i]), .d(d_16b[i]), .clk(new_clk), .rst(rst));
    //    end
    //endgenerate
    
    dff flop0(.q(q_16b[0]), .d(write_d[0]), .clk(clk), .rst(rst));
    dff flop1(.q(q_16b[1]), .d(write_d[1]), .clk(clk), .rst(rst));
    dff flop2(.q(q_16b[2]), .d(write_d[2]), .clk(clk), .rst(rst));
    dff flop3(.q(q_16b[3]), .d(write_d[3]), .clk(clk), .rst(rst));
    dff flop4(.q(q_16b[4]), .d(write_d[4]), .clk(clk), .rst(rst));
    dff flop5(.q(q_16b[5]), .d(write_d[5]), .clk(clk), .rst(rst));
    dff flop6(.q(q_16b[6]), .d(write_d[6]), .clk(clk), .rst(rst));
    dff flop7(.q(q_16b[7]), .d(write_d[7]), .clk(clk), .rst(rst));
    dff flop8(.q(q_16b[8]), .d(write_d[8]), .clk(clk), .rst(rst));
    dff flop9(.q(q_16b[9]), .d(write_d[9]), .clk(clk), .rst(rst));
    dff flop10(.q(q_16b[10]), .d(write_d[10]), .clk(clk), .rst(rst));
    dff flop11(.q(q_16b[11]), .d(write_d[11]), .clk(clk), .rst(rst));
    dff flop12(.q(q_16b[12]), .d(write_d[12]), .clk(clk), .rst(rst));
    dff flop13(.q(q_16b[13]), .d(write_d[13]), .clk(clk), .rst(rst));
    dff flop14(.q(q_16b[14]), .d(write_d[14]), .clk(clk), .rst(rst));
    dff flop15(.q(q_16b[15]), .d(write_d[15]), .clk(clk), .rst(rst));


    //dff neg_flop0(.q(q_16b[0]), .d(temp_q[0]), .clk(not_clk2), .rst(rst));
    //dff neg_flop1(.q(q_16b[1]), .d(temp_q[1]), .clk(not_clk2), .rst(rst));
    //dff neg_flop2(.q(q_16b[2]), .d(temp_q[2]), .clk(not_clk2), .rst(rst));
    //dff neg_flop3(.q(q_16b[3]), .d(temp_q[3]), .clk(not_clk2), .rst(rst));
    //dff neg_flop4(.q(q_16b[4]), .d(temp_q[4]), .clk(not_clk2), .rst(rst));
    //dff neg_flop5(.q(q_16b[5]), .d(temp_q[5]), .clk(not_clk2), .rst(rst));
    //dff neg_flop6(.q(q_16b[6]), .d(temp_q[6]), .clk(not_clk2), .rst(rst));
    //dff neg_flop7(.q(q_16b[7]), .d(temp_q[7]), .clk(not_clk2), .rst(rst));
    //dff neg_flop8(.q(q_16b[8]), .d(temp_q[8]), .clk(not_clk2), .rst(rst));
    //dff neg_flop9(.q(q_16b[9]), .d(temp_q[9]), .clk(not_clk2), .rst(rst));
    //dff neg_flop10(.q(q_16b[10]), .d(temp_q[10]), .clk(not_clk2), .rst(rst));
    //dff neg_flop11(.q(q_16b[11]), .d(temp_q[11]), .clk(not_clk2), .rst(rst));
    //dff neg_flop12(.q(q_16b[12]), .d(temp_q[12]), .clk(not_clk2), .rst(rst));
    //dff neg_flop13(.q(q_16b[13]), .d(temp_q[13]), .clk(not_clk2), .rst(rst));
    //dff neg_flop14(.q(q_16b[14]), .d(temp_q[14]), .clk(not_clk2), .rst(rst));
    //dff neg_flop15(.q(q_16b[15]), .d(temp_q[15]), .clk(not_clk2), .rst(rst));

    //always @(posedge clk) begin
        //q_16b <= temp_q;
    //end
	    
endmodule
