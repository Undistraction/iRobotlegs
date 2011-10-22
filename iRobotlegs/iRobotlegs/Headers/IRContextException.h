//
//  IRContextException.h
//  iRobotlegs
//
//  Created by Pedr Browne on 23/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

extern NSString *const E_COMMANDMAP_NOIMPL_NAME;
extern NSString *const E_COMMANDMAP_OVR_NAME;
extern NSString *const E_MEDIATORMAP_NOIMPL_NAME;
extern NSString *const E_MEDIATORMAP_OVR_NAME;
extern NSString *const E_EVENTMAP_NOSNOOPING_NAME;

extern NSString *const E_COMMANDMAP_NOIMPL_REASON;
extern NSString *const E_COMMANDMAP_OVR_REASON;
extern NSString *const E_MEDIATORMAP_NOIMPL_REASON;
extern NSString *const E_MEDIATORMAP_OVR_REASON;
extern NSString *const E_EVENTMAP_NOSNOOPING_REASON;

@interface IRContextException : NSException
@end
