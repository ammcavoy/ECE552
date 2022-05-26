/*
    CS/ECE 552 Spring '22
    Homework #2, Problem 2

    A multi-bit ALU module (defaults to 16-bit). It is designed to choose
    the correct operation to perform on 2 multi-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the multi-bit result
    of the operation, as well as drive the output signals Zero and Overflow
    (OFL).
*/
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl);

    parameter OPERAND_WIDTH = 16;    
    parameter NUM_OPERATIONS = 3;
       
    input  [OPERAND_WIDTH -1:0] InA ; // Input operand A
    input  [OPERAND_WIDTH -1:0] InB ; // Input operand B
    input                       Cin ; // Carry in
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    input                       invA; // Signal to invert A
    input                       invB; // Signal to invert B
    input                       sign; // Signal for signed operation
    output [OPERAND_WIDTH -1:0] Out ; // Result of computation
    output                      Ofl ; // Signal if overflow occured
    output                      Zero; // Signal if Out is 0

    /* YOUR CODE HERE */
    wire [15:0] AandB, AorB, AxorB, AsumB, Ashift, newA, newB, out_0b1, out_0b2, out_1b;
    wire Cout;

    //invert the input signals if inv signal high
    assign newA = (invA) ? ~InA : InA;
    assign newB = (invB) ? ~InB : InB;

    //all the operations being perfomed
    shifter_hier shifter(.In(newA), .ShAmt(newB[3:0]), .Oper(Oper[1:0]), .Out(Ashift));
    cla_16b adder(.sum(AsumB), .c_out(Cout), .a(newA), .b(newB), .c_in(Cin));
    and16 and16b(.out(AandB), .in1(newA), .in2(newB));
    or16 or16b(.out(AorB), .in1(newA), .in2(newB));
    xor16 xo16b(.out(AxorB), .in1(newA), .in2(newB));

    //choose the correct value for Out based on Oper
    assign out_0b1 = (Oper[0]) ? AandB : AsumB;
    assign out_0b2 = (Oper[0]) ? AxorB : AorB;
    assign out_1b = (Oper[1]) ? out_0b2 : out_0b1;
    assign Out =  (Oper[2]) ? out_1b : Ashift;
    
    assign Zero = ~|Out;

    assign Ofl = (Oper != 3'b100) ? 1'b0 :
	         (sign) ? ((Out[15] & ~newA[15] & ~newB[15]) | (~Out[15] & newA[15] & newB[15])) : Cout;  


endmodule
