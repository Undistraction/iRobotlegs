//
//  IRMediatorProtocol.h
//  iRobotlegs
//
//  Created by Pedr Browne on 23/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRMediatorMapProtocol.h"

@protocol IRMediatorMap; //Forward Reference


@protocol IRMediator <NSObject>

//------------------------------------------------------------------------------
//  Getter / Setter 
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSObject *mediatedObject;
@property (nonatomic, retain) NSNotificationCenter *notificationCenter;
@property (nonatomic, retain) id<IRMediatorMap> mediatorMap;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------ 

-(void)mediatedObjectWillBeRegistered;
-(void)mediatedObjectWasRegistered;
-(void)mediatedObjectWillBeUnregistered;
-(void)mediatedObjectWasUnregistered;

-(void) post:(NSNotification *)notification;

@end
