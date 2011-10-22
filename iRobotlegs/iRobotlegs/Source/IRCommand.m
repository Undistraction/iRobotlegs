//
//  IRCommand.m
//  iRobotlegs
//
//  Created by Pedr Browne on 19/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRCommand.h"
#import "IRobotlegs.h"

@implementation IRCommand

irobotlegs_requires(@"commandMap", @"notificationCenter", @"mediatorMap", @"injector");


//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize commandMap = commandMap_;
@synthesize notificationCenter = notificationCenter_;
@synthesize mediatorMap = mediatorMap_;
@synthesize injector = injector_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc {
    self.commandMap = nil;
    self.notificationCenter = nil;
    self.mediatorMap = nil;
    self.injector = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)execute
{
    //Implement in subclass 
    //TODO: Look at using delegation
}

-(void)post:(NSNotification *)notification
{
    [self.notificationCenter postNotification: notification];
}

@end
