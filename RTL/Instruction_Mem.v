module Instruction_Mem(
input  [31:0] A,
output [31:0] RD
);

reg [31:0] ROM [63:0];

assign RD = ROM [A[31:2]];


initial 
begin
$readmemh("P.txt",ROM,0);
end

endmodule 
