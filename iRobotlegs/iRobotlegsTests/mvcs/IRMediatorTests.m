//
//  IRMediatorTests.m
//  iRobotlegs
//
//  Created by Pedr Browne on 18/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "TestNotification.h"

// Class under test
#import "IRMediator.h"

// Test support
#define HC_SHORTHAND
#import <SenTestingKit/SenTestingKit.h>
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@interface IRMediatorTests : SenTestCase
{
    @private
        IRMediator *mediator;
        NSNotificationCenter *notificationCenter;
        NSNotification *notification;
        NSNotification *receivedNotification;
}
@end

@implementation IRMediatorTests

//------------------------------------------------------------------------------
//  SetUp / TearDown
//------------------------------------------------------------------------------ 

-(void) setUp
{
    mediator = [[IRMediator alloc] init];
    notificationCenter = [[NSNotificationCenter alloc] init];
    mediator.notificationCenter = notificationCenter;
    notification = [NSNotification notificationWithName:TEST_NOTIFICATION_NAME object: self];
    receivedNotification = nil;
    [notification retain];
}

-(void) tearDown
{
    [mediator release];
    [notificationCenter release];
    [notification release];
}


//------------------------------------------------------------------------------
//  Tests
//------------------------------------------------------------------------------ 

- (void)testHasNotificationCenter
{
    assertThat(mediator.notificationCenter, is(notNilValue()));
    assertThat(mediator.notificationCenter, is(equalTo(notificationCenter)));
}

-(void)testNotificationMapGetter
{
    assertThat(mediator.notificationMap, is(sameInstance(mediator.notificationMap)));
}


//------------------------------------------------------------------------------
//  Supporting Methods
//------------------------------------------------------------------------------ 

-(void)testNotificationReceived:(NSNotification *)pNotification
{
    [notificationCenter removeObserver:self];
    receivedNotification = [pNotification retain];
}

@end
