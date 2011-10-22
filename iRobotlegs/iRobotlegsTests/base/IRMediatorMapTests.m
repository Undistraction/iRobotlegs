//
//  iRobotlegs - IRMediatorMapTests.m
//  Copyright (c) 2011 the original author or authors

//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//
//  Created by: Pedr Browne
//
#import "IRConstants.h"

// Class under test
#import "IRMediatorMap.h"

//Collaborators
#import "TestMediatedObject.h"
#import "TestMediatedObjectSubclass.h"
#import "TestMediator.h"
#import "IRObjectionInjector.h"
#import <Objection-iOS/Objection.h>

// Test support
#define HC_SHORTHAND
#import <SenTestingKit/SenTestingKit.h>
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@interface IRMediatorMapTests : SenTestCase
{
    @private
        IRMediatorMap *mediatorMap;
        NSObject *mediatedObject;
        NSNotificationCenter *notificationCenter;
        IRObjectionInjector *injector;
        
}
@end

@interface  IRMediatorMapTests ()
    -(void)simulateMediatedObjectInitialised;
    -(void)simulateMediatedObjectDeallocated;

@end

@implementation IRMediatorMapTests

//------------------------------------------------------------------------------
//  SetUp / TearDown
//------------------------------------------------------------------------------
 
-(void)setUp
{
    injector = [[IRObjectionInjector alloc] init ];
    notificationCenter = [[NSNotificationCenter alloc] init];

    mediatorMap = [[IRMediatorMap alloc] initWithInjector:injector notificationCenter:notificationCenter];
    [injector whenAskedForProtocol:@protocol(IRInjector) supplyInstance: injector];
    [injector whenAskedForProtocol:@protocol(IRMediatorMap) supplyInstance: mediatorMap];
    
}

-(void)tearDown
{
    [injector release];
    [mediatorMap release];
    [mediatedObject release];
    [notificationCenter release];
    [JSObjection reset];
}


//------------------------------------------------------------------------------
//  Tests
//------------------------------------------------------------------------------

-(void)testMediatorCreatedForMediatedObject
{
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class] 
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:YES 
                             autoRemove:YES];
    mediatedObject = [[TestMediatedObject alloc] init];
    IRMediator *mediator = [mediatorMap createMediatorForMediatedObject:mediatedObject];
    assertThat(mediator, is(notNilValue()));
    assertThatBool([mediatorMap hasMediatorForMediatedObject: mediatedObject], is(equalToBool(YES)));
    assertThatBool([mediatorMap hasMappingForMediatedObject: mediatedObject], is(equalToBool(YES)));
}

-(void)testMediatorIsMappedAndCreatedWithInjectMediatedObjectAsClass
{
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:NO
                             autoRemove:NO];
    mediatedObject = [[TestMediatedObject alloc] init];
    id<IRMediator> mediator = [mediatorMap createMediatorForMediatedObject:mediatedObject];
    assertThat(mediator, is(notNilValue()));
    BOOL isCorrectClass = [mediator isKindOfClass: [TestMediator class]];
    assertThatBool(isCorrectClass, is(equalToBool(YES)));
    BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(YES)));
    assertThat(mediator.mediatedObject, is(notNilValue()));
    BOOL mediatedObjectIsCorrectType = [mediator.mediatedObject isMemberOfClass:[TestMediatedObject class]];
    assertThatBool(mediatedObjectIsCorrectType, is(equalToBool(YES)));
}

-(void)testMediatoIsMappedAndCreatedWithInjectMediatedObjectAsArrayOfSamClass
{
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:[[[NSArray alloc] initWithObjects:[TestMediatedObject class], nil] autorelease]
                             autoCreate:NO
                             autoRemove:NO];
     mediatedObject = [[TestMediatedObject alloc] init];
     id<IRMediator> mediator = [mediatorMap createMediatorForMediatedObject:mediatedObject];
     assertThat(mediator, is(notNilValue()));
     BOOL isCorrectClass = [mediator isMemberOfClass: [TestMediator class]];
     assertThatBool(isCorrectClass, is(equalToBool(YES)));
     BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
     assertThatBool(hasMediatorForMediatedObject, is(equalToBool(YES)));
     assertThat(mediator.mediatedObject, is(notNilValue()));
     BOOL mediatedObjectIsCorrectType = [mediator.mediatedObject isMemberOfClass:[TestMediatedObject class]];
     assertThatBool(mediatedObjectIsCorrectType, is(equalToBool(YES)));
}

-(void)testMediatoIsMappedAndCreatedWithInjectMediatedObjectAsArrayOfRelatedObjects
{
    [mediatorMap mapMediatedObjectClass:[TestMediatedObjectSubclass class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:[[[NSArray alloc] initWithObjects:[TestMediatedObject class], [TestMediatedObjectSubclass class], nil] autorelease]
                             autoCreate:NO
                             autoRemove:NO];
     mediatedObject = [[TestMediatedObjectSubclass alloc] init];
     id<IRMediator> mediator = [mediatorMap createMediatorForMediatedObject:mediatedObject];
     assertThat(mediator, is(notNilValue()));
     BOOL isCorrectClass = [mediator isKindOfClass: [TestMediator class]];
     assertThatBool(isCorrectClass, is(equalToBool(YES)));
     BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
     assertThatBool(hasMediatorForMediatedObject, is(equalToBool(YES)));
     assertThat(mediator.mediatedObject, is(notNilValue()));
     BOOL mediatedObjectIsCorrectType = [mediator.mediatedObject isKindOfClass:[TestMediatedObject class]];
     
     assertThatBool(mediatedObjectIsCorrectType, is(equalToBool(YES)));
     
     BOOL mediatedObjectIsCorrectSubtype = [mediator.mediatedObject isMemberOfClass:[TestMediatedObjectSubclass class]];
     assertThatBool(mediatedObjectIsCorrectSubtype, is(equalToBool(YES)));
}

-(void)testMediatorIsMappedAndRemoved
{
    mediatedObject = [[TestMediatedObject alloc] init];
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:NO
                             autoRemove:NO];
    id<IRMediator> mediator = [mediatorMap createMediatorForMediatedObject:mediatedObject];                        
    assertThat(mediator, is(notNilValue()));
    BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(YES)));
    assertThat(mediator.mediatedObject, is(notNilValue()));
    [mediatorMap removeMediator:mediator];
    BOOL hasMediator = [mediatorMap hasMediator: mediator];
     assertThatBool(hasMediator, is(equalToBool(NO)));
    hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(NO)));
}

-(void)testMediatorIsMappedAddedAndRemovedByView
{
    mediatedObject = [[TestMediatedObject alloc] init];
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:NO
                             autoRemove:NO];
    id<IRMediator> mediator = [mediatorMap createMediatorForMediatedObject:mediatedObject];
    assertThat(mediator, is(notNilValue()));
    BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(YES)));
    BOOL hasMediator = [mediatorMap hasMediator: mediator];
    assertThatBool(hasMediator, is(equalToBool(YES)));
    assertThat(mediator.mediatedObject, is(notNilValue()));
    [mediatorMap removeMediatorForMediatedObject:mediatedObject];
    hasMediator = [mediatorMap hasMediator: mediator];
    assertThatBool(hasMediator, is(equalToBool(NO)));
    hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(NO)));
}

-(void)testAutoRegister
{
    mediatedObject = [[TestMediatedObject alloc] init];
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:YES
                             autoRemove:NO];
    
   [self simulateMediatedObjectInitialised]; 
    BOOL hasMediatorForView = [mediatorMap hasMediatorForMediatedObject:mediatedObject];
    assertThatBool(hasMediatorForView, is(equalToBool(YES)));
    
    
}

-(void)testMediatorIsRemovedWithView
{
    mediatedObject = [[TestMediatedObject alloc] init];
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:NO
                             autoRemove:YES];
    id<IRMediator> mediator = [mediatorMap createMediatorForMediatedObject:mediatedObject];
    assertThat(mediator, is(notNilValue()));
    BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(YES)));
    BOOL hasMediator = [mediatorMap hasMediator: mediator];
    assertThatBool(hasMediator, is(equalToBool(YES)));
    [self simulateMediatedObjectDeallocated];
    hasMediator = [mediatorMap hasMediator: mediator];
    assertThatBool(hasMediator, is(equalToBool(NO)));
    hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(NO)));
}

-(void)testUnmapView
{
    mediatedObject = [[TestMediatedObject alloc] init];
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:NO
                             autoRemove:YES];
    [mediatorMap unmapMediatedObject:[TestMediatedObject class]];
    [self simulateMediatedObjectInitialised];
    BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(NO)));
    BOOL hasMappingForMediatedObject = [mediatorMap hasMappingForMediatedObject:mediatedObject];
    assertThatBool(hasMappingForMediatedObject, is(equalToBool(NO)));
}

-(void)testAutoRegisterUnregisterRegister
{
    mediatedObject = [[TestMediatedObject alloc] init];
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:YES
                             autoRemove:YES];
    [mediatorMap unmapMediatedObject:[TestMediatedObject class]];
    [self simulateMediatedObjectInitialised];
    BOOL hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(NO)));
    [self simulateMediatedObjectDeallocated];
    [mediatorMap mapMediatedObjectClass:[TestMediatedObject class]
                        toMediatorClass:[TestMediator class]
                 injectMediatedObjectAs:nil
                             autoCreate:YES
                             autoRemove:YES];
    [self simulateMediatedObjectInitialised];
    hasMediatorForMediatedObject = [mediatorMap hasMediatorForMediatedObject: mediatedObject];
    assertThatBool(hasMediatorForMediatedObject, is(equalToBool(YES)));
}   

//------------------------------------------------------------------------------
//  Supporting Methods
//------------------------------------------------------------------------------ 

-(void)simulateMediatedObjectInitialised
{
    NSNotification *notification = [NSNotification notificationWithName:OBJECT_ALLOCATED object:mediatedObject];
    [notificationCenter postNotification:notification];
}

-(void)simulateMediatedObjectDeallocated
{
    NSNotification *notification = [NSNotification notificationWithName:OBJECT_DEALLOCATED object:mediatedObject];
    [notificationCenter postNotification:notification];
}


@end
