/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2
    
    a 4-bit CLA module
*/
module cla_4b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;

    // YOUR CODE HERE
    wire notp0, p0, notg0, g0, notp1, p1, notg1, g1, notp2, p2, notg2, g2;
    wire c1in, notc1in, c1in_1, notc1in_1; 
    wire c2in, notc2in, c2in_1, notc2in_1, c2in_2, notc2in_2; 
    wire c3in, notc3i, c3in_1, notc3in_1, c3in_2, notc3in_2, c3in_3, notc3in_3;
    wire c_out_dummy;

    //propagate and generate signals for bits 1-3
    nor2 notp0_g(.out(notp0), .in1(a[0]), .in2(b[0]));
    not1 p0_g(.out(p0), .in1(notp0));
    nand2 notg0_g(.out(notg0), .in1(a[0]), .in2(b[0]));
    not1 g0_g(.out(g0), .in1(notg0));

    nor2 notp1_g(.out(notp1), .in1(a[1]), .in2(b[1]));
    not1 p1_g(.out(p1), .in1(notp1));
    nand2 notg1_g(.out(notg1), .in1(a[1]), .in2(b[1]));
    not1 g1_g(.out(g1), .in1(notg1));

    nor2 notp2_g(.out(notp2), .in1(a[2]), .in2(b[2]));
    not1 p2_g(.out(p2), .in1(notp2));
    nand2 notg2_g(.out(notg2), .in1(a[2]), .in2(b[2]));
    not1 g2_g(.out(g2), .in1(notg2));

    //carry in signals for adder1
    nand2 notc1in_1_g(.out(notc1in_1), .in1(p0), .in2(c_in));
    not1 c1in_1_g(.out(c1in_1), .in1(notc1in_1));
    nor2 notc1in_g(.out(notc1in), .in1(c1in_1), .in2(g0));
    not1 c1in_g(.out(c1in), .in1(notc1in));

    //carry in signals for adder2
    nand2 notc2in_1_g(.out(notc2in_1), .in1(p1), .in2(g0));
    not1 c2in_1_g(.out(c2in_1), .in1(notc2in_1));
    nand3 notc2in_2_g(.out(notc2in_2), .in1(p1), .in2(p0), .in3(c_in));
    not1 c2in_2_g(.out(c2in_2), .in1(notc2in_2));
    nor3 notc2in_g(.out(notc2in), .in1(c2in_1), .in2(c2in_2), .in3(g1));
    not1 c2in_g(.out(c2in), .in1(notc2in));

    //carry in signals for adder3
    nand2 notc3in_1_g(.out(notc3in_1), .in1(p2), .in2(g1));
    not1 c3in_1_g(.out(c3in_1), .in1(notc3in_1));
    nand3 notc3in_2_g(.out(notc3in_2), .in1(p2), .in2(p1), .in3(g0));
    not1 c3in_2_g(.out(c3in_2), .in1(notc3in_2));
    nand4 notc3in_3_g(.out(notc3_in), .in1(p2), .in2(p1), .in3(p0), .in4(c_in));
    not1 c3in_3_g(.out(c3in_3), .in1(notc3in_3));
    nor4 notc3in_g(.out(notc3in), .in1(c3in_1), .in2(c3in_2), .in3(c3in_3), .in4(g2));
    not1 c3in_g(.out(c3in), .in1(notc3in));

    //adder blocks
    fullAdder_1b bit0(.s(sum[0]), .c_out(c1_in), .a(a[0]), .b(b[0]), .c_in(c_in));
    fullAdder_1b bit1(.s(sum[1]), .c_out(c2_in), .a(a[1]), .b(b[1]), .c_in(c1_in));
    fullAdder_1b bit2(.s(sum[2]), .c_out(c3_in), .a(a[2]), .b(b[2]), .c_in(c2_in));
    fullAdder_1b bit3(.s(sum[3]), .c_out(c_out), .a(a[3]), .b(b[3]), .c_in(c3_in));

endmodule
