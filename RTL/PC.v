module PC(
input [31:0] PCnext,
input clk,areset,load,
output reg [31:0] PC
);

always @(posedge(clk), negedge(areset))
begin

if(~areset)
PC <= 0;

else if(load)
PC <= PCnext;

end

endmodule 
