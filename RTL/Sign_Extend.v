module Sign_Extend(
input [1:0] ImmSrc,
input [24:0] instr,
output reg[31:0] ImmExt
);

always @(*)
begin

case(ImmSrc)

	2'b00: ImmExt = {{20{instr[24]}}, instr[24:13]};
	2'b01: ImmExt = {{20{instr[24]}}, instr[24:18], instr[4:0]};
	2'b10: ImmExt = {{20{instr[24]}}, instr[0], instr[23:18], instr[4:1],1'b0};
	default: ImmExt = 32'd0;
endcase

end
endmodule 
