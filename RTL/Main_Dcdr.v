module Main_Dcdr(
input [6:0] opcode,
output reg Branch, ResultSrc, MemWrite, ALUSrc, RegWrite, load,
output reg [1:0] ImmSrc, ALUop
); 

always @(*)
begin
	case(opcode)
	7'b000_0011: 
	begin
		RegWrite  = 1'b1 ;
		ImmSrc    = 2'b00;
		ALUSrc    = 1'b1 ;
		MemWrite  = 1'b0 ;
		ResultSrc = 1'b1 ;
		Branch    = 1'b0 ;
		ALUop     = 2'b00;
		load      = 1'b1 ;
	end

        7'b010_0011: 
	begin
		RegWrite  = 1'b0 ;
		ImmSrc    = 2'b01;
		ALUSrc    = 1'b1 ;
		MemWrite  = 1'b1 ;
		ResultSrc = 1'b0 ;
		Branch    = 1'b0 ;
		ALUop     = 2'b00;
		load      = 1'b1 ;
	end
	
	7'b011_0011: 
	begin
		RegWrite  = 1'b1 ;
		ImmSrc    = 2'b00;
		ALUSrc    = 1'b0 ;
		MemWrite  = 1'b0 ;
		ResultSrc = 1'b0 ;
		Branch    = 1'b0 ;
		ALUop     = 2'b10;
		load      = 1'b1 ;
	end
	
	7'b001_0011: 
	begin
		RegWrite  = 1'b1 ;
		ImmSrc    = 2'b00;
		ALUSrc    = 1'b1 ;
		MemWrite  = 1'b0 ;
		ResultSrc = 1'b0 ;
		Branch    = 1'b0 ;
		ALUop     = 2'b10;
		load      = 1'b1 ;
	end

	7'b110_0011: 
	begin
		RegWrite  = 1'b0 ;
		ImmSrc    = 2'b10;
		ALUSrc    = 1'b0 ;
		MemWrite  = 1'b0 ;
		ResultSrc = 1'b0 ;
		Branch    = 1'b1 ;
		ALUop     = 2'b01;
		load      = 1'b1 ;
	end
	
	default:
	begin
		RegWrite  = 1'b0 ;
		ImmSrc    = 2'b00;
		ALUSrc    = 1'b0 ;
		MemWrite  = 1'b0 ;
		ResultSrc = 1'b0 ;
		Branch    = 1'b0 ;
		ALUop     = 2'b00;
		load      = 1'b0 ;
	end
	
	
	endcase
end

endmodule
