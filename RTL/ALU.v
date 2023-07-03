module ALU(
input      [31:0] srcA,srcB,
input      [2:0]  ALUcntrl,
output reg [31:0] ALUrslt,
output reg        zeroflag,signflag,carryflag
);

reg [32:0] out;


always @(*)
begin
	case (ALUcntrl)
	3'b000: 
		begin
		out = srcA + srcB;
		end
	3'b001:
		begin
		out = srcA<<(srcB);
		end
 	3'b010:
		begin
		out = srcA - srcB;
		end
 	3'b100:
		begin
		out = srcA^srcB;
		end
	3'b101:
		begin
		out = srcA>>(srcB);
		end
	3'b110:
		begin
		out = srcA | srcB;
		end
	3'b111:
		begin
		out = srcA & srcB;
		end
 	default: 
		begin
		out = 0;
		end
	endcase
ALUrslt   = out[31:0]  ;

zeroflag  = ~| ALUrslt ;

carryflag = out[32]    ;

signflag  = ALUrslt[31];


end

endmodule
