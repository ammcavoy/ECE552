/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 2
    
    a 1-bit full adder
*/
module fullAdder_1b(s, c_out, a, b, c_in);
    output s;
    output c_out;
    input   a, b;
    input  c_in;

    // YOUR CODE HERE
    wire s, c_out;
    wire AnandB, AxorB, AxBnandC;
    xor2 AxorB_gate(.out(AxorB), .in1(a), .in2(b));
    xor2 Sxor(.out(s), .in1(AxorB), .in2(c_in));

    nand2 Anandb_gate(.out(AnandB), .in1(a), .in2(b));
    nand2 AxBnandC_gate(.out(AxBnandC), .in1(AxorB), .in2(c_in));
    nand2 Coutnand(.out(c_out), .in1(AxBnandC), .in2(AnandB));

endmodule
