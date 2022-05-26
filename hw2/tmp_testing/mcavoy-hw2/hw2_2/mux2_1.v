/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 1

    2-1 mux template
*/
module mux2_1(out, inA, inB, s);
    output  out;
    input   inA, inB;
    input   s;

    // YOUR CODE HERE
    //reg clk, rst;
    //reg err;
    //clkrst CR(.clk(clk), .rst(rst), .err(err));
    //do I even need this code right now ^ ??????????????????/

    //reg inA, inB;
    //reg s, 
    wire not_s;
    wire AnandNotS, BnandS;
    wire out;


    not1 NOTS(.out(not_s), .in1(s));
    nand2 NAND1(.out(AnandNotS), .in1(inA), .in2(not_s));    
    nand2 NAND2(.out(BnandS), .in1(inB), .in2(s));
    nand2 NAND3(.out(out), .in1(AnandNotS), .in2(BnandS));
    
endmodule
