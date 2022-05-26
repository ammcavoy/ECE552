/*
    CS/ECE 552 Spring '22
    Homework #1, Problem 1

    a 16-bit 8-1 Mux template
*/
module mux8_1_16b(out, in1, in2, in3, in4, in5, in6, in7, in8, s);

    // parameter N for length of inputs and outputs (to use with larger inputs/outputs)
    parameter N = 16;

    output [N-1:0]  out;
    input [N-1:0]   in1, in2, in3, in4, in5, in6, in7, in8;
    input [2:0]     s;


    assign out = (s == 3'b000) ? in1 :
	         (s == 3'b001) ? in2 :
		 (s == 3'b010) ? in3 :
		 (s == 3'b011) ? in4 :
		 (s == 3'b100) ? in5 :
		 (s == 3'b101) ? in6 :
		 (s == 3'b110) ? in7 :
		 (s == 3'b111) ? in8 :
		 16'b0000000000000000;


endmodule
