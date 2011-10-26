//
//  TestNotification.m
//  iRobotlegs
//
//  Created by Pedr Browne on 18/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//
#import "TestNotification.h"

NSString *const TEST_NOTIFICATION_NAME = @"TestNotificationName";

@implementation TestNotification

-(id)initWithObject:(id)object
{
    object_ = object;
    return self;
}

-(NSString *)name
{
    return TEST_NOTIFICATION_NAME;
}

-(id)object
{
    
    return object_;
}

- (NSDictionary *)userInfo
{
    return nil;
}

@end
