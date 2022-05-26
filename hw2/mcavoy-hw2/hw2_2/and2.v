/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2

    2 input AND
*/
module and2 (out,in1,in2);
    output out;
    input in1,in2;
    wire nand2;
    nand2 x(.out(nand2), .in1(in1), .in2(in2));
    not1 y(.out(out), .in1(nand2));
endmodule
