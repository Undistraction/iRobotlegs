//
//  ObjectionInjector.m
//  iRobotlegs
//
//  Created by Pedr Browne on 20/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRObjectionInjector.h"
#import <Objection-iOS/Objection.h>
#import "IRObjectionInjectorException.h"

@interface IRObjectionInjector ()

    @property (retain, nonatomic) JSObjectionInjector *injector;
    -(void)injectWithModule:(JSObjectionModule *)module;

@end

@implementation IRObjectionInjector

//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

@synthesize injector = injector_;

- (id)init
{
    self = [super init];
    if (self) {
        self.injector = [JSObjection createInjector];
        
    }
    
    return self;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc {
    self.injector = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(id)getObjectForClass:(Class)clazz
{
    if(![JSObjection hasClass:clazz])
    {
        [self whenAskedForClassSupplySameClass:clazz];
    }
        
    return [self.injector getObject: clazz];
}

-(id)getObjectForProtocol:(Protocol *)protocol
{
    return [self.injector getObject: protocol];
}

-(void)whenAskedForClassSupplySameClass:(Class)clazz
{
    [JSObjection registerClass:clazz];
}

-(void)whenAskedForClass:(Class)clazz supplyClass:(Class)mappedClazz
{
    if(![mappedClazz isSubclassOfClass:clazz])
        @throw [[[IRObjectionInjectorException alloc] initWithName:E_INJECTOR_MUST_SUBCLASS_NAME 
                                                            reason:E_INJECTOR_MUST_SUBCLASS_REASON
                                                          userInfo:nil] autorelease];

    [JSObjection registerClass: mappedClazz];
    JSObjectionModule *module = [[[JSObjectionModule alloc] init] autorelease];
    [module bindClass:mappedClazz toClass:clazz];
    [module configure];
    [self injectWithModule: module];
}

-(void)whenAskedForClass:(Class)clazz supplyInstance:(id)instance
{
    JSObjectionModule *module = [[[JSObjectionModule alloc] init] autorelease];
    [module bind:instance toClass:clazz];
    [module configure];
    [self injectWithModule: module];
}

-(void)whenAskedForProtocol:(Protocol *)protocol supplyInstance:(id)instance
{
    JSObjectionModule *module = [[[JSObjectionModule alloc] init] autorelease];
    [module bind:instance toProtocol:protocol];
    [module configure];
    [self injectWithModule: module];
}

-(void)whenAskedForProtocol:(Protocol *)protocol supplyClass:(Class)clazz
{
    [JSObjection registerClass:clazz];
    JSObjectionModule *module = [[[JSObjectionModule alloc] init] autorelease];
    [module bindClass:clazz toProtocol:protocol];
    [module configure];
    [self injectWithModule: module];
}

-(void)mapSingleton:(Class)clazz;
{
    [JSObjection registerSingletonClass: clazz];
    [JSObjection registerSingletonClass:clazz];
}

-(void)whenAskedForProtocol:(id)protocol supplySingletonOfClass:(Class)clazz
{
    [JSObjection registerSingletonClass: clazz];
    JSObjectionModule *module = [[[JSObjectionModule alloc] init] autorelease];
    [module bindClass:clazz toProtocol:protocol];
    [module configure];
    [self injectWithModule: module];
}

-(void)whenAskedForClass:(Class)clazz supplySingletonOfClass:(Class)singletonClass
{
    [JSObjection registerSingletonClass: singletonClass];
    JSObjectionModule *module = [[[JSObjectionModule alloc] init] autorelease];
    [module bindClass:singletonClass toClass:clazz];
    [module configure];
    [self injectWithModule: module];
}

-(void)unmapClass:(Class)clazz
{
    [JSObjection removeClass: clazz];
}

-(void)unmapProtocol:(Protocol *)protocol
{
    [JSObjection removeProtocol:protocol];
}

-(void)unmapAllClasses
{
    [JSObjection reset];
}

//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)injectWithModule:(JSObjectionModule *)module
{
    [JSObjection createInjector:module];
}


@end
