`default_nettype none
/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 2
    
    a 1-bit full adder
*/
module fullAdder_1b(s, c_out, p, g, a, b, c_in);
    output wire s;
    output wire c_out, p, g;
    input  wire a, b;
    input  wire c_in;

    // signal declaration
    // wire xorAB;
    // wire nandAB, nandCin;
    // wire norAB;

    // compute sum
    assign s = (a ^ b ^ c_in);
    // xor2 x1(xorAB, a, b);
    // xor2 x2(s, xorAB, c_in);

    // compute Cout
    assign c_out = ~( (~(a&b)) & (~((a^b)&c_in)) );
    // nand2 nd1(nandAB,  a,      b);
    // nand2 nd2(nandCin, xorAB,  c_in);
    // nand2 nd3(c_out,   nandAB, nandCin);

    // compute propagate
    assign p = a | b;
    // nor nr1(norAB, a, b);
    // not nt1(p, norAB);

    // compute generate
    assign g = a & b;
    // not nt2(g, nandAB);

endmodule
`default_nettype wire
