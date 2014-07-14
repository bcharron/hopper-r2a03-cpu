//
//  R2A03CPU.m
//  R2A03CPU
//
//  Created by bcharron on 2014-07-13.
//  Copyright (c) 2014 Benjamin Charron. All rights reserved.
//

#import "R2A03CPU.h"
#import "R2A03Ctx.h"

@implementation R2A03CPU {
    NSObject<HPHopperServices> *_services;
}

- (instancetype)initWithHopperServices:(NSObject<HPHopperServices> *)services {
    if (self = [super init]) {
        _services = services;
    }
    return self;
}

- (UUID *)pluginUUID {
    return [_services UUIDWithString:@"356d3f10-0ac3-11e4-9191-0800200c9a66"];
}
- (HopperPluginType)pluginType {
    return(Plugin_CPU);
}

- (NSString *)pluginName {
    return(@"Ricoh 2A03");
}

- (NSString *)pluginDescription {
    return(@"Ricoh 2A03 CPU Support (NES)");
}

- (NSString *)pluginAuthor {
    return(@"Benjamin Charron");
}
- (NSString *)pluginCopyright {
    return(@"(C) 2014 Benjamin Charron");
}

- (NSString *)pluginVersion {
    return(@"0.1.0");
}

- (NSObject<CPUContext> *)buildCPUContextForFile:(NSObject<HPDisassembledFile> *)file {
    return [[R2A03Ctx alloc] initWithCPU:self andFile:file];
}

/// Returns an array of NSString of CPU families handled by the plugin.
- (NSArray *)cpuFamilies {
    return@[@"ricoh"];
}

/// Returns an array of NSString of CPU subfamilies handled by the plugin for a given CPU family.
- (NSArray *)cpuSubFamiliesForFamily:(NSString *)family {
    if ([family isEqualToString:@"ricoh"])
        return(@[@"R2A3"]);
    
    return(nil);
}

/// Returns 32 or 64, according to the family and subFamily arguments.
- (int)addressSpaceWidthInBitsForCPUFamily:(NSString *)family andSubFamily:(NSString *)subFamily {
    if ([family isEqualToString:@"ricoh"] && [subFamily isEqualToString:@"R2A3"]) return 32;
    return(0);
}

/// Default endianess of the CPU.
- (CPUEndianess)endianess {
    return(CPUEndianess_Little);
}

/// Usually, returns 1, but for the Intel processor, it'll return 2 because we have the Intel and the AT&T syntaxes.
- (NSUInteger)syntaxVariantCount{
    return(1);
}

/// The number of CPU modes. For instance, 2 for the ARM CPU family: ARM and Thumb modes.
- (NSUInteger)cpuModeCount {
    return(1);
}

- (NSArray *)syntaxVariantNames {
    return @[@"generic"];
}

- (NSArray *)cpuModeNames {
    return @[@"generic"];
}

- (NSUInteger)registerClassCount {
    return(RegClass_R2A03_Cnt);
}

- (NSUInteger)registerCountForClass:(NSUInteger)reg_class {
    switch (reg_class) {
        case RegClass_CPUState: return 1;
        case RegClass_PseudoRegisterSTACK: return 32;
        case RegClass_GeneralPurposeRegister: return 4;
        case RegClass_AddressRegister: return 3;
        default: break;
    }
    return 0;
}

// Not quite sure what this function should return for GP and Address registers
- (NSString *)registerIndexToString:(int)reg ofClass:(RegClass)reg_class withBitSize:(int)size andPosition:(DisasmPosition)position {
    switch (reg_class) {
        case RegClass_CPUState: return @"CCR";
        case RegClass_PseudoRegisterSTACK: return [NSString stringWithFormat:@"STK%d", reg];
        case RegClass_GeneralPurposeRegister: {
            switch(reg) {
                case 0x00: return @"A";
                    break;
                    
                case 0x01: return @"X";
                    break;
                    
                case 0x02: return @"Y";
                    break;
                    
                case 0x03: return(@"SP");
                    break;
                    
                default:
                    return(@"NA");
                    break;
            }
        }
        case RegClass_AddressRegister: {
            switch(reg) {
                case 0x00:
                    return(@"X");
                    break;
                    
                case 0x01:
                    return(@"Y");
                    break;
                    
                default:
                    return(@"NA");
                    break;
            }
        }
            
        default: break;
    }
    
    return nil;
}

/// A weirdness of the Hopper internals. You'll usually simply need to return the "index" argument.
/// This is used by Hopper to handle the fact that operands in Intel and AT&T syntaxes are inverted.
- (NSUInteger)translateOperandIndex:(NSUInteger)index operandCount:(NSUInteger)count accordingToSyntax:(uint8_t)syntaxIndex {
    return index;
}

/// Returns a colorized string to be displayed.
/// HPHopperServices protocol provides a very simple colorizer, based on predicates.
- (NSAttributedString *)colorizeInstructionString:(NSAttributedString *)string {
    NSMutableAttributedString *colorized = [string mutableCopy];
    [_services colorizeASMString:colorized
               operatorPredicate:^BOOL(unichar c) {
                   return (c == '#' || c == '$');
               }
           languageWordPredicate:^BOOL(NSString *s) {
               return(NO);
           }
        subLanguageWordPredicate:^BOOL(NSString *s) {
            return(NO);
        }];
    return colorized;
}

/// Returns a array of bytes that represents a NOP instruction of a given size.
- (NSData *)nopWithSize:(NSUInteger)size andMode:(NSUInteger)cpuMode forFile:(NSObject<HPDisassembledFile> *)file {
    NSMutableData *nopArray = [[NSMutableData alloc] initWithCapacity:size];
    [nopArray setLength:size];
    uint16_t *ptr = (uint16_t *)[nopArray mutableBytes];
    memset(ptr, 0xEA, size);
    
    return [NSData dataWithData:nopArray];
}

/// Return YES if the plugin embed an assembler.
- (BOOL)canAssembleInstructionsForCPUFamily:(NSString *)family andSubFamily:(NSString *)subFamily {
    return(NO);
}

/// Return YES if the plugin embed a decompiler.
/// Note: you cannot create a decompiler yet, because the main class (ASTNode) is not
/// publicly exposed yet.
- (BOOL)canDecompileProceduresForCPUFamily:(NSString *)family andSubFamily:(NSString *)subFamily {
    return(NO);
}

@end
