//
//  IRNotificationMapTests.m
//  iRobotlegs
//
//  Created by Pedr Browne on 28/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRNotificationMapTests.h"
#import "NotificationNameConstants.h"

//Collaborators
#import "TestNotification.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@implementation IRNotificationMapTests

//------------------------------------------------------------------------------
//  SetUp / TearDown
//------------------------------------------------------------------------------
 
-(void)setUp
{
    notificationCenter = [[NSNotificationCenter alloc] init];
    notificationMap = [[IRNotificationMap alloc] initWithNotificationCenter: notificationCenter];
    
}

-(void)tearDown
{
    [notificationMap release];
    [notificationCenter release];
    [self resetNotificationWasRecieved];
}


//------------------------------------------------------------------------------
//  Tests
//------------------------------------------------------------------------------

-(void)testNoObserver
{
    NSNotification *notification = [NSNotification notificationWithName:TEST_NOTIFICATION_NAME_ONE object:self];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(NO)));
}

-(void)testMapObserversNormal
{
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME_ONE
               notificationClass:nil
              notificationCenter:notificationCenter];
          
    NSNotification *notification = [NSNotification notificationWithName:TEST_NOTIFICATION_NAME_ONE object:self];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(YES)));
    [self resetNotificationWasRecieved];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(YES)));
}

-(void)testMapObserversStrong
{
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME
               notificationClass:[TestNotification class]
              notificationCenter:notificationCenter];
    NSNotification *notification = [[TestNotification alloc] initWithObject:self];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(YES)));
}

-(void)testmapObserverTwice
{
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME
               notificationClass:[TestNotification class]
              notificationCenter:notificationCenter];
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME
               notificationClass:[TestNotification class]
              notificationCenter:notificationCenter];
    NSNotification *notification = [[TestNotification alloc] initWithObject:self];
    [notificationCenter postNotification:notification];
    assertThatInt(listenerResponseCount, is(equalToInt(1)));
    [notificationMap unmapObserver:self
                          selector:@selector(notificationWasReceived:) 
                  notificationName:TEST_NOTIFICATION_NAME
                 notificationClass:[TestNotification class]
                notificationCenter:notificationCenter];
    [self resetNotificationWasRecieved];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(NO)));
}

-(void)testUnmapObserversNormal
{
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME
               notificationClass:nil
              notificationCenter:notificationCenter];
    [notificationMap unmapObserver:self 
                          selector:@selector(notificationWasReceived:)
                  notificationName:TEST_NOTIFICATION_NAME
                 notificationClass:nil
                notificationCenter:notificationCenter];
    NSNotification *notification = [NSNotification notificationWithName:TEST_NOTIFICATION_NAME object:self];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(NO)));
    NSNotification *notificationStrong = [[TestNotification alloc] initWithObject:self];
    [notificationCenter postNotification:notificationStrong];
    assertThatBool(notificationReceived, is(equalToBool(NO)));
}

-(void)testUnmapObserversStrong
{
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME
               notificationClass:[TestNotification class]
              notificationCenter:notificationCenter];
    [notificationMap unmapObserver:self 
                          selector:@selector(notificationWasReceived:)
                  notificationName:TEST_NOTIFICATION_NAME
                 notificationClass:nil
                notificationCenter:notificationCenter];
    NSNotification *notification = [[TestNotification alloc] initWithObject:self];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(YES)));
    [self resetNotificationWasRecieved];
    [notificationMap unmapObserver:self 
                          selector:@selector(notificationWasReceived:)
                  notificationName:TEST_NOTIFICATION_NAME
                 notificationClass:[TestNotification class]
                notificationCenter:notificationCenter];
    NSNotification *notification2 = [[TestNotification alloc] initWithObject:self];;
    [notificationCenter postNotification:notification2];
    assertThatBool(notificationReceived, is(equalToBool(NO)));
}

-(void)testUnmapObservers
{
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME
               notificationClass:nil
              notificationCenter:notificationCenter];
    [notificationMap mapObserver:self 
                        selector:@selector(notificationWasReceived:)
                notificationName:TEST_NOTIFICATION_NAME
               notificationClass:[TestNotification class]
              notificationCenter:notificationCenter];
    [notificationMap unmapObservers];
    NSNotification *notification = [NSNotification notificationWithName:TEST_NOTIFICATION_NAME object:self];
    [notificationCenter postNotification:notification];
    assertThatBool(notificationReceived, is(equalToBool(NO)));
    NSNotification *notificationStrong = [[TestNotification alloc] initWithObject:self];
    [notificationCenter postNotification:notificationStrong];
    assertThatBool(notificationReceived, is(equalToBool(NO)));
}



/*

		
		[Test]
		public function unmapListeners():void
		{
			eventMap.mapListener(eventDispatcher, CustomEvent.STARTED, listener);
			eventMap.mapListener(eventDispatcher, CustomEvent.STARTED, listener, CustomEvent);
			eventMap.unmapListeners();
			eventDispatcher.dispatchEvent(new Event(CustomEvent.STARTED));
			Assert.assertFalse('Listener should NOT have reponded to plain event', listenerExecuted);
			eventDispatcher.dispatchEvent(new CustomEvent(CustomEvent.STARTED));
			Assert.assertFalse('Listener should NOT have reponded to strong event', listenerExecuted);
		}

		

        
*/

//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)resetNotificationWasRecieved
{
    notificationReceived = NO;
    listenerResponseCount = 0;
}

-(void)notificationWasReceived:(NSNotification *)notification
{
    notificationReceived = YES;
    listenerResponseCount++;
}


@end
