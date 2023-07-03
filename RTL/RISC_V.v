module  RISC_V(
input clk,areset
);

wire [31:0] instr;

// Control Unit Signals 
wire [6:0] op; 
wire [2:0] funct3; 
wire funct7 ,zero,sign, load;
wire  PCSrc;
wire ResultSrc, MemWrite, ALUSrc, RegWrite;
wire [2:0] ALUcontrol; 
wire [1:0] ImmSrc;

// Control Unit Instantiation
CU Cntrl_Unit (.op(instr[6:0]), .funct3(instr[14:12]), .funct7(instr[30]), .zero(zero), .sign(sign),
.PCSrc(PCSrc), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), 
.load(load), .ALUcontrol(ALUcontrol), .ImmSrc(ImmSrc));

// Program Counter Signals
wire [31:0] PCnext;
wire [31:0] PC;

// Program Counter Instantiation
PC RISC_PC (.PCnext(PCnext),.clk(clk),.areset(areset),.load(load),.PC(PC));

// Instruction Memory Instantiation
Instruction_Mem Inst_Mem (.A(PC), .RD(instr));

// Register File Signals  
wire [31:0] WD;
wire [31:0] RDA, RDB;

// Register File Instantiation
Reg_File Register_File (.clk(clk), .async_reset(areset), .WE(RegWrite), 
.RA_addr(instr[19:15]), .RB_addr(instr[24:20]), .W_addr(instr[11:7]),
.WD(WD), .RDA(RDA), .RDB(RDB));

// ALU Signals
wire [31:0] srcB;
wire [31:0] ALUrslt;
wire carryflag;

// ALU Instantiation
ALU alu(.srcA(RDA), .srcB(srcB), .ALUcntrl(ALUcontrol), .ALUrslt(ALUrslt),
.zeroflag(zero), .signflag(sign), .carryflag(carryflag));
 
// Data Memory Signals
wire [31:0] RD_DM;

// Data Memory Instantiation
Data_Mem Data_Memory(.clk(clk), .WE(MemWrite), .WD(RDB), .A(ALUrslt), .RD(RD_DM));

// Sign Extend Signals 
wire [31:0] ImmExt;

// Sign Extend Instantiation
Sign_Extend sign_extnd(.ImmSrc(ImmSrc), .instr(instr[31:7]), .ImmExt(ImmExt));

// Rest of the design
wire [31:0] PCPlus4,PCTarget ;
assign PCPlus4 = 3'b100 + PC ;
assign PCTarget = ImmExt + PC;

// PC MUX
assign PCnext = (PCSrc) ? PCTarget : PCPlus4;
// SrcB MUX
assign srcB   = (ALUSrc)? ImmExt : RDB;
// Result MUX
assign WD = (ResultSrc)? RD_DM : ALUrslt;  

endmodule 
