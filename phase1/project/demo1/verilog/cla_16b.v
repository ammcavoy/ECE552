`default_nettype none
/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 2
    
    a 16-bit CLA module
*/
module cla_16b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 16;

    output wire [N-1:0] sum;
    output wire         c_out;
    input  wire [N-1:0] a, b;
    input  wire         c_in;

    // YOUR CODE HERE
    wire C_in1, C_in2, C_in3;
    wire G0, G1, G2, G3;
    wire P0, P1, P2, P3;

    carrylogic carryBlock(  .c_in(c_in), .c_in1(C_in1), .c_in2(C_in2), .c_in3(C_in3), .c_out(c_out),
                            .p0(P0), .p1(P1), .p2(P2), .p3(P3), 
                            .g0(G0), .g1(G1), .g2(G2), .g3(G3));

    cla_4b cla0_3  ( .sum(sum[3:0]),   .c_out(),      .G(G0), .P(P0), .a(a[3:0]),   .b(b[3:0]),   .c_in(c_in) );
    cla_4b cla4_7  ( .sum(sum[7:4]),   .c_out(),      .G(G1), .P(P1), .a(a[7:4]),   .b(b[7:4]),   .c_in(C_in1) );
    cla_4b cla8_11 ( .sum(sum[11:8]),  .c_out(),      .G(G2), .P(P2), .a(a[11:8]),  .b(b[11:8]),  .c_in(C_in2) );
    cla_4b cla12_15( .sum(sum[15:12]), .c_out(c_out), .G(G3), .P(P3), .a(a[15:12]), .b(b[15:12]), .c_in(C_in3) );

endmodule
`default_nettype wire
