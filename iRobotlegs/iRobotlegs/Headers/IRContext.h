//
//  IRContext.h
//  iRobotlegs
//
//  Created by Pedr Browne on 20/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRCommandMap.h"
#import "IRMediatorMap.h"

@interface IRContext : NSObject
{
    NSNotificationCenter *notificationCenter_;
    id<IRInjector> injector_;
    BOOL autoStartup_;
    id<IRCommandMap> commandMap_;
    id<IRMediatorMap> mediatorMap_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSNotificationCenter *notificationCenter;
@property (retain, nonatomic) id<IRInjector> injector;
@property (nonatomic) BOOL autoStartup;
@property (retain, nonatomic) id<IRCommandMap> commandMap;
@property (retain, nonatomic) id<IRMediatorMap> mediatorMap;

//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(id)initWithAutoStartUp:(BOOL)autoStartup;

-(void)startup;
-(void)shutdown;

-(void)mapInjections;

@end
