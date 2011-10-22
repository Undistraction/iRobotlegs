//
//  IRMediator.h
//  iRobotlegs
//
//  Created by Pedr Browne on 19/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRNotificationMap.h"
#import "IRMediatorMap.h"
#import "IRMediatorMapProtocol.h"
#import "IRNotificationMapProtocol.h"

@interface IRMediator : NSObject<IRMediator>
{
    @private
        NSObject *mediatedObject_;
        NSNotificationCenter *notificationCenter_;
        id<IRNotificationMap> notificationMap_;
        id<IRMediatorMap> mediatorMap_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSObject *mediatedObject;
@property (nonatomic, retain) NSNotificationCenter *notificationCenter;
@property (nonatomic, retain) id<IRNotificationMap> notificationMap;
@property (nonatomic, retain) id<IRMediatorMap> mediatorMap;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(void)mediatedObjectWillBeRegistered;
-(void)mediatedObjectWasRegistered;
-(void)mediatedObjectWillBeUnregistered;
-(void)mediatedObjectWasUnregistered;

@end
