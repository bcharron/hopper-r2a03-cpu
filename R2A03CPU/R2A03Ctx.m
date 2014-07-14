//
//  R2A03Ctx.m
//  R2A03CPU
//
//  Created by bcharron on 2014-07-13.
//  Copyright (c) 2014 Benjamin Charron. All rights reserved.
//

#import "R2A03Ctx.h"
#import "R2A03CPU.h"

enum r2a3_addressing_modes {
    AM_IMPLIED,
    AM_ACCUMULATOR,
    AM_IMMEDIATE,
    AM_ZERO_PAGE,
    AM_ZERO_PAGE_X,
    AM_ABSOLUTE,
    AM_ABSOLUTE_X,
    AM_ABSOLUTE_Y,
    AM_INDIRECT_X,
    AM_INDIRECT_Y
};

struct r2a3_inst {
    char mnemonic[4];
    uint8_t number;
    bool isBranch;
    enum r2a3_addressing_modes addr_mode;
    uint8_t len;
};

// Opcodes table defined here
#include "opcodes.h"

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
    
    for (int i=0; i<DISASM_MAX_OPERANDS; i++)
        disasm->operand[i].type = DISASM_OPERAND_NO_OPERAND;
    
    // uint8_t opcode = [_file readUInt8AtVirtualAddress:disasm->virtualAddr];
    uint8_t opcode = disasm->bytes[0];
    
    if (strcmp(R2A03_INSTRUCTIONS[opcode].mnemonic, "BAD") == 0) {
        return(DISASM_UNKNOWN_OPCODE);
    }
    
    strcpy(disasm->instruction.mnemonic, R2A03_INSTRUCTIONS[opcode].mnemonic);
    
    char addressing[20];
    
    switch(R2A03_INSTRUCTIONS[opcode].addr_mode) {
        case AM_ZERO_PAGE:
            snprintf(addressing, sizeof(addressing), "$%02X", disasm->bytes[1]);
            disasm->instruction.addressValue = disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "$%02X", disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;
            break;

        case AM_ZERO_PAGE_X:
            snprintf(addressing, sizeof(addressing), "$%02X,X", disasm->bytes[1]);
            disasm->instruction.addressValue = disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "$%02X", disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;

            strcpy(disasm->operand2.mnemonic, ",X");
            disasm->operand2.type = DISASM_OPERAND_REGISTER_TYPE;
            break;

        case AM_IMMEDIATE:
            snprintf(addressing, sizeof(addressing), "#$%02X", disasm->bytes[1]);
            disasm->operand1.immediatValue = disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "#$%02X", disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE;
            break;
            
        case AM_ABSOLUTE:
            snprintf(addressing, sizeof(addressing), "$%04X", disasm->bytes[2] << 8 | disasm->bytes[1]);
            disasm->instruction.addressValue = disasm->bytes[2] << 8 | disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE | DISASM_OPERAND_MEMORY_TYPE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "$%04X", disasm->bytes[2] << 8 | disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;
            break;
            
        // Not sure about REGISTER_TYPE
        case AM_ABSOLUTE_X:
            snprintf(addressing, sizeof(addressing), "$%04X,X", disasm->bytes[2] << 8 | disasm->bytes[1]);
            disasm->instruction.addressValue = disasm->bytes[2] << 8 | disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE | DISASM_OPERAND_REGISTER_TYPE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "$%04X", disasm->bytes[2] << 8 | disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;

            strcpy(disasm->operand2.mnemonic, ",X");
            disasm->operand2.type = DISASM_OPERAND_REGISTER_TYPE;
            break;

        case AM_ABSOLUTE_Y:
            snprintf(addressing, sizeof(addressing), "$%04X,Y", disasm->bytes[2] << 8 | disasm->bytes[1]);
            disasm->instruction.addressValue = disasm->bytes[2] << 8 | disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE | DISASM_OPERAND_REGISTER_TYPE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "$%04X", disasm->bytes[2] << 8 | disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;
            
            strcpy(disasm->operand2.mnemonic, ",Y");
            disasm->operand2.type = DISASM_OPERAND_REGISTER_TYPE;
            break;

        case AM_INDIRECT_X:
            snprintf(addressing, sizeof(addressing), "($%02X,X)", disasm->bytes[1]);
            disasm->instruction.addressValue = disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE | DISASM_OPERAND_REGISTER_TYPE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "($%02X,X)", disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;
            break;

        case AM_INDIRECT_Y:
            snprintf(addressing, sizeof(addressing), "($%02X),Y", disasm->bytes[1]);
            disasm->instruction.addressValue = disasm->bytes[1];
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE | DISASM_OPERAND_REGISTER_TYPE;
            
            snprintf(disasm->operand1.mnemonic, DISASM_OPERAND_MNEMONIC_MAX_LENGTH, "($%02X)", disasm->bytes[1]);
            disasm->operand1.type = DISASM_OPERAND_ABSOLUTE;
            
            strcpy(disasm->operand2.mnemonic, ",Y");
            disasm->operand2.type = DISASM_OPERAND_REGISTER_TYPE;
            break;

        case AM_IMPLIED:
            strcpy(addressing, "");
            disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE;
            break;

        case AM_ACCUMULATOR:
            strcpy(addressing, "A");
            disasm->operand1.type = DISASM_OPERAND_REGISTER_TYPE;
            
            strcpy(disasm->operand1.mnemonic, "A");
            break;

        default:
            snprintf(addressing, sizeof(addressing), "XXXXXX");
            disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE;
            break;
    }

    if (R2A03_INSTRUCTIONS[opcode].isBranch) {
        switch(opcode) {
            case 0x10: // BPL
                disasm->instruction.branchType = DISASM_BRANCH_JNS;
                break;
                
            case 030: // BMI
                disasm->instruction.branchType = DISASM_BRANCH_JS;
                break;
                
            case 0x50: // BVC
                disasm->instruction.branchType = DISASM_BRANCH_JNO;
                break;
                
            case 0x70: // BVS
                disasm->instruction.branchType = DISASM_BRANCH_JO;
                break;
                
            case 0x90: // BCC
                disasm->instruction.branchType = DISASM_BRANCH_JNC;
                break;
                
            case 0xB0: // BCS
                disasm->instruction.branchType = DISASM_BRANCH_JC;
                break;
                
            case 0xD0: // BNE
                disasm->instruction.branchType = DISASM_BRANCH_JNE;
                break;
                
            case 0xF0: // BEQ
                disasm->instruction.branchType = DISASM_BRANCH_JE;
                break;
                
            default:
                disasm->instruction.branchType = DISASM_BRANCH_JNE;
                break;
        }
        
        // uint8_t l = [_file readUInt8AtVirtualAddress:disasm->virtualAddr + 1];
        // uint8_t h = [_file readUInt8AtVirtualAddress:disasm->virtualAddr + 2];
        
        // Branches are relative. PC already read both the opcode and the operand, hence +2
        disasm->instruction.addressValue = disasm->virtualAddr + (int8_t) disasm->bytes[1] + 2;
        disasm->operand1.immediatValue = disasm->instruction.addressValue;
        disasm->operand1.type = DISASM_OPERAND_CONSTANT_TYPE | DISASM_OPERAND_RELATIVE;
        
        snprintf(addressing, sizeof(addressing), "$%04X", (uint16_t) disasm->instruction.addressValue);
        
        snprintf(disasm->operand1.mnemonic, sizeof(addressing), "$%04X", (uint16_t) disasm->instruction.addressValue);
    }
    
    // XXX: How to indicate that PHA and PLA are stack instructions?
    
    // Special instructions
    switch(opcode) {
        case 0x60: // RTS
            disasm->instruction.branchType = DISASM_BRANCH_RET;
            break;
            
        case 0x20: // JSR
            disasm->instruction.branchType = DISASM_BRANCH_CALL;
            break;
            
        case 0x4C: // JMP (absolute)
        case 0x6c: // JMP (indirect)
            disasm->instruction.branchType = DISASM_BRANCH_JMP;
            break;
            
        case 0x40: // RTI
            disasm->instruction.branchType = DISASM_BRANCH_RET;
            break;
            
        case 0x18: // CLC
            disasm->instruction.eflags.CF_flag = 0;
            break;
            
        default:
            break;
    }

    // Default value?
    /*
    snprintf(disasm->completeInstructionString, DISASM_INSTRUCTION_MAX_LENGTH, "%s %s", R2A03_INSTRUCTIONS[opcode].mnemonic, addressing);
    */
    
    return(R2A03_INSTRUCTIONS[opcode].len);
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
    
    const char *spaces = "       ";
    strcpy(disasm->completeInstructionString, disasm->instruction.mnemonic);
    strcat(disasm->completeInstructionString, spaces + strlen(disasm->instruction.mnemonic));
    for (int i=0; i<DISASM_MAX_OPERANDS; i++) {
        if (disasm->operand[i].type == DISASM_OPERAND_NO_OPERAND) break;
        if (i) strcat(disasm->completeInstructionString, " ");
        
        if (disasm->operand[i].type == DISASM_OPERAND_ABSOLUTE) {
            // Find the variable name here. Shouldn't Hopper do that?
//            [formattedInstructionInfo ]
        }
        strcat(disasm->completeInstructionString, disasm->operand[i].mnemonic);
    }
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
