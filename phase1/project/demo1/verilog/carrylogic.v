`default_nettype none
module carrylogic(c_in, c_in1, c_in2, c_in3, c_out, p0, p1, p2, p3, g0, g1, g2, g3);
    input  wire c_in, p0, p1, p2, p3, g0, g1, g2, g3;
    output wire c_in1, c_in2, c_in3, c_out;

    assign c_in1 = g0 | (p0 & c_in);
    // wire t1;
    // and2 a1(t1,    p0, c_in);
    // or2  o1(c_in1, g0, t1);

    assign c_in2 = g1 | (g0 & p1) | (p1 & p0 & c_in);
    // wire t2, t3;
    // and2 a2(t2,    g0, p1);
    // and3 a3(t3,    p1, p0, c_in);
    // or3  o2(c_in2, g1, t2, t3);

    assign c_in3 = g2 | (g1 & p2) | (g0 & p2 & p1) |(p2 & p1 & p0 & c_in);
    // wire t4, t5, t6;
    // and2 a4(t4,    g1, p2);
    // and3 a5(t5,    g0, p2, p1);
    // and4 a6(t6,    p2, p1, p0, c_in);
    // or4  o3(c_in3, g2, t4, t5, t6);

    assign c_out = g3 | (g2 & p3) | (g1 & p3 & p2) | (g0 & p3 & p2 & p1) |(p3 & p2 & p1 & p0 & c_in);
    // wire t7, t8, t9, t10;
    // and2 a7 (t7,    g2, p3);
    // and3 a8 (t8,    g1, p3, p2);
    // and4 a9 (t9,    g0, p3, p2, p1);
    // and5 a10(t10,   p3, p2, p1, p0, c_in);
    // or5  o4 (c_out, g3, t7, t8, t9, t10);

endmodule
`default_nettype wire
