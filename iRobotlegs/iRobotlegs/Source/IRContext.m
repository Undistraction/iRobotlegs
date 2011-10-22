//
//  IRContext.m
//  iRobotlegs
//
//  Created by Pedr Browne on 20/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRContext.h"
#import "IRConstants.h"
#import "IRInjectorProtocol.h"
#import "IRCommandMapProtocol.h"
#import "IRCommandMapProtocol.h"
#import "IRObjectionInjector.h"

@interface IRContext()

    -(void)checkAutoStartup;

@end

@implementation IRContext

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize notificationCenter = notificationCenter_;
@synthesize injector = injector_;
@synthesize autoStartup = autoStartup_;
@synthesize commandMap = commandMap_;
@synthesize mediatorMap = mediatorMap_;

-(NSNotificationCenter *)notificationCenter
{
    if(!notificationCenter_)
    {
        self.notificationCenter = [[[NSNotificationCenter alloc] init] autorelease];
    }
    return notificationCenter_;
}

-(id<IRInjector> )injector
{
    if(!injector_)
        self.injector = [[[IRObjectionInjector alloc] init] autorelease];
    return injector_;
}

-(id<IRCommandMap>)commandMap
{
    if(!commandMap_)
        self.commandMap = [[[IRCommandMap alloc] initWithNotificationCenter:self.notificationCenter injector:self.injector]autorelease];
    return commandMap_;
}

-(id<IRMediatorMap>)mediatorMap
{
    if(!mediatorMap_)
        self.mediatorMap = [[[IRMediatorMap alloc] initWithInjector: self.injector notificationCenter:self.notificationCenter] autorelease];
    return mediatorMap_;
}


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

-(id)initWithAutoStartUp:(BOOL)autoStartup
{
    self = [super init];
    if (self)
    {
        self.autoStartup = autoStartup;
        [self mapInjections];
        [self checkAutoStartup];
    }
    if(self.autoStartup)
        [self startup];
    return self;
}

- (id)init
{
    return [self initWithAutoStartUp: YES];
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc 
{
    self.notificationCenter = nil;
    self.injector = nil;
    self.commandMap = nil;
    self.mediatorMap = nil;
    
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)startup
{
    NSNotification *notification = [NSNotification notificationWithName:CONTEXT_STARTUP_COMPLETE 
                                                                 object:self];
    [self.notificationCenter postNotification:notification];
}

-(void)shutdown
{
    NSNotification *notification = [NSNotification notificationWithName:CONTEXT_SHUTDOWN_COMPLETE 
                                                                 object:self];
    [self.notificationCenter postNotification:notification];
}

-(void)mapInjections
{
    [self.injector whenAskedForProtocol:@protocol(IRInjector) supplyInstance:self.injector];
    [self.injector whenAskedForClass:[NSNotificationCenter class] supplyInstance:self.notificationCenter];
    [self.injector whenAskedForProtocol:@protocol(IRCommandMap) supplyInstance:self.commandMap];
    [self.injector whenAskedForProtocol:@protocol(IRMediatorMap) supplyInstance:self.mediatorMap];
    
}

//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)checkAutoStartup
{
    //TODO: I think this method is pointless
}


@end
