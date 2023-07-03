module Data_Mem(
input clk,WE,
input [31:0] WD,A,
output [31:0] RD
);

reg [31:0] Data_Memory [63:0];

always @(posedge(clk))
begin

	if(WE)
	Data_Memory[A[31:2]] <= WD ;

end

assign RD = Data_Memory[A[31:2]] ;

endmodule
