/*
    CS/ECE 552 Spring '22
    Homework #2, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the 'Oper' value that is passed in.  It uses these
    shifts to shift the value any number of bits.
 */
module shifter (In, ShAmt, Oper, Out);

    // declare constant for size of inputs, outputs, and # bits to shift
    parameter OPERAND_WIDTH = 16;
    parameter SHAMT_WIDTH   =  4;
    parameter NUM_OPERATIONS = 2;

    input  [OPERAND_WIDTH -1:0] In   ; // Input operand
    input  [SHAMT_WIDTH   -1:0] ShAmt; // Amount to shift/rotate
    input  [NUM_OPERATIONS-1:0] Oper ; // Operation type
    output [OPERAND_WIDTH -1:0] Out  ; // Result of shift/rotate
    
    wire [OPERAND_WIDTH - 1:0] L_Out, R_Out;


   /* YOUR CODE HERE */
   left_shifter LShift(.In(In), .ShAmt(ShAmt), .Oper(Oper[0]), .Out(L_Out));
   right_shifter RShift(.In(In), .ShAmt(ShAmt), .Oper(Oper[0]), .Out(R_Out)); 
   
   mux2_1 out0(.out(Out[0]), .inA(L_Out[0]), .inB(R_Out[0]), .s(Oper[1]));
   mux2_1 out1(.out(Out[1]), .inA(L_Out[1]), .inB(R_Out[1]), .s(Oper[1]));   
   mux2_1 out2(.out(Out[2]), .inA(L_Out[2]), .inB(R_Out[2]), .s(Oper[1]));   
   mux2_1 out3(.out(Out[3]), .inA(L_Out[3]), .inB(R_Out[3]), .s(Oper[1]));   
   mux2_1 out4(.out(Out[4]), .inA(L_Out[4]), .inB(R_Out[4]), .s(Oper[1]));   
   mux2_1 out5(.out(Out[5]), .inA(L_Out[5]), .inB(R_Out[5]), .s(Oper[1]));   
   mux2_1 out6(.out(Out[6]), .inA(L_Out[6]), .inB(R_Out[6]), .s(Oper[1]));   
   mux2_1 out7(.out(Out[7]), .inA(L_Out[7]), .inB(R_Out[7]), .s(Oper[1]));   
   mux2_1 out8(.out(Out[8]), .inA(L_Out[8]), .inB(R_Out[8]), .s(Oper[1]));   
   mux2_1 out9(.out(Out[9]), .inA(L_Out[9]), .inB(R_Out[9]), .s(Oper[1]));   
   mux2_1 out10(.out(Out[10]), .inA(L_Out[10]), .inB(R_Out[10]), .s(Oper[1]));   
   mux2_1 out11(.out(Out[11]), .inA(L_Out[11]), .inB(R_Out[11]), .s(Oper[1]));
   mux2_1 out12(.out(Out[12]), .inA(L_Out[12]), .inB(R_Out[12]), .s(Oper[1]));
   mux2_1 out13(.out(Out[13]), .inA(L_Out[13]), .inB(R_Out[13]), .s(Oper[1]));
   mux2_1 out14(.out(Out[14]), .inA(L_Out[14]), .inB(R_Out[14]), .s(Oper[1]));
   mux2_1 out15(.out(Out[15]), .inA(L_Out[15]), .inB(R_Out[15]), .s(Oper[1]));
   
endmodule
