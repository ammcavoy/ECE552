module fullAdder_1b_bench;
    reg A;
    reg B;
    reg c_in;
    wire s;
    wire C_out;

    wire clk;
    //2 dummy wires
    wire rst;
    wire err;

    clkrst my_clkrst(.clk(clk), .rst(rst), .err(err));
    fullAdder_1b DUT(.s(s), .c_out(C_out), .a(A), .b(B), .c_in(c_in));

    initial begin
        @(negedge clk) begin
	    A = 1'b0;
	    B = 1'b0;
	    c_in = 1'b0;
	end
	@(posedge clk) begin
	    if(s !== 1'b0) $display("ERRORCHECK Sum error! A=0, B=0, Cin=0");
	    if(C_out !== 1'b0) $display("ERRORCHECK Cout error! A=0, B=0, Cin=0");
	end
        @(negedge clk) begin
            A = 1'b0;
            B = 1'b1;
            c_in = 1'b0;
        end 
        @(posedge clk) begin
            if(s !== 1'b1) $display("ERRORCHECK Sum error! A=0, B=1, Cin=0");
            if(C_out !== 1'b0) $display("ERRORCHECK Cout error! A=0, B=1, Cin=0");
        end 
        @(negedge clk) begin
            A = 1'b1;
            B = 1'b0;
            c_in = 1'b0;
        end 
        @(posedge clk) begin
            if(s !== 1'b1) $display("ERRORCHECK Sum error! A=1, B=0, Cin=0");
            if(C_out !== 1'b0) $display("ERRORCHECK Cout error! A=1, B=0, Cin=0");
        end 
        @(negedge clk) begin
            A = 1'b1;
            B = 1'b1;
            c_in = 1'b0;
        end
        @(posedge clk) begin
            if(s !== 1'b0) $display("ERRORCHECK Sum error! A=1, B=1, Cin=0");
            if(C_out !== 1'b1) $display("ERRORCHECK Cout error! A=1, B=1, Cin=0");
        end
        @(negedge clk) begin
            A = 1'b0;
            B = 1'b0;
            c_in = 1'b1;
        end 
        @(posedge clk) begin
            if(s !== 1'b1) $display("ERRORCHECK Sum error! A=0, B=0, Cin=1");
            if(C_out !== 1'b0) $display("ERRORCHECK Cout error! A=0, B=0, Cin=1");
        end 
        @(negedge clk) begin
            A = 1'b0;
            B = 1'b1;
            c_in = 1'b1;
        end 
        @(posedge clk) begin
            if(s !== 1'b0) $display("ERRORCHECK Sum error! A=0, B=1, Cin=1");
            if(C_out !== 1'b1) $display("ERRORCHECK Cout error! A=0, B=1, Cin=1");
        end 
        @(negedge clk) begin
            A = 1'b1;
            B = 1'b0;
            c_in = 1'b1;
        end 
        @(posedge clk) begin
            if(s !== 1'b0) $display("ERRORCHECK Sum error! A=1, B=0, Cin=1");
            if(C_out !== 1'b1) $display("ERRORCHECK Cout error! A=1, B=0, Cin=1");
        end 
        @(negedge clk) begin
            A = 1'b1;
            B = 1'b1;
            c_in = 1'b1;
        end 
        @(posedge clk) begin
            if(s !== 1'b1) $display("ERRORCHECK Sum error! A=1, B=1, Cin=1");
            if(C_out !== 1'b1) $display("ERRORCHECK Cout error! A=1, B=1, Cin=1");
        end 
        $display("YAHOOO, passed all cases!!");
	$finish;
    end
endmodule
