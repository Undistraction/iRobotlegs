//
//  IRObjectionAdapterTests.m
//  iRobotlegs
//
//  Created by Pedr Browne on 18/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

// Class under test
#import "IRObjectionInjector.h"

#import "IRObjectionInjectorException.h"

// Collaborators
#import "TestClassUnrelated.h"
#import "TestClassUnrelatedOther.h"
#import "TestProtocol.h"
#import "TestClassImplementsProtocol.h"
#import "TestSuperclass.h"
#import "TestSubclass.h"
#import <Objection-iOS/Objection.h>

// Test support
#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@interface IRObjectionAdapterTests : SenTestCase
{
    @private
        IRObjectionInjector *injector;
}
@end

@implementation IRObjectionAdapterTests

//------------------------------------------------------------------------------
//  SetUp / TearDown
//------------------------------------------------------------------------------ 

-(void)setUp
{
    injector = [[IRObjectionInjector alloc] init ];
}

//------------------------------------------------------------------------------
//  Tests
//------------------------------------------------------------------------------ 

-(void)tearDown
{
    [injector release];
    [JSObjection reset];
}

- (void)testmappedClassToClassWithWrongClass
{
    [injector whenAskedForClassSupplySameClass:[TestClassUnrelated class]];
    BOOL isSameClass = [[injector getObjectForClass:[TestClassUnrelated class]] isKindOfClass: [TestClassUnrelatedOther class]];
    assertThatBool(isSameClass, is(equalToBool(NO)));
}

- (void)testmappedClassToSameClass
{
    [injector whenAskedForClassSupplySameClass:[TestClassUnrelated class]];
    BOOL isSameClass = [[injector getObjectForClass:[TestClassUnrelated class]] isKindOfClass: [TestClassUnrelated class]];
    assertThatBool(isSameClass, is(equalToBool(YES)));
}

-(void)testMappedClassToInstance
{
    TestClassUnrelated *firstInstance = [[TestClassUnrelated alloc] init];
    [injector whenAskedForClass:[TestClassUnrelated class] supplyInstance: firstInstance];
    BOOL instanceOneIsSameInstance = [[injector getObjectForClass:[TestClassUnrelated class]] isEqual: firstInstance];
    assertThatBool(instanceOneIsSameInstance, is(equalToBool(YES)));
}

-(void)testUnmappedClassToInstance
{
    TestClassUnrelated *instance = [[TestClassUnrelated alloc] init];
    [injector whenAskedForClass:[TestClassUnrelated class] supplyInstance: instance];
    BOOL instanceIsSameInstance = [[injector getObjectForClass:[TestClassUnrelated class]] isEqual: instance];
    assertThatBool(instanceIsSameInstance, is(equalToBool(YES)));
    [injector unmapClass: [TestClassUnrelated class]];
    instanceIsSameInstance = [[injector getObjectForClass:[TestClassUnrelated class]] isEqual: instance];
    assertThatBool(instanceIsSameInstance, is(equalToBool(NO)));
}

-(void)testSingleton
{
    [injector mapSingleton:[TestClassUnrelated class]];
    TestClassUnrelated *firstInstance = [injector getObjectForClass:[TestClassUnrelated class]];
    BOOL isSameClass = [firstInstance isKindOfClass: [TestClassUnrelated class]];
    assertThatBool(isSameClass, is(equalToBool(YES)));
    id secondInstance = [injector getObjectForClass:[TestClassUnrelated class]];
    isSameClass = [secondInstance isKindOfClass: [TestClassUnrelated class]];
    assertThatBool(isSameClass, is(equalToBool(YES)));
    BOOL isSameInstance = [firstInstance isEqual: secondInstance];
    assertThatBool(isSameInstance, is(equalToBool(YES)));
}

-(void)testMappedProtocolToClass
{
    [injector whenAskedForProtocol:@protocol(TestProtocol) supplyClass:[TestClassImplementsProtocol class]];
    id instance = [injector getObjectForProtocol:@protocol(TestProtocol)];
    BOOL isCorrectClass = [instance isKindOfClass:[TestClassImplementsProtocol class]];
    assertThatBool(isCorrectClass, is(equalToBool(YES)));
}

-(void)testUnmapProtocolToClass
{
    [injector whenAskedForProtocol:@protocol(TestProtocol) supplyClass:[TestClassImplementsProtocol class]];
    id instance = [injector getObjectForProtocol:@protocol(TestProtocol)];
    BOOL isCorrectClass = [instance isKindOfClass:[TestClassImplementsProtocol class]];
    assertThatBool(isCorrectClass, is(equalToBool(YES)));
    [injector unmapProtocol:@protocol(TestProtocol)];
    instance = [injector getObjectForProtocol:@protocol(TestProtocol)];
    assertThat(instance, is(nilValue()));
}

-(void)testMappedProtocolToInstance
{
    TestClassImplementsProtocol *firstInstance = [[TestClassImplementsProtocol alloc] init];
    [injector whenAskedForProtocol:@protocol(TestProtocol) supplyInstance: firstInstance];
    BOOL instanceOneIsSameInstance = [[injector getObjectForProtocol:@protocol(TestProtocol)] isEqual: firstInstance];
    assertThatBool(instanceOneIsSameInstance, is(equalToBool(YES)));
}

-(void)testUnmappedProtocolToInstance
{
    TestClassImplementsProtocol *instance = [[TestClassImplementsProtocol alloc] init];
    [injector whenAskedForProtocol:@protocol(TestProtocol) supplyInstance: instance];
    BOOL instanceIsSameInstance = [[injector getObjectForProtocol:@protocol(TestProtocol)] isEqual: instance];
    assertThatBool(instanceIsSameInstance, is(equalToBool(YES)));
    [injector unmapProtocol: @protocol(TestProtocol)];
    TestClassUnrelated *returnedInstance = [injector getObjectForProtocol:@protocol(TestProtocol)];
    assertThat(returnedInstance, is(nilValue()));
}

-(void)testUnmapAllClasses
{
    TestClassImplementsProtocol *firstInstance = [[TestClassImplementsProtocol alloc] init];
    [injector whenAskedForProtocol:@protocol(TestProtocol) supplyInstance: firstInstance];
    TestClassUnrelated *secondInstance = [[TestClassUnrelated alloc] init];
    [injector whenAskedForClass:[TestClassUnrelated class] supplyInstance: secondInstance];
    [injector unmapAllClasses];
    firstInstance = [injector getObjectForProtocol:@protocol(TestProtocol)];
    TestClassUnrelated *secondInstanceMatch = [injector getObjectForClass:[TestClassUnrelated class]];
    BOOL secondInstanceMatchesSecondInstance = [secondInstance isEqual: secondInstanceMatch];
    assertThat(firstInstance, is(nilValue()));
    assertThatBool(secondInstanceMatchesSecondInstance, is(equalToBool(NO)));
}

-(void)testmappedClassToClass
{
    [injector whenAskedForClass:[TestSuperclass class] supplyClass:[TestSubclass class]];
    BOOL isSameClass = [[injector getObjectForClass:[TestSuperclass class]] isKindOfClass: [TestSubclass class]];
    assertThatBool(isSameClass, is(equalToBool(YES)));
}

-(void)testIllegalMappedClassToClass
{
    STAssertThrowsSpecific([injector whenAskedForClass:[TestClassUnrelated class] supplyClass:[TestSubclass class]],IRObjectionInjectorException, nil);
}

-(void)testmappedClassToSingletonClass
{
    [injector whenAskedForClass:[TestSuperclass class] supplySingletonOfClass:[TestSubclass class]];
    id firstInstance = [injector getObjectForClass:[TestSuperclass class]];
    id secondInstance = [injector getObjectForClass:[TestSuperclass class]];
    BOOL isSameClass = [[injector getObjectForClass:[TestSuperclass class]] isKindOfClass: [TestSubclass class]];
    assertThatBool(isSameClass, is(equalToBool(YES)));
    BOOL isSameInstance = [firstInstance isEqual: secondInstance];
    assertThatBool(isSameInstance, is(equalToBool(YES)));
}


@end
