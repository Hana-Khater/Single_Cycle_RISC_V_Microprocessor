module CU(
input [6:0] op,
input [2:0] funct3,
input funct7,zero,sign,
output reg  PCSrc,
output ResultSrc, MemWrite, ALUSrc, RegWrite, load,
output [2:0] ALUcontrol, 
output [1:0] ImmSrc
);

wire Branch;
wire [1:0] ALUop;
wire beq, bnq, blt;

Main_Dcdr main_dcdr(
.opcode(op) , .Branch(Branch) , 
.ResultSrc(ResultSrc) , .MemWrite(MemWrite) , 
.ALUSrc(ALUSrc) , .RegWrite(RegWrite) , 
.load(load) , .ImmSrc(ImmSrc) , .ALUop(ALUop)
);

ALU_Dcdr alu_dcdr(
.funct7(funct7) , .op5(op[5]),
.funct3(funct3),
.ALUop(ALUop),
.ALUcontrol(ALUcontrol)
);

assign beq = zero    & Branch   ;
assign bnq = (~zero) & Branch   ;
assign blt = sign    & Branch   ; 

always @(*)
begin
	case(funct3)
	3'b000: PCSrc  = beq ;
	3'b001: PCSrc  = bnq ;
	3'b100: PCSrc  = blt ;
   	default: PCSrc = 1'b0;
	endcase
end

endmodule