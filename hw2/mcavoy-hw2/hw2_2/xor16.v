/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2

    2 input NOR
*/
module xor16 (out,in1,in2);
    parameter   N = 16;

    output [N-1:0] out;
    input [N-1: 0] in1, in2;

    xor2 xorb0(.out(out[0]), .in1(in1[0]), .in2(in2[0]));
    xor2 xorb1(.out(out[1]), .in1(in1[1]), .in2(in2[1]));
    xor2 xorb2(.out(out[2]), .in1(in1[2]), .in2(in2[2]));
    xor2 xorb3(.out(out[3]), .in1(in1[3]), .in2(in2[3]));
    xor2 xorb4(.out(out[4]), .in1(in1[4]), .in2(in2[4]));
    xor2 xorb5(.out(out[5]), .in1(in1[5]), .in2(in2[5]));
    xor2 xorb6(.out(out[6]), .in1(in1[6]), .in2(in2[6]));
    xor2 xorb7(.out(out[7]), .in1(in1[7]), .in2(in2[7]));
    xor2 xorb8(.out(out[8]), .in1(in1[8]), .in2(in2[8]));
    xor2 xorb9(.out(out[9]), .in1(in1[9]), .in2(in2[9]));
    xor2 xorb10(.out(out[10]), .in1(in1[10]), .in2(in2[10]));
    xor2 xorb11(.out(out[11]), .in1(in1[11]), .in2(in2[11]));
    xor2 xorb12(.out(out[12]), .in1(in1[12]), .in2(in2[12]));
    xor2 xorb13(.out(out[13]), .in1(in1[13]), .in2(in2[13]));
    xor2 xorb14(.out(out[14]), .in1(in1[14]), .in2(in2[14]));
    xor2 xorb15(.out(out[15]), .in1(in1[15]), .in2(in2[15]));

endmodule
