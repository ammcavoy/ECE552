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

    not1 nclk(.out(not_clk2), .in1(clk));
    
    assign new_clk = rst ? clk : (clk & write);
    //assign new_clk2 = rst ? not_clk : (not_clk & write);

    wire [15:0] temp_q;

    //genvar i;
    //generate
    //    for(i=0; i<N; i=i+1) begin: dffs_16
            //dff flop(.q(temp_q[i]), .d(d_16b[i]), .clk(new_clk), .rst(rst));
    //    end
    //endgenerate
    
    dff flop0(.q(q_16b[0]), .d(d_16b[0]), .clk(new_clk), .rst(rst));
    dff flop1(.q(q_16b[1]), .d(d_16b[1]), .clk(new_clk), .rst(rst));
    dff flop2(.q(q_16b[2]), .d(d_16b[2]), .clk(new_clk), .rst(rst));
    dff flop3(.q(q_16b[3]), .d(d_16b[3]), .clk(new_clk), .rst(rst));
    dff flop4(.q(q_16b[4]), .d(d_16b[4]), .clk(new_clk), .rst(rst));
    dff flop5(.q(q_16b[5]), .d(d_16b[5]), .clk(new_clk), .rst(rst));
    dff flop6(.q(q_16b[6]), .d(d_16b[6]), .clk(new_clk), .rst(rst));
    dff flop7(.q(q_16b[7]), .d(d_16b[7]), .clk(new_clk), .rst(rst));
    dff flop8(.q(q_16b[8]), .d(d_16b[8]), .clk(new_clk), .rst(rst));
    dff flop9(.q(q_16b[9]), .d(d_16b[9]), .clk(new_clk), .rst(rst));
    dff flop10(.q(q_16b[10]), .d(d_16b[10]), .clk(new_clk), .rst(rst));
    dff flop11(.q(q_16b[11]), .d(d_16b[11]), .clk(new_clk), .rst(rst));
    dff flop12(.q(q_16b[12]), .d(d_16b[12]), .clk(new_clk), .rst(rst));
    dff flop13(.q(q_16b[13]), .d(d_16b[13]), .clk(new_clk), .rst(rst));
    dff flop14(.q(q_16b[14]), .d(d_16b[14]), .clk(new_clk), .rst(rst));
    dff flop15(.q(q_16b[15]), .d(d_16b[15]), .clk(new_clk), .rst(rst));


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
