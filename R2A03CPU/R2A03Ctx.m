//
//  R2A03Ctx.m
//  R2A03CPU
//
//  Created by bcharron on 2014-07-13.
//  Copyright (c) 2014 Benjamin Charron. All rights reserved.
//

#import "R2A03Ctx.h"
#import "R2A03CPU.h"

@implementation R2A03Ctx {
    R2A03CPU *_cpu;
    NSObject<HPDisassembledFile> *_file;
}

- (instancetype)initWithCPU:(R2A03CPU *)cpu andFile:(NSObject<HPDisassembledFile> *)file {
    if (self = [super init]) {
        _cpu = cpu;
        _file = file;
    }
    return self;
}

- (NSObject<CPUContext> *)cloneContext {
    return [[R2A03Ctx alloc] initWithCPU:_cpu andFile:_file];
}

- (NSObject<CPUDefinition> *)cpuDefinition {
    return _cpu;
}

- (void)initDisasmStructure:(DisasmStruct *)disasm withSyntaxIndex:(NSUInteger)syntaxIndex {
    bzero(disasm, sizeof(DisasmStruct));
}

// Analysis

/// Adjust address to the lowest possible address acceptable by the CPU. Example: M68000 instruction must be word aligned, so this method would clear bit 0.
- (Address)adjustCodeAddress:(Address)address {
    // Nothing to do? 6502 doesn't care..
    return address;
}

/// Returns a guessed CPU mode for a given address. Example, ARM processors knows that an instruction is in Thumb mode if bit 0 is 1.
- (uint8_t)cpuModeFromAddress:(Address)address {
    // Might be able to do something here for the bank switching!
    return 0;
}

/// Returns YES if we know that a given address forces the CPU to use a specific mode. Thumb mode of comment above.
- (BOOL)addressForcesACPUMode:(Address)address {
    return NO;
}

/// An heuristic to estimate the CPU mode at a given address, not based on the value of the
/// address itself (this is the purpose of the "cpuModeFromAddress:" method), but rather
/// by trying to disassemble a few instruction and see which mode seems to be the best guess.
- (uint8_t)estimateCPUModeAtVirtualAddress:(Address)address {
    return(0);
}

- (Address)nextAddressToTryIfInstructionFailedToDecodeAt:(Address)address forCPUMode:(uint8_t)mode {
    return (address + 1);
}

- (BOOL)haveProcedurePrologAt:(Address)address {
    // There isn't usually much prolog to a function in NES games.
    return(FALSE);
}

/// Notify the plugin that an analysisbegan from an entry point.
/// This could be either a simple disassembling, or a procedure creation.
/// In the latter case, another method will be called to notify the plugin (see below).
- (void)analysisBeginsAt:(Address)entryPoint {
    
}

/// Notify the plugin that analysis has ended.
- (void)analysisEnded {
    
}

/// A Procedure object is about to be created.
- (void)procedureAnalysisBeginsForProcedure:(NSObject<HPProcedure> *)procedure atEntryPoint:(Address)entryPoint {
    
}

/// The prolog of the created procedure is being analyzed.
/// Warning: this method is not called at the begining of the procedure creation, but once all basic blocks
/// have been created.
- (void)procedureAnalysisOfPrologForProcedure:(NSObject<HPProcedure> *)procedure atEntryPoint:(Address)entryPoint {
    
}

- (void)procedureAnalysisEndedForProcedure:(NSObject<HPProcedure> *)procedure atEntryPoint:(Address)entryPoint {
    
}

/// A new basic bloc is created
- (void)procedureAnalysisContinuesOnBasicBlock:(NSObject<HPBasicBlock> *)basicBlock {
    
}

/// This method may be called when the internal state of the disassembler should be reseted.
/// For instance, the ARM plugin maintains a state during the disassembly process to
/// track the state of IT blocks. When this method is called, this state is reseted.
- (void)resetDisassembler {
    
}

/*
- (uint8_t)estimateCPUModeAtVirtualAddress:(Address)address {
    return 0;
}
*/

/*
uint16_t memory_read_callback(uint32_t address, void* private) {
    M68kCtx *ctx = (__bridge M68kCtx *)private;
    return [ctx readWordAt:address];
}

- (uint16_t)readWordAt:(uint32_t)address {
    return [_file readUInt16AtVirtualAddress:address];
}
 */

/// Disassemble a single instruction, filling the DisasmStruct structure.
/// Only a few fields are set by Hopper (mainly, the syntaxIndex, the "bytes" field and the virtualAddress of the instruction).
/// The CPU should fill as much information as possible.
- (int)disassembleSingleInstruction:(DisasmStruct *)disasm usingProcessorMode:(NSUInteger)mode {
    
    disasm->instruction.branchType = DISASM_BRANCH_NONE;
    disasm->instruction.addressValue = 0;

    /*
    DESA68parm_t d;
    d.mem_callb = memory_read_callback;
    d.private_data = (__bridge void *)self;
    d.pc = (unsigned int) disasm->virtualAddr;
    d.memmsk = 0xFFFFFF; // 24 bits addressing
    d.flags = 0;
    d.str = instr;
    d.strmax = sizeof(instr);
    desa68(&d);
    */
    
    // if ((d.status & DESA68_INST) == 0) return DISASM_UNKNOWN_OPCODE;
    
    for (int i=0; i<DISASM_MAX_OPERANDS; i++)
        disasm->operand[i].type = DISASM_OPERAND_NO_OPERAND;
    
    int len = 1;
    uint8_t opcode = [_file readUInt8AtVirtualAddress:disasm->virtualAddr];
    
    switch(opcode) {
        case 0x60:
            strcpy(disasm->operand1.mnemonic, "RTS");
            strcpy(disasm->completeInstructionString, "RTS");
            disasm->instruction.branchType = DISASM_BRANCH_RET;
            break;
            
        case 0x10:
            strcpy(disasm->operand1.mnemonic, "BCC");

            disasm->instruction.branchType = DISASM_BRANCH_JC;
            disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE | DISASM_OPERAND_ABSOLUTE;
            
            uint8_t l = [_file readUInt8AtVirtualAddress:disasm->virtualAddr + 1];
            uint8_t h = [_file readUInt8AtVirtualAddress:disasm->virtualAddr + 2];
            
            disasm->instruction.addressValue = (h << 8) | l;
            disasm->operand1.immediatValue = disasm->instruction.addressValue;

            snprintf(disasm->completeInstructionString, DISASM_INSTRUCTION_MAX_LENGTH, "BCC $%04X", (uint16_t) disasm->instruction.addressValue);
            
            len += 2;
            break;
            
        case 0xA9:
            strcpy(disasm->operand1.mnemonic, "LDA");
            disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE;
            
            uint8_t imm = [_file readUInt8AtVirtualAddress:disasm->virtualAddr + 1];
            disasm->operand1.immediatValue = imm;
            
            snprintf(disasm->completeInstructionString, DISASM_INSTRUCTION_MAX_LENGTH, "LDA #$%02X", imm);

            len += 1;
            
        default:
            strcpy(disasm->operand1.mnemonic, "UNK");
            break;
    }
    
    return(len);
    
    // In this early version, only branch instructions are analyzed in order to correctly
    // construct basic blocks of procedures.
    //
    // This is the strict minimum!
    //
    // You should also fill the "operand" description for every other instruction to take
    // advantage of the various analysis of Hopper.
    /*
    if (d.status & (DESA68_BSR | DESA68_BRA)) {
        if (strncmp(disasm->instruction.mnemonic, "jsr", 3) == 0
            || strncmp(disasm->instruction.mnemonic, "bsr", 3) == 0) {
            disasm->instruction.branchType = DISASM_BRANCH_CALL;
            if (d.branch & d.memmsk) {
                disasm->instruction.addressValue = d.branch & d.memmsk;
                disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE | DISASM_OPERAND_RELATIVE;
                disasm->operand1.immediatValue = disasm->instruction.addressValue;
            }
        }
        else {
            if (disasm->instruction.mnemonic[0] == 'd') {
                disasm->instruction.branchType = DISASM_BRANCH_JNE;
                if (d.branch & d.memmsk) {
                    disasm->instruction.addressValue = d.branch & d.memmsk;
                    disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE | DISASM_OPERAND_RELATIVE;
                    disasm->operand1.immediatValue = disasm->instruction.addressValue;
                }
            }
            else {
                if (strncmp(disasm->instruction.mnemonic, "bra", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JMP;
                }
                if (strncmp(disasm->instruction.mnemonic, "bhi", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JA;
                }
                if (strncmp(disasm->instruction.mnemonic, "bls", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JB;
                }
                if (strncmp(disasm->instruction.mnemonic, "bcc", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JNC;
                }
                if (strncmp(disasm->instruction.mnemonic, "bcs", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JC;
                }
                if (strncmp(disasm->instruction.mnemonic, "bne", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JNE;
                }
                if (strncmp(disasm->instruction.mnemonic, "beq", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JE;
                }
                if (strncmp(disasm->instruction.mnemonic, "bvc", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JNO;
                }
                if (strncmp(disasm->instruction.mnemonic, "bvs", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JO;
                }
                if (strncmp(disasm->instruction.mnemonic, "bpl", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JA;
                }
                if (strncmp(disasm->instruction.mnemonic, "bmi", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JB;
                }
                if (strncmp(disasm->instruction.mnemonic, "bge", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JNL;
                }
                if (strncmp(disasm->instruction.mnemonic, "blt", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JL;
                }
                if (strncmp(disasm->instruction.mnemonic, "bgt", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JG;
                }
                if (strncmp(disasm->instruction.mnemonic, "ble", 3) == 0) {
                    disasm->instruction.branchType = DISASM_BRANCH_JNG;
                }
            }
        }
        if (d.branch & d.memmsk) {
            disasm->instruction.addressValue = d.branch & d.memmsk;
            disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE | DISASM_OPERAND_RELATIVE;
            disasm->operand1.immediatValue = disasm->instruction.addressValue;
        }
    }
    
    if (d.status & DESA68_RTS) disasm->instruction.branchType = DISASM_BRANCH_RET;
    
    int len = d.pc - (unsigned int) disasm->virtualAddr;
    return len;
     */
}

/// Returns whether or not an instruction may halt the processor (like the HLT Intel instruction).
- (BOOL)instructionHaltsExecutionFlow:(DisasmStruct *)disasm {
    return NO;
}

/// If a branch instruction is found, Hopper calls this method to compute additional destinations of the instruction.
/// The "*next" value is already set to the address which follows the instruction if the jump does not occurs.
/// The "branches" array is filled by NSNumber objects. The values are the addresses where the instruction can jump. Only the
/// jumps that occur in the same procedure are put here (for instance, CALL instruction targets are not put in this array).
/// The "callSitesAddresses" array is filled by NSNumber objects of addresses that are the target of a "CALL like" instruction, ie
/// all the jumps which go outside of the procedure.
/// The purpose of this method is to compute additional destinations.
/// Most of the time, Hopper already found the destinations, so there is no need to do more.
/// This is used by the Intel CPU plugin to compute the destinations of switch/case constructions when it found a "JMP register" instruction.
- (void)performBranchesAnalysis:(DisasmStruct *)disasm computingNextAddress:(Address *)next andBranches:(NSMutableArray *)branches forProcedure:(NSObject<HPProcedure> *)procedure basicBlock:(NSObject<HPBasicBlock> *)basicBlock ofSegment:(NSObject<HPSegment> *)segment callsites:(NSMutableArray *)callSitesAddresses {
    
}

/// If you need a specific analysis, this method will be called once the previous branch analysis is performed.
/// For instance, this is used by the ARM CPU plugin to set the type of the destination of an LDR instruction to
/// an int of the correct size.
- (void)performInstructionSpecificAnalysis:(DisasmStruct *)disasm forProcedure:(NSObject<HPProcedure> *)procedure inSegment:(NSObject<HPSegment> *)segment {
    
}

/// Thess methods are called to let you update your internal plugin state during the analysis.
- (void)performProcedureAnalysis:(NSObject<HPProcedure> *)procedure basicBlock:(NSObject<HPBasicBlock> *)basicBlock disasm:(DisasmStruct *)disasm {
    
}

- (void)updateProcedureAnalysis:(DisasmStruct *)disasm {
    
}

////////////////////////////////////////////////////////////////////////////////
//
// Printing instruction
//
////////////////////////////////////////////////////////////////////////////////

/// The method should return a default name for a local variable at a given displacement on stack.
- (NSString *)formattedVariableNameForDisplacement:(int64_t)displacement inProcedure:(NSObject<HPProcedure> *)procedure {
    return [NSString stringWithFormat:@"var%lld", displacement];
}

/// Build the complete instruction string in the DisasmStruct structure.
/// This is the string to be displayed in Hopper.
- (void)buildInstructionString:(DisasmStruct *)disasm forSegment:(NSObject<HPSegment> *)segment populatingInfo:(NSObject<HPFormattedInstructionInfo> *)formattedInstructionInfo {
    /*
    const char *spaces = "                ";
    strcpy(disasm->completeInstructionString, disasm->instruction.mnemonic);
    strcat(disasm->completeInstructionString, spaces + strlen(disasm->instruction.mnemonic));
    for (int i=0; i<DISASM_MAX_OPERANDS; i++) {
        if (disasm->operand[i].mnemonic[0] == 0) break;
        if (i) strcat(disasm->completeInstructionString, ", ");
        strcat(disasm->completeInstructionString, disasm->operand[i].mnemonic);
    }
    */
}

// Decompiler

- (BOOL)canDecompileProcedure:(NSObject<HPProcedure> *)procedure {
    return NO;
}

/// Return the address of the first instruction of the procedure, after its prolog.
- (Address)skipHeader:(NSObject<HPBasicBlock> *)basicBlock ofProcedure:(NSObject<HPProcedure> *)procedure {
    return basicBlock.from;
}

/// Return the address of the last instruction of the procedure, before its epilog.
- (Address)skipFooter:(NSObject<HPBasicBlock> *)basicBlock ofProcedure:(NSObject<HPProcedure> *)procedure {
    return basicBlock.to;
}

/// Returns an AST representation of an operand of an instruction.
/// Note: ASTNode is not publicly exposed yet. You cannot write a decompiler at the moment.
- (ASTNode *)rawDecodeArgumentIndex:(int)argIndex
                           ofDisasm:(DisasmStruct *)disasm
                  ignoringWriteMode:(BOOL)ignoreWrite
                    usingDecompiler:(Decompiler *)decompiler {
    return nil;
}

/// Decompile an assembly instruction.
/// Note: ASTNode is not publicly exposed yet. You cannot write a decompiler at the moment.
- (ASTNode *)decompileInstructionAtAddress:(Address)a
                                    disasm:(DisasmStruct)d
                                    length:(int)instrLength
                                      arg1:(ASTNode *)arg1
                                      arg2:(ASTNode *)arg2
                                      arg3:(ASTNode *)arg3
                                      dest:(ASTNode *)dest
                                 addNode_p:(BOOL *)addNode_p
                           usingDecompiler:(Decompiler *)decompiler {
    return nil;
}

////////////////////////////////////////////////////////////////////////////////
//
// Assembler
//
////////////////////////////////////////////////////////////////////////////////

- (NSData *)assembleRawInstruction:(NSString *)instr atAddress:(Address)addr forFile:(NSObject<HPDisassembledFile> *)file withCPUMode:(uint8_t)cpuMode usingSyntaxVariant:(NSUInteger)syntax error:(NSError **)error {
    return nil;
}

@end
