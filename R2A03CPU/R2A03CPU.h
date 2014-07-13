//
//  R2A03CPU.h
//  R2A03CPU
//
//  Created by bcharron on 2014-07-13.
//  Copyright (c) 2014 Benjamin Charron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Hopper/Hopper.h>

typedef NS_ENUM(NSUInteger, M68kRegClass) {
    RegClass_AddressRegister = RegClass_FirstUserClass,
    RegClass_R2A03_Cnt
};

@interface R2A03CPU : NSObject<CPUDefinition>

@end
