module hazard_helper(inst,
                     Rs, Rt, Rd, Rs_hazP, Rt_hazP, Rd_hazP);

  input [15:0] inst;

  //signals that will be used to determine hazards
  output reg [2:0] Rs, Rt, Rd;
  output reg Rs_hazP, Rt_hazP, Rd_hazP;

  always @(inst)
  begin
    //Defaults
    Rs = 3'b000;
    Rs_hazP = 1'b0;
    Rt = 3'b000;
    Rt_hazP = 1'b0;
    Rd = 3'b000;
    Rd_hazP = 1'b0;
    casex(inst[15:11])
      5'b000xx: //HALT, NOP, SIIC, NOP/RTI
        begin
        end

      5'b010xx: //ADDI, SUBI, XORI, ANDNI
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          //was Rd
	  Rt = inst[7:5]; 
          Rt_hazP = 1'b1;
        end

      5'b101xx: //ROLI, SLLI, RORI, SRLI
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          //were Rd, debugging stall signals
	  Rt = inst[7:5];
          Rt_hazP = 1'b1;
        end

      5'b1101x: //ADD, SUB, XOR, ANDN, ROL, SLL, ROR, SRL
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          Rt = inst[7:5];
          Rt_hazP = 1'b1;
          Rd = inst[4:2];
          Rd_hazP = 1'b1;
        end

      5'b111xx: //SEQ, SLT, SLE, SCO
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          Rt = inst[7:5];
          Rt_hazP = 1'b1;
          Rd = inst[4:2];
          Rd_hazP = 1'b1;
        end

      5'b11001: // BTR
        begin
          Rs = inst[10:8];
	  Rs_hazP = 1'b1;
          Rd = inst[4:2];
          Rd_hazP = 1'b1;
        end

      5'b01100: //BEQZ, BNEZ, BLTZ, BGEZ
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
        end

      5'b11000: //LBI
        begin
	  //was Rd before, might need to change with other cases' as well!!!!
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
        end

      5'b10010: //SLBI
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          Rd = inst[10:8];
          Rd_hazP = 1'b1;
        end

      5'b1000x: //ST, LD
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          Rt = inst[7:5];
          Rt_hazP = 1'b1;
          Rd = inst[7:5];
          Rd_hazP = 1'b1;
        end

      5'b10011: //STU
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          Rt = inst[7:5];
          Rt_hazP = 1'b1;
          Rd = inst[10:8];
          Rd_hazP = 1'b1;
        end

      5'b00100: //J
        begin
        end
      5'b00101: //JR
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
        end
      5'b00110: //JAL
        begin
          Rd = 3'b111;
          Rd_hazP = 1'b1;
          Rt = 3'b111;
          Rt_hazP = 1'b1;
        end
      5'b00111: //JALR
        begin
          Rs = inst[10:8];
          Rs_hazP = 1'b1;
          Rd = 3'b111;
          Rd_hazP = 1'b1;
          Rt = 3'b111;
          Rt_hazP = 1'b1;
        end
      default:
        begin
          //AHHHHHHHHHHHHHHHHHHHHH WHAT TO DO
        end
    endcase
  end
endmodule
