/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2

    4 input NAND
*/
module nand4 (out,in1,in2,in3,in4);
    output out;
    input in1,in2,in3, in4;
    assign out = ~(in1 & in2 & in3 & in4);
endmodule
