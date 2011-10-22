//
//  IRMediator.m
//  iRobotlegs
//
//  Created by Pedr Browne on 19/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRMediator.h"
#import "IRobotlegs.h"

@implementation IRMediator

//------------------------------------------------------------------------------
//  Dependency Injection Macros
//------------------------------------------------------------------------------ 

irobotlegs_requires(@"notificationCenter", @"mediatorMap")

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------ 

@synthesize mediatedObject = mediatedObject_;
@synthesize notificationCenter = notificationCenter_;
@synthesize notificationMap = notificationMap_;
@synthesize mediatorMap = mediatorMap_;

-(IRNotificationMap *) notificationMap
{
    if(!notificationMap_)
        self.notificationMap = [[[IRNotificationMap alloc] initWithNotificationCenter: self.notificationCenter] autorelease];
    return notificationMap_;
}

//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

- (id)initWithViewMediatedObject:(NSObject *)mediatedObject
{
    self = [super init];
    if (self) {
       self.mediatedObject = mediatedObject;
    }
    return self;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

-(void)dealloc
{
    self.mediatedObject = nil;
    self.notificationCenter = nil;
    self.notificationMap = nil; 
    self.mediatorMap = nil;   
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)post:(NSNotification *)notification
{
    [self.notificationCenter postNotification: notification];
}

-(void)addMediatedObjectObserver:(NSString *)notificationName selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:notificationName object:nil];
}

-(void)addContextObserver:(NSString *)notificationName selector:(SEL)selector
{
    [self.notificationCenter addObserver:self selector:selector name:notificationName object:nil];
}

-(void)mediatedObjectWillBeRegistered
{
    //Hook
}

-(void)mediatedObjectWasRegistered
{
    //Hook
}

-(void)mediatedObjectWillBeUnregistered
{
    if(self.notificationMap)
        [self.notificationMap unmapObservers];
}

-(void)mediatedObjectWasUnregistered
{
    //Hook
}


@end
