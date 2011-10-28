//
//  IRViewController.m
//  IRobotlegs
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRViewController.h"
#import "IRNotificationMap.h"

@interface IRViewController()
@end


@implementation IRViewController

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize notificationCenter = notificationCenter_;
@synthesize notificationMap = notificationMap_;

-(IRNotificationMap *) notificationMap
{
    if(!notificationMap_)
    {
        self.notificationMap = [[[IRNotificationMap alloc] initWithNotificationCenter: self.notificationCenter] autorelease];
    }
    return notificationMap_;
}

-(void)setNotificationCenter:(NSNotificationCenter *)notificationCenter
{
    [notificationCenter_ release];
    notificationCenter_ = [notificationCenter retain];
    if(self.notificationCenter)
    {
        [self addContextObservers];
    }
}

//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

-(IRViewController *)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
{
    self.notificationCenter = notificationCenter;
    [self addContextObservers];
    return [super init ];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle notificationCenter:(NSNotificationCenter *)notificationCenter
{
    self.notificationCenter = notificationCenter;
    [self addContextObservers];
    return [super initWithNibName:nibName bundle:nibBundle];
}

-(id)init
{
    return [self initWithNotificationCenter:nil];
}

//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)post:(NSNotification *)notification
{
    [self.notificationCenter postNotification: notification];
}

-(void)addContextObserver:(NSString *)notificationName selector:(SEL)selector
{
    [self.notificationCenter addObserver:self selector:selector name:notificationName object:nil];
}

-(void)addContextObservers
{
    //Override in subclass
}

@end
