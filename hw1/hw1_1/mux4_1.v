/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 1

    4-1 mux template
*/
module mux4_1(out, inA, inB, inC, inD, s);
    output       out;
    input        inA, inB, inC, inD;
    input [1:0]  s;

    // YOUR CODE HERE
    wire out;
    //reg inA, inB, inC, inD;
    //reg [1:0] s;
    wire upper0mux, upper1mux;

    mux2_1 UPPER0MUX(.out(upper0mux), .inA(inA), .inB(inB), .s(s[0]));
    mux2_1 UPPER1MUX(.out(upper1mux), .inA(inC), .inB(inD), .s(s[0]));
    mux2_1 OUTMUX(.out(out), .inA(upper0mux), .inB(upper1mux), .s(s[1]));    
endmodule
