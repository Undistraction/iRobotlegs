//
//  IRNotificationMapTests.h
//  iRobotlegs
//
//  Created by Pedr Browne on 28/09/2011.
//  Copyright (c) 2011 the original author or authors

//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <SenTestingKit/SenTestingKit.h>
#import "IRNotificationMap.h"


@interface IRNotificationMapTests : SenTestCase
{
    @private
        NSNotificationCenter *notificationCenter;
        IRNotificationMap *notificationMap;
        BOOL notificationReceived;
        int listenerResponseCount;
}
-(void)resetNotificationWasRecieved;
-(void)notificationWasReceived:(NSNotification *)notification;

@end
