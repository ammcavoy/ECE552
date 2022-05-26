module control(inst_op, inst_op2,
               RegDst, ReadData2_sel, RegWrite, PC_cntrl, Imm_cntrl, Link_cntrl,
	       AluSrc1, AluSrc2, inv1, inv2, Cin, Branch, Jump, AluOp, R_sel, B_sel, shft_cntrl, BTR_signal,
	       MemWrite, MemRead, MemReg, Set_cntrl, halt);

  input [4:0] inst_op;    //OP Code from instruction fetch
  input [1:0] inst_op2;

  //control signals used by the decode stage
  output reg [1:0] RegDst;
  output reg ReadData2_sel;
  output reg RegWrite;
  output reg PC_cntrl;
  output reg [2:0] Imm_cntrl;  //NEEED TO FIGURE THIS BAD BOY OUT
  output reg Link_cntrl;
  
  //control signals used by the execute stage
  output reg AluSrc1;
  output reg AluSrc2;
  output reg Branch;
  output reg Jump;
  output reg Cin;
  output reg inv1;
  output reg inv2;
  output reg [2:0] AluOp;
  output reg R_sel;
  output reg [1:0] B_sel;
  output reg shft_cntrl;
  output reg BTR_signal;

  //control signals used by the write stage
  output reg MemWrite;
  output reg MemRead;
  output reg MemReg;
  output reg [2:0] Set_cntrl;

  output reg halt;


  wire [6:0] full_inst;
  assign full_inst = {inst_op, inst_op2};

  always @(full_inst)
  begin
    //default Decode will write to Rd/inst[4:2], incement the pc by 2, and write the WB signal from the Memory/Execute blocks
    RegDst   = 2'b00;
    ReadData2_sel  = 1'b0;
    RegWrite = 1'b1;
    PC_cntrl = 1'b0;
    Link_cntrl = 1'b0;
    //IMM_cntrl      no default value for this, since it'll need to be different almost every time in use?????????


    //default Execute will use RD1 and RD2 in the ALU, and not branch or jump
    AluSrc1 = 1'b0;
    AluSrc2 = 1'b0;
    Branch  = 1'b0;
    Jump    = 1'b0;
    Cin     = 1'b0;
    inv1    = 1'b0;
    inv2    = 1'b0;
    AluOp   = 3'b100;   //maybe do the Add as default value?????? also need to update
    //the ALU unit itself #yay
    R_sel = 1'b0;
    //no default for B_sel don't think its neeeded for anything????
    //^ was wrong 
    B_sel = 2'b00;
    shft_cntrl = 1'b0;
    BTR_signal = 1'b0;

    //default memory will not  write to memory, and the WB will be the
    //ALU output
    MemWrite = 1'b0;
    MemRead  = 1'b0;
    MemReg   = 1'b0;
    Set_cntrl = 3'b000;

    halt = 1'b0;
    casex(full_inst)
      

	    //come back to these bad boys and think very hard about them
      7'b00000xx: //halt
        begin
          halt = 1'b1;
	  PC_cntrl = 1'b1;
	  RegWrite = 1'b0;
        end
      7'b00001xx: //nop
        begin
          RegWrite = 1'b0;
        end
      
      7'b01000xx: //ADDI
        begin
	  RegDst = 2'b01;
	  Imm_cntrl = 3'b000;
	  AluSrc2 = 1'b1;
        end
      7'b01001xx: //SUBI
        begin
          RegDst = 2'b01;
	  Imm_cntrl = 3'b000;
	  AluSrc2 = 1'b1;
	  //ALU OP FOR SUB!!
	  Cin = 1'b1;
	  inv1 = 1'b1;  // Imm - Rs
        end
      7'b01010xx: //XORI
        begin
          RegDst = 2'b01;
          Imm_cntrl = 3'b001;
          AluSrc2 = 1'b1;
	  //ALU OP FOR XOR!!!
	  AluOp = 3'b111;
        end
      7'b01011xx: //ANDNI
        begin
          RegDst = 2'b01;
          Imm_cntrl = 3'b001;
          AluSrc2 = 1'b1;
	  inv2 = 1'b1;
	  AluOp = 3'b101;
        end
      7'b10100xx: //ROLI
        begin
          RegDst = 2'b01;
          Imm_cntrl = 3'b001;
          AluSrc2 = 1'b1;
	  AluOp = 3'b000;
        end
      7'b10101xx: //SLLI
        begin
          RegDst = 2'b01;
          Imm_cntrl = 3'b001;
          AluSrc2 = 1'b1;
          AluOp = 3'b001;
        end
      7'b10110xx: //RORI
        begin
          RegDst = 2'b01;
          Imm_cntrl = 3'b001;
          AluSrc2 = 1'b1;
          AluOp = 3'b010;
        end
      7'b10111xx: //SRLI
        begin
          RegDst = 2'b01;
          Imm_cntrl = 3'b001;
          AluSrc2 = 1'b1;
          AluOp = 3'b011;
        end
      7'b10000xx: //ST
        begin
          RegWrite = 1'b0;
	  Imm_cntrl = 3'b000;
	  AluSrc2 = 1'b1;
          MemWrite = 1'b1;
        end
      7'b10001xx: //LD
        begin
	  RegDst = 2'b01;
          Imm_cntrl = 3'b000;
	  AluSrc2 = 1'b1;
	  MemRead = 1'b1;
	  MemReg = 1'b1;
        end
      7'b10011xx: //STU
        begin
          RegDst = 2'b10;
	  Imm_cntrl = 3'b000;
	  AluSrc2 = 1'b1;
	  MemWrite = 1'b1;
        end
      7'b11001xx: //BTR
        begin
	  BTR_signal = 1'b1;
          //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	  //I am confused on what to do with that bad boy
        end
      7'b1101100: //ADD
        begin
          AluOp = 3'b100;
        end
      7'b1101101: //SUB
        begin
          Cin = 1'b1;
	  inv1 = 1'b1; //Rt - Rs
        end
      7'b1101110: //XOR
        begin
          AluOp = 3'b111;
        end
      7'b1101111: //ANDN
        begin
          AluOp = 3'b101;
	  inv2 = 1'b1; //Rs & ~Rt
        end
      7'b1101000: // ROL 
        begin
	  AluOp = 3'b000;
        end
      7'b1101001: // SLL
        begin
          AluOp = 3'b001;
        end
      7'b1101010: // ROR
        begin
          AluOp = 3'b010;
        end
      7'b1101011: // SRL
        begin
          AluOp = 3'b011;
        end
	

	
	// perform Rs-Rt, load Rd with zero value from ALU
      7'b11100xx: //SEQ
        begin
          Cin = 1'b1;
	  inv2 = 1'b1;
	  //NEW CNTRL Signal to load RD <- zero !!!!!!!!!!!!!!!!!
	  Set_cntrl = 3'b001;
        end
	//perform Rs-Rt, load Rd with neg value from ALU
      7'b11101xx: //SLT
        begin
          Cin = 1'b1;
	  inv2 = 1'b1;
	  //NEW control signal to load Rd <- neg !!!!!!!!!!!!!!!
          Set_cntrl = 3'b010;
        end
	//perfomr Rs-Rt, load Rd with zero|neg value from ALU
      7'b11110xx: //SLE
        begin
          Cin = 1'b1;
	  inv2 = 1'b1;
	  //new control signal to load Rd <- zero|neg !!!!!!!!!!!!
	  Set_cntrl = 3'b011;
        end
	//perform Rs+Rt, load Rd with C_out val from ALU
      7'b11111xx: //SCO
        begin
          //new control signal to load Rd <- c_out !!!!!!!!!!!!!!!!
	  Set_cntrl = 3'b100;
        end
	//perform Rs&Rs, use zero value from ALU to determine branch
      7'b01100xx: //BEQZ
        begin
          Branch = 1'b1;
	  ReadData2_sel = 1'b1;
	  Imm_cntrl = 3'b010;
	  AluOp = 3'b101;
          //new control to take the branch if (zero)
	  B_sel = 2'b00;
	  RegWrite = 1'b0;
        end
	//perform Rs&Rs, use ~zero value from ALU to determine branch
      7'b01101xx: //BNEZ
        begin
          Branch = 1'b1;
	  ReadData2_sel = 1'b1;
	  Imm_cntrl = 3'b010;
	  AluOp = 3'b101;
	  //new control signal to take the branch if (!zero)
	  B_sel = 2'b01;
          RegWrite = 1'b0;
        end
	//perform Rs&Rs, use zero and neg val from ALu to determine branch
      7'b01110xx: //BLTZ
        begin
          Branch = 1'b1;
	  ReadData2_sel = 1'b1;
	  Imm_cntrl = 3'b010;
	  AluOp = 3'b101;
	  //new control signal to take the branch if (neg)
	  B_sel = 2'b10;
	  RegWrite = 1'b0;
        end
	//perform Rs&RS, use zero and neg for branch
      7'b01111xx: //BGEZ
        begin
          Branch = 1'b1;
	  ReadData2_sel = 1'b1;
	  Imm_cntrl = 3'b010;
	  AluOp = 3'b101;
	  //new control signal to take branch if (!neg | zero)
	  B_sel = 2'b11;
	  RegWrite = 1'b0;
        end
	//perform 
      7'b11000xx: //LBI
        begin
	  RegDst = 2'b10;
	  shft_cntrl = 1'b1;
	  Imm_cntrl = 3'b010;
	  AluSrc1 = 1'b1;
	  AluSrc2 = 1'b1;
	  //dont really know how to make this bad boy work as of rn
          //maybe add a mux to the ALU in1 shifting RD1 to 0, or hardcode 0
        end
      7'b10010xx: //SLBI
        begin
          RegDst = 2'b10;
	  Imm_cntrl = 3'b011;
	  AluSrc1 = 1'b1;
	  AluSrc2 = 1'b1;
	  AluOp = 3'b110;
        end
      7'b00100xx: //J
        begin
          Jump = 1'b1;
	  Imm_cntrl = 3'b100;
	  RegWrite = 1'b0;
        end
      7'b00101xx: //JR
        begin
	  AluSrc2 = 1'b1;
          Jump = 1'b1;
	  Imm_cntrl = 3'b010;
          //This is where the additional possible PC value in the mux comes
	  //from that is going to be added, as well as another signal to
	  //indicate to take that option, maybe same signal used in branches
	  R_sel = 1'b1;
	  RegWrite = 1'b0;
        end
      7'b00110xx: //JAL
        begin
          Jump = 1'b1;
          RegDst = 2'b11;
	  Imm_cntrl = 3'b100;
	  Link_cntrl = 1'b1;
        end
      7'b00111xx: //JALR
        begin
          AluSrc2 = 1'b1;
	  Jump = 1'b1;
          RegDst = 2'b11;
	  Imm_cntrl = 3'b010;
	  Link_cntrl = 1'b1;
	  //this will need to use the same new logic for the JR inst
          R_sel = 1'b1;
        end
      7'b00010xx: //siic RS
        begin

        end
      7'b00011xx: //NOP / RTI
        begin

        end
      default:
        begin
          //err = 1'b1; //should never get here. Unknown op code
        end
    endcase
  end
endmodule
