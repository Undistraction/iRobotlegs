//
//  NotificationMappingData.m
//  iRobotlegs
//
//  Created by Pedr Browne on 23/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRNotificationMapping.h"

@implementation IRNotificationMapping

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize notificationName = notificationName_;
@synthesize notificationCenter = notificationCenter_;
@synthesize selector = selector_;
@synthesize observer = observer_;
@synthesize notificationClass = notificationClass_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc {
    self.notificationName = nil;
    self.notificationCenter = nil;
    self.selector = nil;
    self.observer = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(NSString *) description {
    return [NSString stringWithFormat:@"<IRNotificationMapping: %p>\n   notificationName: %@\n   notificationClass: %@\n   notificationCenter: %@\n   selector: %@\n   observer %@",
            self, self.notificationName, self.notificationClass, self.notificationCenter, self.selector, self.observer];
}

@end