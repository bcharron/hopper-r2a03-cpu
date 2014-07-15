/*
    This file is part of hopper-r2a03-cpu.

    hopper-r2a03-cpu is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    hopper-r2a03-cpu is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with hopper-r2a03-cpu.  If not, see <http://www.gnu.org/licenses/>.
*/

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
