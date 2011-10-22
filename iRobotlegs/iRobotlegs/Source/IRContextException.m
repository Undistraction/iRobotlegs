//
//  IRContextException.m
//  iRobotlegs
//
//  Created by Pedr Browne on 23/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRContextException.h"

NSString *const E_COMMANDMAP_NOIMPL_NAME = @"IRCommand Implementation";
NSString *const E_COMMANDMAP_OVR_NAME = @"IRCommandMap Overwrite";
NSString *const E_MEDIATORMAP_NOIMPL_NAME = @"IRMediator Implementation";
NSString *const E_MEDIATORMAP_OVR_NAME = @"IRMediatorMap Overwrite";
NSString *const E_EVENTMAP_NOSNOOPING_NAME = @"IRNotificationMap Snooping";

NSString *const E_COMMANDMAP_NOIMPL_REASON = @"IRCommand Class does not implement an execute() method";
NSString *const E_COMMANDMAP_OVR_REASON = @"Cannot overwrite map";
NSString *const E_MEDIATORMAP_NOIMPL_REASON = @"IRMediator Class does not implement Protocol IRMediator";
NSString *const E_MEDIATORMAP_OVR_REASON = @"IRMediator Class has already been mapped to a mediated object Class in this context";
NSString *const E_EVENTMAP_NOSNOOPING_REASON = @"Observing the context notificationCenter is not enabled for this NotificationMap";

@implementation IRContextException
@end
