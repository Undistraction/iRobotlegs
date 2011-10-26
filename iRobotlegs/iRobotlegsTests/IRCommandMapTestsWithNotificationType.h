//
//  IRCommandMapTests.h
//  iRobotlegs
//
//  Created by Pedr Browne on 27/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import "IRCommandMap.h"
#import "IRObjectionInjector.h"
#import "IRCommandMapTestsProtocol.h"

@interface IRCommandMapTestsWithNotificationType : SenTestCase<IRCommandMapTests>
{
    @private
        BOOL commandExecuted;
        IRCommandMap *commandMap;
        NSNotificationCenter *notificationCenter;
        IRObjectionInjector *injector;
}


-(void)commandDidExecute;


@end