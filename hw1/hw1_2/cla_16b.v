/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2
    
    a 16-bit CLA module
*/
module cla_16b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 16;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;

    // YOUR CODE HERE
    wire c_out0, c_out1, c_out2;
    cla_4b cla0(.sum(sum[3:0]), .c_out(c_out0), .a(a[3:0]), .b(b[3:0]), .c_in(c_in));
    cla_4b cla1(.sum(sum[7:4]), .c_out(c_out1), .a(a[7:4]), .b(b[7:4]), .c_in(c_out0));
    cla_4b cla2(.sum(sum[11:8]), .c_out(c_out2), .a(a[11:8]), .b(b[11:8]), .c_in(c_out1));
    cla_4b cla3(.sum(sum[15:12]), .c_out(c_out), .a(a[15:12]), .b(b[15:12]), .c_in(c_out2));
endmodule
