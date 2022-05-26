`default_nettype none
/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2
    
    a 4-bit CLA module
*/
module cla_4b(sum, c_out, G, P, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    output wire [N-1:0] sum;
    output wire         c_out, G, P;
    input  wire [N-1:0] a, b;
    input  wire         c_in;

    // signal dec
    wire c_in1, c_in2, c_in3;
    wire p0, p1, p2, p3;
    wire g0, g1, g2, g3;

    // all carries in parallel (only use c_in + g/p from adders)
    carrylogic carryBlock(  .c_in(c_in), .c_in1(c_in1), .c_in2(c_in2), .c_in3(c_in3), .c_out(c_out),
                            .p0(p0), .p1(p1), .p2(p2), .p3(p3), 
                            .g0(g0), .g1(g1), .g2(g2), .g3(g3));

    // do the sums
    fullAdder_1b fa0( .s(sum[0]), .c_out(), .p(p0), .g(g0), .a(a[0]), .b(b[0]), .c_in(c_in));
    fullAdder_1b fa1( .s(sum[1]), .c_out(), .p(p1), .g(g1), .a(a[1]), .b(b[1]), .c_in(c_in1));
    fullAdder_1b fa2( .s(sum[2]), .c_out(), .p(p2), .g(g2), .a(a[2]), .b(b[2]), .c_in(c_in2));
    fullAdder_1b fa3( .s(sum[3]), .c_out(), .p(p3), .g(g3), .a(a[3]), .b(b[3]), .c_in(c_in3));

    assign G = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0);
    // wire t1, t2, t3;
    // and2 a1(t1, p3, g2);
    // and3 a2(t2, p3, p2, g1);
    // and4 a3(t3, p3, p2, p1, g0);
    // or4  o1(G,  g3, t1, t2, t3);

    assign P = p3 & p2 & p1 & p0;
    // and4 a4(P, p3, p2, p1, p0);

endmodule
`default_nettype wire
