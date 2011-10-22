//
//  IRCommand.h
//  iRobotlegs
//
//  Created by Pedr Browne on 19/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRMediatorMap.h"
#import "IRCommandMapProtocol.h"

@interface IRCommand : NSObject<IRCommand>
{
    @private
        id<IRCommandMap> commandMap_;
        NSNotificationCenter *notificationCenter_;
        id<IRMediatorMap> mediatorMap_;
        id<IRInjector> injector_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) id<IRCommandMap> commandMap;
@property (retain, nonatomic) NSNotificationCenter *notificationCenter;
@property (retain, nonatomic) id<IRMediatorMap> mediatorMap;
@property (retain, nonatomic) id<IRInjector> injector;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------ 

-(void)execute;
-(void)post:(NSNotification *)notification;

@end
