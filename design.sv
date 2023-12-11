`include
"regfile1.sv"
`include
"alu1.sv"
`include
"imem1.sv"
`include
"dmem1.sv"
`include
"controller1.sv"

module
mips(
    input
logic
iClk,
input
logic
iReset
);

logic[31:0]
ALU_ALUResultE;
logic[31:0]
ALU_ALUResultM;
logic[31:0]
ALU_ALUResultW;
logic[31:0]
REG_SrcAD;
logic[31:0]
REG_SrcAE;
logic[31:0]
REG_WriteDataD;
logic[31:0]
REG_WriteDataE;
logic[31:0]
REG_WriteDataM;
logic[31:0]
IMEM_InstF;
logic[31:0]
IMEM_InstD;
logic[31:0]
DMEM_ReadDataM;
logic[31:0]
DMEM_ReadDataW;
logic[31:0]
pc;
logic[4:0]
WriteRegE;
logic[4:0]
WriteRegM;
logic[4:0]
WriteRegW;
logic[31:0]
SrcBE;
logic[31:0]
ResultW;
logic[15:0]
SignImmD;
logic[15:0]
SignImmE;
logic[4:0]
RtD;
logic[4:0]
RdD;
logic[4:0]
RtE;
logic[4:0]
RdE;

logic
CTL_RegWrite;
logic
CTL_MemWriteD;
logic
CTL_MemWriteE;
logic
CTL_MemWriteM;
logic
CTL_RegDstE;
logic
CTL_RegDstD;
logic
CTL_ALUSrcD;
logic
CTL_ALUSrcE;
logic
CTL_MemtoRegD;
logic
CTL_MemtoRegE;
logic
CTL_MemtoRegM;
logic
CTL_MemtoRegW;
logic[2:0]
CTL_ALUControlD;
logic[2:0]
CTL_ALUControlE;

assign
RtD = IMEM_InstD[20:16];
assign
RdD = IMEM_InstD[15:11];
assign
WriteRegE = CTL_RegDstE ? RdE: RtE;
assign
SignImmD = {{16
{IMEM_InstD[15]}}, IMEM_InstD[15:0]};
assign
SrcBE = CTL_ALUSrcE ? SignImmE: REG_WriteDataE;
assign
ResultW = CTL_MemtoRegW ? DMEM_ReadDataW: ALU_ALUResultW;

alu
ALU(
.iA	(REG_SrcAE),
.iB		(SrcBE),
.iF		(CTL_ALUControlE),
.oY		(ALU_ALUResultE),
.oZero	()
);

regfile REG(
        .iClk	(iClk),
.iReset	(iReset),
.iRaddr1(IMEM_InstD[25:21]),
.iRaddr2(IMEM_InstD[20:16]),
.iWaddr	(WriteRegW),
.iWe	(CTL_RegWrite),
.iWdata	(ResultW),
.oRdata1(REG_SrcAD),
.oRdata2(REG_WriteDataD)
);

imem IMEM(
     .iAddr	(pc),
.oRdata	(IMEM_InstF)
);

dmem DMEM(
     .iClk	(iClk),
.iReset	(iReset),
.iWe	(CTL_MemWriteM),
.iAddr	(ALU_ALUResultM),
.iWdata	(REG_WriteDataM),
.oRdata	(DMEM_ReadDataM)
);

controller CTL(
           .iOp		(IMEM_InstD[31:26]),
.iFunc		(IMEM_InstD[5:0]),
.oRegWrite	(CTL_RegWrite),
.oMemWrite	(CTL_MemWriteD),
.oRegDst	(CTL_RegDstD),
.oALUSrc	(CTL_ALUSrcD),
.oMemtoReg	(CTL_MemtoRegD),
.oALUControl(CTL_ALUControlD)
);

always_f f @(posedge iClk, posedge iReset)
i f(iReset)
    pc <= 0;
else
    pc <= pc + 4;

always_f f @(posedge iClk, posedge iReset )/ /Decode Stage
i f(iReset) begin
IMEM_InstD <= 0;
end else begin
IMEM_InstD <= IMEM_InstF;
end

always_f f @(posedge iClk, posedge iReset )/ /Execute Stage
i f(iReset) begin
REG_SrcA E< =0;
REG_WriteData E< =0;
Rt E< =0;
Rd E< =0;
SignImm E< =0;
CTL_ALUSrc E< =0;
CTL_RegDst E< =0;
CTL_ALUControl E< =0;
CTL_MemtoReg E< =0;
CTL_MemWrite E< =0;
CTL_ALUControl E< =0;
end else begin
REG_SrcA E< =REG_SrcAD;
REG_WriteData E< =REG_WriteDataD;
Rt E< =RtD;
Rd E< =RdD;
SignImm E< =SignImmD;
CTL_ALUSrc E< =CTL_ALUSrcD;
CTL_RegDst E< =CTL_RegDstD;
CTL_ALUControl E< =CTL_ALUControlD;
CTL_MemtoReg E< =CTL_MemtoRegD;
CTL_MemWrite E< =CTL_MemWriteD;
CTL_ALUControl E< =CTL_ALUControlD;

end

always_f f @(posedge iClk, posedge iReset )/ /Memory Stage
i f(iReset) begin
ALU_ALUResult M<= 0;
WriteReg M< =0;
REG_WriteData M< =0;
CTL_MemtoReg M< =0;
CTL_MemWrite M< =0;
WriteReg M< =0;

end else begin
ALU_ALUResult M<= ALU_ALUResultE;
WriteRegM < =WriteRegE;
REG_WriteDataM <= REG_WriteDataE;
CTL_MemtoReg M< =CTL_MemtoRegE;
CTL_MemWrite M< =CTL_MemWriteE;
WriteReg M< =WriteRegE;
end

always_f f @(posedge iClk, posedge iReset )/ /Write Stage
i f(iReset) begin
ALU_ALUResultW <= 0;
DMEM_ReadDataW < =0;
CTL_MemtoReg W< =0;
WriteReg W< =0;
end else begin
ALU_ALUResultW <= ALU_ALUResultM;
DMEM_ReadDataW < =DMEM_ReadDataM;
CTL_MemtoReg W< =CTL_MemtoRegM;
WriteReg W< =WriteRegM;;
end

endmodule

