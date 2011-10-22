//
//  IRCommandMapProtocol.h
//  iRobotlegs
//
//  Created by Pedr Browne on 23/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRInjectorProtocol.h"
#import "IRCommandProtocol.h"

@protocol IRCommandMap <NSObject>

//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(id)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter  injector:(id<IRInjector>)injector;

-(void)mapNotification:(NSString *)notificationName
          commandClass:(Class)commandClass 
     notificationClass:(Class)notificationClass
               oneshot:(BOOL)oneshot;

-(void)unmapNotification:(NSString *)notificationName
            commandClass:(Class)commandClass 
       notificationClass:(Class)notificationClass;
       
-(void)unmapNotifications;

-(BOOL)hasNotificationCommand:(NSString *)notificationName 
                 commandClass:(Class)commandClass
            notificationClass:(Class)notificationClass;

-(void)execute:(Class)commandClass payload:(id)payload payloadClass:(Class)payloadClass;

-(void)releaseCommand:(id<IRCommand>)command;
-(void)retainCommand:(id<IRCommand>)command;

@end