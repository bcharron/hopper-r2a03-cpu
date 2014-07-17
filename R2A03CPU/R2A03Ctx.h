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
