//
//  IRCommandMapTests.m
//  iRobotlegs
//
//  Created by Pedr Browne on 18/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRCommandMapTestsWithNotificationType.h"
#import "IRContextException.h"
// Class under test
#import "IRCommandMap.h"

// Collaborators
#import "TestNotification.h"
#import "TestCommand.h"
#import "NotificationNameConstants.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@implementation IRCommandMapTestsWithNotificationType

//------------------------------------------------------------------------------
//  SetUp / TearDown
//------------------------------------------------------------------------------
 
-(void)setUp
{
    commandExecuted = NO;
    injector = [[IRObjectionInjector alloc] init ];
    notificationCenter = [[NSNotificationCenter alloc] init];
    commandMap = [[IRCommandMap alloc] init ];
    commandMap.injector = injector;
    commandMap.notificationCenter = notificationCenter;
    [injector whenAskedForProtocol:@protocol(IRCommand) supplyClass:[TestCommand class]];
    [injector whenAskedForProtocol:@protocol(IRCommandMapTests) supplyInstance:self];
}

-(void)tearDown
{
    [commandMap release];
    [injector release];
    [notificationCenter release];
}


//------------------------------------------------------------------------------
//  Tests
//------------------------------------------------------------------------------

-(void)testNoCommand
{
    TestNotification *notification = [[TestNotification alloc] initWithObject:self];
    [notificationCenter postNotification: notification];
    assertThatBool(commandExecuted, is(equalToBool(NO)));
}

-(void)testHasCommand
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[TestNotification class] 
                        oneshot:NO];
                        
    BOOL hasCommand = [commandMap hasNotificationCommand:TEST_NOTIFICATION_NAME 
                                            commandClass:[TestCommand class]
                                       notificationClass:[TestNotification class]];
                     
    assertThatBool(hasCommand, is(equalToBool(YES)));
}

-(void)testNormalCommand
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME object:self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
}

-(void)testNormalCommandwithNSNotificationSubclass
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[TestNotification class] 
                        oneshot:NO];
    [notificationCenter postNotification:[[TestNotification alloc] initWithObject: self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
}

-(void)testNormalCommandRepeated
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[TestNotification class] 
                        oneshot:NO];
    [notificationCenter postNotification:[[TestNotification alloc] initWithObject: self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
    commandExecuted = NO;
    [notificationCenter postNotification:[[TestNotification alloc] initWithObject: self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
}

-(void)testOneShotCommand
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[TestNotification class] 
                        oneshot:YES];
    [notificationCenter postNotification:[[TestNotification alloc] initWithObject: self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
    commandExecuted = NO;
    [notificationCenter postNotification:[[TestNotification alloc] initWithObject: self]];
    assertThatBool(commandExecuted, is(equalToBool(NO)));
}

-(void)testNormalCommandRemoved
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[TestNotification class] 
                        oneshot:NO];
    [notificationCenter postNotification:[[TestNotification alloc] initWithObject: self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
    commandExecuted = NO;
    [commandMap unmapNotification:TEST_NOTIFICATION_NAME 
                     commandClass:[TestCommand class] 
                notificationClass:[TestNotification class]];
    [notificationCenter postNotification:[[TestNotification alloc] initWithObject: self]];
    assertThatBool(commandExecuted, is(equalToBool(NO)));
}

-(void)testMultipleEvents
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME_ONE
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_TWO
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_THREE
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_FOUR
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_FIVE
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
                        
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_ONE object:self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
    commandExecuted = NO;
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_TWO object:self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
    commandExecuted = NO;
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_THREE object:self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
    commandExecuted = NO;
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_FOUR object:self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
    commandExecuted = NO;
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_FIVE object:self]];
    assertThatBool(commandExecuted, is(equalToBool(YES)));
}

-(void)testUnmapEvents
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME_ONE
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_TWO
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_THREE
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_FOUR
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
     [commandMap mapNotification:TEST_NOTIFICATION_NAME_FIVE
                   commandClass:[TestCommand class]
              notificationClass:[NSNotification class] 
                        oneshot:NO];
    [commandMap unmapNotifications];
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_ONE object:self]];
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_TWO object:self]];
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_THREE object:self]];
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_FOUR object:self]];
    [notificationCenter postNotification:[NSNotification notificationWithName:TEST_NOTIFICATION_NAME_FIVE object:self]];
    assertThatBool(commandExecuted, is(equalToBool(NO)));
}

-(void)testmappingNonCommandClassShouldFail
{
    STAssertThrowsSpecific([commandMap mapNotification:TEST_NOTIFICATION_NAME_ONE
                   commandClass:[NSString class]
              notificationClass:[NSNotification class] 
                        oneshot:NO], IRContextException, nil);
}

-(void)testmappingSamCommandTwiceShouldFail
{
    [commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[TestNotification class] 
                        oneshot:NO];  
    STAssertThrowsSpecific([commandMap mapNotification:TEST_NOTIFICATION_NAME
                   commandClass:[TestCommand class]
              notificationClass:[TestNotification class] 
                        oneshot:NO], IRContextException, nil);
}

//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)commandDidExecute
{
    commandExecuted = YES;
}

@end
