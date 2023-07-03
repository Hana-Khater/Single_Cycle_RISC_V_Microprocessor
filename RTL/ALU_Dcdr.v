module ALU_Dcdr(
input funct7,op5,
input [2:0] funct3,
input [1:0] ALUop,
output reg [2:0] ALUcontrol
);

always @(*)
begin

	if(ALUop == 2'b00)
		begin
		ALUcontrol = 3'b000;
		end

	else if((ALUop == 2'b01)&&(funct3 == 3'b000 || funct3 == 3'b001 || funct3 == 3'b100 ))
		begin
		ALUcontrol = 3'b010;
		end 

	else if((ALUop == 2'b10)&&(funct3 == 3'b000)&&({op5,funct7} != 2'b11))
		begin
		ALUcontrol = 3'b000;
		end
	
	else if((ALUop == 2'b10)&&(funct3 == 3'b000)&&({op5,funct7} == 2'b11))
		begin
		ALUcontrol = 3'b010;
		end

 	else if((ALUop == 2'b10)&&(funct3 != 3'b000)&&(funct3 != 3'b010)&&(funct3 != 3'b011))
		begin
		ALUcontrol = funct3;
		end 

	else
		ALUcontrol = 3'b000;


end

endmodule