/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2

    2 input OR
*/
module or2 (out,in1,in2);
    output out;
    input in1,in2;
    wire nor2;
    nor2 x(.out(nor2), .in1(in1), .in2(in2));
    not1 y(.out(out), .in1(nor2));
endmodule
