//
//  TestCommand.h
//  iRobotlegs
//
//  Created by Pedr Browne on 27/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRCommandMapTestsProtocol.h"

@interface TestCommand : NSObject<IRCommand>
{
    @private
        id<IRCommandMapTests> commandMapTests_;
}

@property (retain, nonatomic) id<IRCommandMapTests> commandMapTests;

-(void)execute;

@end
