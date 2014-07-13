//
//  R2A03Ctx.h
//  R2A03CPU
//
//  Created by bcharron on 2014-07-13.
//  Copyright (c) 2014 Benjamin Charron. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Hopper/Hopper.h>

@class R2A03CPU;

@interface R2A03Ctx : NSObject<CPUContext>

- (instancetype)initWithCPU:(R2A03CPU *)cpu andFile:(NSObject<HPDisassembledFile> *)file;


@end
