//
//  iRobotlegs - ActorTests.m
//  Copyright (c) 2011 the original author or authors

//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//
//  Created by: Pedr Browne
//

#import "TestNotification.h"

// Class under test
#import "IRActor.h"

// Test support
#define HC_SHORTHAND
#import <SenTestingKit/SenTestingKit.h>
#import <OCHamcrestIOS/OCHamcrestIOS.h>


@interface IRActorTests : SenTestCase
{
    @private
        IRActor *actor;
        NSNotificationCenter *notificationCenter;
        NSNotification *notification;
        NSNotification *receivedNotification;
}

@end

@implementation IRActorTests


//------------------------------------------------------------------------------
//  SetUp / TearDown
//------------------------------------------------------------------------------ 

-(void) setUp
{
    actor = [[IRActor alloc] init];
    notificationCenter = [[NSNotificationCenter alloc] init];
    actor.notificationCenter = notificationCenter;
    notification = [NSNotification notificationWithName:TEST_NOTIFICATION_NAME object: self];
    receivedNotification = nil;
    [notification retain];
}

-(void) tearDown
{
    [actor release];
    [notificationCenter release];
    [notification release];
}


//------------------------------------------------------------------------------
//  Tests
//------------------------------------------------------------------------------ 

- (void)testHasNotificationCenter
{
    assertThat(actor.notificationCenter, is(notNilValue()));
    assertThat(actor.notificationCenter, is(equalTo(notificationCenter)));
}

-(void)testCanSendNotification
{
    [notificationCenter addObserver:self 
                           selector:@selector(testNotificationReceived:) 
                               name:TEST_NOTIFICATION_NAME 
                             object:nil];
                             
    [actor post:notification];
    assertThat(receivedNotification, is(notNilValue()));
    assertThat(receivedNotification, is(sameInstance(notification)));
    [receivedNotification release];
}

-(void)testNotificationMapGetter
{
    assertThat(actor.notificationMap, is(sameInstance(actor.notificationMap)));
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