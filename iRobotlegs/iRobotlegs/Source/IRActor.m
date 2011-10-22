//
//  Actor.m
//  iRobotlegs
//
//  Created by Pedr Browne on 16/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRActor.h"
#import "IRNotificationMap.h"
#import "IRobotlegs.h"

@implementation IRActor

irobotlegs_requires(@"notificationCenter");

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


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc {
    self.notificationCenter = nil;
    self.notificationMap = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)post:(NSNotification *)notification
{
    [self.notificationCenter postNotification:notification];
}

		
@end