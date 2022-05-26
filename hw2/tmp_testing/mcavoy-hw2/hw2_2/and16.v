/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2

    16 input AND
*/
module and16 (out,in1,in2);
    parameter   N = 16;

    output [N-1:0] out;
    input [N-1: 0] in1, in2;
    
    and2 andb0(.out(out[0]), .in1(in1[0]), .in2(in2[0]));
    and2 andb1(.out(out[1]), .in1(in1[1]), .in2(in2[1]));
    and2 andb2(.out(out[2]), .in1(in1[2]), .in2(in2[2]));
    and2 andb3(.out(out[3]), .in1(in1[3]), .in2(in2[3]));
    and2 andb4(.out(out[4]), .in1(in1[4]), .in2(in2[4]));
    and2 andb5(.out(out[5]), .in1(in1[5]), .in2(in2[5]));
    and2 andb6(.out(out[6]), .in1(in1[6]), .in2(in2[6]));
    and2 andb7(.out(out[7]), .in1(in1[7]), .in2(in2[7]));
    and2 andb8(.out(out[8]), .in1(in1[8]), .in2(in2[8]));
    and2 andb9(.out(out[9]), .in1(in1[9]), .in2(in2[9]));
    and2 andb10(.out(out[10]), .in1(in1[10]), .in2(in2[10]));
    and2 andb11(.out(out[11]), .in1(in1[11]), .in2(in2[11]));
    and2 andb12(.out(out[12]), .in1(in1[12]), .in2(in2[12]));
    and2 andb13(.out(out[13]), .in1(in1[13]), .in2(in2[13]));
    and2 andb14(.out(out[14]), .in1(in1[14]), .in2(in2[14]));
    and2 andb15(.out(out[15]), .in1(in1[15]), .in2(in2[15]));

endmodule
