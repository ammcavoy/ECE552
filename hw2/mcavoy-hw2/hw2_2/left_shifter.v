/*
    CS/ECE 552 Spring '22
    Homework #2, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the 'Oper' value that is passed in.  It uses these
    shifts to shift the value any number of bits.
 */
module left_shifter (In, ShAmt, Oper, Out);

    // declare constant for size of inputs, outputs, and # bits to shift
    parameter OPERAND_WIDTH = 16;
    parameter SHAMT_WIDTH   =  4;

    input  [OPERAND_WIDTH -1:0] In   ; // Input operand
    input  [SHAMT_WIDTH   -1:0] ShAmt; // Amount to shift/rotate
    input  Oper ; // Operation type
    output [OPERAND_WIDTH -1:0] Out  ; // Result of shift/rotate

    //stage one input's that can change based on Oper
    wire sr0_0;
    //stage two input's that change based on Oper
    wire sr1_0, sr1_1;
    //stage three input's that change based on Oper
    wire sr2_0, sr2_1, sr2_2, sr2_3;
    //stage four input's that change based on Oper
    wire sr3_0, sr3_1, sr3_2, sr3_3, sr3_4, sr3_5, sr3_6, sr3_7;

   

    //first stage output wire
    wire s1_0, s1_1, s1_2, s1_3, s1_4, s1_5, s1_6, s1_7, s1_8, s1_9, s1_10, s1_11, s1_12, s1_13, s1_14, s1_15;
    //second state output wires
    wire s2_0, s2_1, s2_2, s2_3, s2_4, s2_5, s2_6, s2_7, s2_8, s2_9, s2_10, s2_11, s2_12, s2_13, s2_14, s2_15;
    //third stage output wires
    wire s3_0, s3_1, s3_2, s3_3, s3_4, s3_5, s3_6, s3_7, s3_8, s3_9, s3_10, s3_11, s3_12, s3_13, s3_14, s3_15;
    //fourth stage will use Out as the output wires

    //the mux's that select wether to rotate msb to lsb, or to zero fill
    //mux for stage 0 inputs (rotate or shift by one bit)
    mux2_1 sr0_0m(.out(sr0_0), .inA(In[15]), .inB(1'b0), .s(Oper));

    //mux's for stage 1  inputs (rot or shift by two bits)
    mux2_1 sr1_0m(.out(sr1_0), .inA(s1_14), .inB(1'b0), .s(Oper));
    mux2_1 sr1_1m(.out(sr1_1), .inA(s1_15), .inB(1'b0), .s(Oper));

    //mux's for stage 2 inputs (rot or shift by four bits)
    mux2_1 sr2_0m(.out(sr2_0), .inA(s2_12), .inB(1'b0), .s(Oper));
    mux2_1 sr2_1m(.out(sr2_1), .inA(s2_13), .inB(1'b0), .s(Oper));
    mux2_1 sr2_2m(.out(sr2_2), .inA(s2_14), .inB(1'b0), .s(Oper));
    mux2_1 sr2_3m(.out(sr2_3), .inA(s2_15), .inB(1'b0), .s(Oper));

    //mux's for stage 3 inputes (rot or shift by eight bits)
    mux2_1 sr3_0m(.out(sr3_0), .inA(s3_8), .inB(1'b0), .s(Oper));
    mux2_1 sr3_1m(.out(sr3_1), .inA(s3_9), .inB(1'b0), .s(Oper));
    mux2_1 sr3_2m(.out(sr3_2), .inA(s3_10), .inB(1'b0), .s(Oper));
    mux2_1 sr3_3m(.out(sr3_3), .inA(s3_11), .inB(1'b0), .s(Oper));
    mux2_1 sr3_4m(.out(sr3_4), .inA(s3_12), .inB(1'b0), .s(Oper));
    mux2_1 sr3_5m(.out(sr3_5), .inA(s3_13), .inB(1'b0), .s(Oper));
    mux2_1 sr3_6m(.out(sr3_6), .inA(s3_14), .inB(1'b0), .s(Oper));
    mux2_1 sr3_7m(.out(sr3_7), .inA(s3_15), .inB(1'b0), .s(Oper));


    //wires for testing
    wire [15:0] s1_out, s2_out, s3_out;
    //mux's for stage 1 or the shift or rot
    mux2_1 s1_0m(.out(s1_0), .inA(In[0]), .inB(sr0_0), .s(ShAmt[0]));
    mux2_1 s1_1m(.out(s1_1), .inA(In[1]), .inB(In[0]), .s(ShAmt[0]));
    mux2_1 s1_2m(.out(s1_2), .inA(In[2]), .inB(In[1]), .s(ShAmt[0]));
    mux2_1 s1_3m(.out(s1_3), .inA(In[3]), .inB(In[2]), .s(ShAmt[0]));
    mux2_1 s1_4m(.out(s1_4), .inA(In[4]), .inB(In[3]), .s(ShAmt[0]));
    mux2_1 s1_5m(.out(s1_5), .inA(In[5]), .inB(In[4]), .s(ShAmt[0]));
    mux2_1 s1_6m(.out(s1_6), .inA(In[6]), .inB(In[5]), .s(ShAmt[0]));
    mux2_1 s1_7m(.out(s1_7), .inA(In[7]), .inB(In[6]), .s(ShAmt[0]));
    mux2_1 s1_8m(.out(s1_8), .inA(In[8]), .inB(In[7]), .s(ShAmt[0]));
    mux2_1 s1_9m(.out(s1_9), .inA(In[9]), .inB(In[8]), .s(ShAmt[0]));
    mux2_1 s1_10m(.out(s1_10), .inA(In[10]), .inB(In[9]), .s(ShAmt[0]));
    mux2_1 s1_11m(.out(s1_11), .inA(In[11]), .inB(In[10]), .s(ShAmt[0]));
    mux2_1 s1_12m(.out(s1_12), .inA(In[12]), .inB(In[11]), .s(ShAmt[0]));
    mux2_1 s1_13m(.out(s1_13), .inA(In[13]), .inB(In[12]), .s(ShAmt[0]));
    mux2_1 s1_14m(.out(s1_14), .inA(In[14]), .inB(In[13]), .s(ShAmt[0]));
    mux2_1 s1_15m(.out(s1_15), .inA(In[15]), .inB(In[14]), .s(ShAmt[0]));

    assign s1_out = {s1_15, s1_14, s1_13, s1_12, s1_11, s1_10, s1_9, s1_8, s1_7, s1_6, s1_5, s1_4, s1_3, s1_2, s1_1, s1_0};

    //mux's for stage 2 of the shift or rot 
    mux2_1 s2_0m(.out(s2_0), .inA(s1_0), .inB(sr1_0), .s(ShAmt[1]));
    mux2_1 s2_1m(.out(s2_1), .inA(s1_1), .inB(sr1_1), .s(ShAmt[1]));
    
    mux2_1 s2_2m(.out(s2_2), .inA(s1_2), .inB(s1_0), .s(ShAmt[1]));
    mux2_1 s2_3m(.out(s2_3), .inA(s1_3), .inB(s1_1), .s(ShAmt[1]));
    mux2_1 s2_4m(.out(s2_4), .inA(s1_4), .inB(s1_2), .s(ShAmt[1]));
    mux2_1 s2_5m(.out(s2_5), .inA(s1_5), .inB(s1_3), .s(ShAmt[1]));
    mux2_1 s2_6m(.out(s2_6), .inA(s1_6), .inB(s1_4), .s(ShAmt[1]));
    mux2_1 s2_7m(.out(s2_7), .inA(s1_7), .inB(s1_5), .s(ShAmt[1]));
    mux2_1 s2_8m(.out(s2_8), .inA(s1_8), .inB(s1_6), .s(ShAmt[1]));
    mux2_1 s2_9m(.out(s2_9), .inA(s1_9), .inB(s1_7), .s(ShAmt[1]));
    mux2_1 s2_10m(.out(s2_10), .inA(s1_10), .inB(s1_8), .s(ShAmt[1]));
    mux2_1 s2_11m(.out(s2_11), .inA(s1_11), .inB(s1_9), .s(ShAmt[1]));
    mux2_1 s2_12m(.out(s2_12), .inA(s1_12), .inB(s1_10), .s(ShAmt[1]));
    mux2_1 s2_13m(.out(s2_13), .inA(s1_13), .inB(s1_11), .s(ShAmt[1]));
    mux2_1 s2_14m(.out(s2_14), .inA(s1_14), .inB(s1_12), .s(ShAmt[1]));
    mux2_1 s2_15m(.out(s2_15), .inA(s1_15), .inB(s1_13), .s(ShAmt[1]));

    assign s2_out = {s2_15, s2_14, s2_13, s2_12, s2_11, s2_10, s2_9, s2_8, s2_7, s2_6, s2_5, s2_4, s2_3, s2_2, s2_1, s2_0};

    //mux's for stage 3 of the shift or rot 
    mux2_1 s3_0m(.out(s3_0), .inA(s2_0), .inB(sr2_0), .s(ShAmt[2]));
    mux2_1 s3_1m(.out(s3_1), .inA(s2_1), .inB(sr2_1), .s(ShAmt[2]));
    mux2_1 s3_2m(.out(s3_2), .inA(s2_2), .inB(sr2_2), .s(ShAmt[2]));
    mux2_1 s3_3m(.out(s3_3), .inA(s2_3), .inB(sr2_3), .s(ShAmt[2]));

    mux2_1 s3_4m(.out(s3_4), .inA(s2_4), .inB(s2_0), .s(ShAmt[2]));
    mux2_1 s3_5m(.out(s3_5), .inA(s2_5), .inB(s2_1), .s(ShAmt[2]));
    mux2_1 s3_6m(.out(s3_6), .inA(s2_6), .inB(s2_2), .s(ShAmt[2]));
    mux2_1 s3_7m(.out(s3_7), .inA(s2_7), .inB(s2_3), .s(ShAmt[2]));
    mux2_1 s3_8m(.out(s3_8), .inA(s2_8), .inB(s2_4), .s(ShAmt[2]));
    mux2_1 s3_9m(.out(s3_9), .inA(s2_9), .inB(s2_5), .s(ShAmt[2]));
    mux2_1 s3_10m(.out(s3_10), .inA(s2_10), .inB(s2_6), .s(ShAmt[2]));
    mux2_1 s3_11m(.out(s3_11), .inA(s2_11), .inB(s2_7), .s(ShAmt[2]));
    mux2_1 s3_12m(.out(s3_12), .inA(s2_12), .inB(s2_8), .s(ShAmt[2]));
    mux2_1 s3_13m(.out(s3_13), .inA(s2_13), .inB(s2_9), .s(ShAmt[2]));
    mux2_1 s3_14m(.out(s3_14), .inA(s2_14), .inB(s2_10), .s(ShAmt[2]));
    mux2_1 s3_15m(.out(s3_15), .inA(s2_15), .inB(s2_11), .s(ShAmt[2]));

    assign s3_out = {s3_15, s3_14, s3_13, s3_12, s3_11, s3_10, s3_9, s3_8, s3_7, s3_6, s3_5, s3_4, s3_3, s3_2, s3_1, s3_0};

    //mux's for stage 3 of the shift or rot 
    mux2_1 s4_0m(.out(Out[0]), .inA(s3_0), .inB(sr3_0), .s(ShAmt[3]));
    mux2_1 s4_1m(.out(Out[1]), .inA(s3_1), .inB(sr3_1), .s(ShAmt[3]));
    mux2_1 s4_2m(.out(Out[2]), .inA(s3_2), .inB(sr3_2), .s(ShAmt[3]));
    mux2_1 s4_3m(.out(Out[3]), .inA(s3_3), .inB(sr3_3), .s(ShAmt[3]));
    mux2_1 s4_4m(.out(Out[4]), .inA(s3_4), .inB(sr3_4), .s(ShAmt[3]));
    mux2_1 s4_5m(.out(Out[5]), .inA(s3_5), .inB(sr3_5), .s(ShAmt[3]));
    mux2_1 s4_6m(.out(Out[6]), .inA(s3_6), .inB(sr3_6), .s(ShAmt[3]));
    mux2_1 s4_7m(.out(Out[7]), .inA(s3_7), .inB(sr3_7), .s(ShAmt[3]));

    mux2_1 s4_8m(.out(Out[8]), .inA(s3_8), .inB(s3_0), .s(ShAmt[3]));
    mux2_1 s4_9m(.out(Out[9]), .inA(s3_9), .inB(s3_1), .s(ShAmt[3]));
    mux2_1 s4_10m(.out(Out[10]), .inA(s3_10), .inB(s3_2), .s(ShAmt[3]));
    mux2_1 s4_11m(.out(Out[11]), .inA(s3_11), .inB(s3_3), .s(ShAmt[3]));
    mux2_1 s4_12m(.out(Out[12]), .inA(s3_12), .inB(s3_4), .s(ShAmt[3]));
    mux2_1 s4_13m(.out(Out[13]), .inA(s3_13), .inB(s3_5), .s(ShAmt[3]));
    mux2_1 s4_14m(.out(Out[14]), .inA(s3_14), .inB(s3_6), .s(ShAmt[3]));
    mux2_1 s4_15m(.out(Out[15]), .inA(s3_15), .inB(s3_7), .s(ShAmt[3]));


endmodule
