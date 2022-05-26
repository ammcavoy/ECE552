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
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl, Neg, Cout);

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
    output 			Neg;
    output 			Cout;

    /* YOUR CODE HERE */
    wire [15:0] newA, newB, ArotL, AshftL, ArotR, AshftR, AsumB, AandB, AorB, AxorB;
    wire Cout, Neg, Ofl;

    //invert the input signals if inv signal high
    assign newA = (invA) ? ~InA : InA;
    assign newB = (invB) ? ~InB : InB;

    //all the operations being perfomed
    //shifter_hier shifter(.In(newA), .ShAmt(newB[3:0]), .Oper(Oper[1:0]), .Out(Ashift));
    
    //barrell shifter for Left Rotate
    wire [15:0] tmpLR[2:0];
    assign tmpLR[2] = newB[3] ? { newA[7:0], newA[15:8] } : newA;
    assign tmpLR[1] = newB[2] ? { tmpLR[2][11:0], tmpLR[2][15:12] } : tmpLR[2];
    assign tmpLR[0] = newB[1] ? { tmpLR[1][13:0], tmpLR[1][15:14] } : tmpLR[1];
    assign ArotL  = newB[0] ? { tmpLR[0][14:0], tmpLR[0][15] } : tmpLR[0];

    //barrell shifter for Left shfit
    wire [15:0] tmpLS[2:0];
    assign tmpLS[2] = newB[3] ? { newA[7:0], 8'h00 } : newA;
    assign tmpLS[1] = newB[2] ? { tmpLS[2][11:0], 4'h0 } : tmpLS[2];
    assign tmpLS[0] = newB[1] ? { tmpLS[1][13:0], 2'b00 } : tmpLS[1];
    assign AshftL  = newB[0] ? { tmpLS[0][14:0], 1'b0 } : tmpLS[0];

    //barrell shifter for Right Rotate
    wire [15:0] tmpRR[2:0];
    assign tmpRR[2] = newB[3] ? { newA[7:0], newA[15:8] } : newA;
    assign tmpRR[1] = newB[2] ? { tmpRR[2][3:0], tmpRR[2][15:4] } : tmpRR[2];
    assign tmpRR[0] = newB[1] ? { tmpRR[1][1:0], tmpRR[1][15:2] } : tmpRR[1];
    assign ArotR  = newB[0] ? { tmpRR[0][0], tmpRR[0][15:1] } : tmpRR[0];

    //barrell shifter for Right Shift
    wire [15:0] tmpRS[2:0];
    assign tmpRS[2] = newB[3] ? { 8'h00, newA[15:8] } : newA;
    assign tmpRS[1] = newB[2] ? { 4'h0, tmpRS[2][15:4] } : tmpRS[2];
    assign tmpRS[0] = newB[1] ? { 2'b00, tmpRS[1][15:2] } : tmpRS[1];
    assign AshftR  = newB[0] ? { 1'b0, tmpRS[0][15:1] } : tmpRS[0];

    cla_16b adder(.sum(AsumB), .c_out(Cout), .a(newA), .b(newB), .c_in(Cin));
    
    assign AandB = newA & newB;
    assign AorB = newA | newB;
    assign AxorB = newA ^ newB;
   
    
    assign Out = (Oper == 3'b000) ? ArotL :
	         (Oper == 3'b001) ? AshftL :
	         (Oper == 3'b010) ? ArotR :
	         (Oper == 3'b011) ? AshftR :
	         (Oper == 3'b100) ? AsumB :
	         (Oper == 3'b101) ? AandB :
	         (Oper == 3'b110) ? AorB :
	         (Oper == 3'b111) ? AxorB:
		 16'h0000;


    //and16 and16b(.out(AandB), .in1(newA), .in2(newB));
    //or16 or16b(.out(AorB), .in1(newA), .in2(newB));
    //xor16 xo16b(.out(AxorB), .in1(newA), .in2(newB));

    //choose the correct value for Out based on Oper
    //assign out_0b1 = (Oper[0]) ? AandB : AsumB;
    //assign out_0b2 = (Oper[0]) ? AxorB : AorB;
    //assign out_1b = (Oper[1]) ? out_0b2 : out_0b1;
    //assign Out =  (Oper[2]) ? out_1b : Ashift;
    
    assign Zero = ~|Out;
    assign Neg = Out[15];

    assign Ofl = (Oper != 3'b100) ? 1'b0 :
	         (sign) ? ((Out[15] & ~newA[15] & ~newB[15]) | (~Out[15] & newA[15] & newB[15])) : Cout;  


endmodule
