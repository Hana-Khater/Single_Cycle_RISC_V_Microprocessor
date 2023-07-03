module Reg_File (
input clk, async_reset, WE, 
input [4:0] RA_addr, RB_addr, W_addr,
input [31:0] WD, 
output reg [31:0] RDA, RDB
);

reg[31:0] reg_array [31:0];
integer i;

always @(posedge(clk), negedge(async_reset))
begin

	if(~async_reset)
	begin

		for(i=0 ; i<32 ; i=i+1)
		begin
	        reg_array [i] <= 0;
		end
	end
	
 	else if(WE)
	begin
		reg_array[W_addr] <= WD; 
	end

end

always @(*)
begin
	RDA = reg_array[RA_addr];
        RDB = reg_array[RB_addr];
end

endmodule 