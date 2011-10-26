//
//  TestMediatedObject.m
//  iRobotlegs
//
//  Created by Pedr Browne on 18/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "TestMediatedObject.h"
#import "IRConstants.h"

@implementation TestMediatedObject


-(id) copyWithZone: (NSZone *) zone
{
    return [[[TestMediatedObject alloc] init] autorelease];
}

/*- (id)init
{
    self = [super init];
    if (self) {
        NSNotification *notification = [NSNotification notificationWithName:OBJECT_INITIALISED object:self];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
    return self;
}*/

/*-(void)dealloc
{
    NSNotification *notification = [NSNotification notificationWithName:OBJECT_DEALLOCATED object:self];
    [[NSNotificationCenter defaultCenter] postNotification: notification];
    [super dealloc];
}*/

@end
