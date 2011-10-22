//
//  IRCommandMap.m
//  iRobotlegs
//
//  Created by Pedr Browne on 19/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRCommandMap.h"
#import "IRCommandProtocol.h"
#import "IRContextException.h"
#import "IRCallback.h"

@interface IRCommandMap()

@property (retain, nonatomic) NSMutableDictionary *notificationNameMap;
@property (retain, nonatomic) NSMutableSet *verifiedCommandClasses;
@property (retain, nonatomic) NSMutableSet *detainedCommands;


-(void)notificationPosted:(NSNotification *)notification;
-(void)verifyCommandClass:(Class)commandClass;
-(BOOL)routeNotificationToCommand:(NSNotification *)notification 
                     commandClass:(Class)commandClass
                          oneshot:(BOOL)oneshot 
        originalNotificationClass:(Class)originalNotificationClass;
@end

@implementation IRCommandMap

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize injector = injector_;
@synthesize notificationCenter = notificationCenter_;
@synthesize notificationNameMap = notificationTypeMap_;
@synthesize verifiedCommandClasses = verifiedCommandClasses_;
@synthesize detainedCommands = detainedCommands_;

-(NSMutableDictionary *)notificationNameMap
{
    if(!notificationTypeMap_)
        self.notificationNameMap = [[[NSMutableDictionary alloc] init] autorelease];
    return notificationTypeMap_;
}

-(NSMutableSet *)verifiedCommandClasses
{
    if(!verifiedCommandClasses_)
        self.verifiedCommandClasses = [[[NSMutableSet alloc] init] autorelease];
    return verifiedCommandClasses_;
}

-(NSMutableSet *)detainedCommands
{
    if(!detainedCommands_)
        self.detainedCommands = [[[NSMutableSet alloc] init] autorelease];
    return detainedCommands_;
}


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

- (id)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
                        injector:(id<IRInjector>)injector
{
    self = [super init];
    if (self) {
        self.notificationCenter = notificationCenter;
        self.injector = injector;
    }
    
    return self;
}

-(id)init
{
    return [self initWithNotificationCenter:nil injector:nil];
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc {
    self.injector = nil;
    self.notificationCenter = nil;
    self.notificationNameMap = nil;
    self.verifiedCommandClasses = nil;
    self.detainedCommands = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------

-(void)mapNotification:(NSString *)notificationName
          commandClass:(Class)commandClass 
     notificationClass:(Class)notificationClass
               oneshot:(BOOL)oneshot
{
   
    [self verifyCommandClass:commandClass];
    if(!notificationClass || notificationClass == [NSNotification class])
        notificationClass = [NSNotification class];
    
    NSMutableDictionary *notificationClassMap = [self.notificationNameMap valueForKey: notificationName];
    if(!notificationClassMap)
    {
        notificationClassMap = [[[NSMutableDictionary alloc] init] autorelease];
        [self.notificationNameMap setValue: notificationClassMap forKey: notificationName];
    }
    
    NSMutableDictionary *callbackDataByCommandClass = [notificationClassMap objectForKey: notificationClass];
    if(!callbackDataByCommandClass)
    {
        callbackDataByCommandClass = [[[NSMutableDictionary alloc] init] autorelease];
        [notificationClassMap setObject:callbackDataByCommandClass forKey:notificationClass];
    }
    if([callbackDataByCommandClass objectForKey: commandClass])
    {
        @throw [[[IRContextException alloc] initWithName:E_COMMANDMAP_OVR_NAME 
                                                  reason:E_COMMANDMAP_OVR_REASON 
                                                userInfo:nil] autorelease];
    }
    IRCallback *callbackData = [[[IRCallback alloc] init] autorelease];
    callbackData.oneshot = oneshot;
    callbackData.notificationClass = notificationClass;
    [callbackDataByCommandClass setObject:callbackData forKey:commandClass];
    [self.notificationCenter addObserver:self selector:@selector(notificationPosted:) name:notificationName object:nil];
}

-(void)notificationPosted:(NSNotification *)notification
{
    NSMutableDictionary *notificationClassMap = [self.notificationNameMap valueForKey: notification.name];
    
    // NSNotifications are actually NSConcreteNotifications so we need to convert the class to NSNotification as 
    //this will be what was used to map the notification as most people don't know this and it is a private class anyhow.
    Class notificationClass = [notification class];
    if([notification isKindOfClass:[NSClassFromString(@"NSConcreteNotification") class]])
        notificationClass = [NSNotification class];
    //If a Notification type is not sprecified when mapped the type defaults to NSNotification. So if the concrete 
    //type of the notification does not match, we check for generic NSNotification matches.
    NSMutableDictionary *callbackDataByCommandClass = [notificationClassMap objectForKey: notificationClass];
    
    if(!callbackDataByCommandClass)
        callbackDataByCommandClass = [notificationClassMap objectForKey: [NSNotification class]];
    for (Class commandClass in callbackDataByCommandClass)
    {
        IRCallback *callbackData = [callbackDataByCommandClass objectForKey:commandClass];
        if(callbackData)
        {
            [self routeNotificationToCommand:notification 
                                commandClass:commandClass
                                     oneshot:callbackData.oneshot
                   originalNotificationClass:callbackData.notificationClass];
        }
    }
}

-(void)unmapNotification:(NSString *)notificationName
            commandClass:(Class)commandClass 
       notificationClass:(Class)notificationClass
{
    NSMutableDictionary *notificationClassMap = [self.notificationNameMap valueForKey:notificationName];
    if(!notificationClassMap)
        return;
        
    if(!notificationClass)
        notificationClass = [NSNotification class];
    NSMutableDictionary *callbackDataByCommandClass = [notificationClassMap objectForKey: notificationClass];
    IRCallback *callbackData = [callbackDataByCommandClass objectForKey: commandClass];
    if(!callbackData)
        return;
    [self.notificationCenter removeObserver:self name:notificationName object:nil];
    [callbackDataByCommandClass removeObjectForKey:commandClass];
}

-(void)unmapNotifications
{
    for (NSString *notificationName in self.notificationNameMap)
    {
        [self.notificationCenter removeObserver:self name:notificationName object:nil];
    }
    self.notificationNameMap = [[[NSMutableDictionary alloc] init ] autorelease];
}

-(BOOL)hasNotificationCommand:(NSString *)notificationName 
                 commandClass:(Class)commandClass
            notificationClass:(Class)notificationClass
{            
    if(!notificationClass)
        notificationClass = [NSNotification class];
    NSMutableDictionary *notificationClassMap = [self.notificationNameMap valueForKey: notificationName];
    if(!notificationClassMap)
        return NO;
    NSMutableDictionary *callbackDataByCommandClass = [notificationClassMap objectForKey: notificationClass];
    if(!callbackDataByCommandClass)
        return NO;
    return [callbackDataByCommandClass objectForKey: commandClass] != nil;
}

-(void)execute:(Class)commandClass payload:(id)payload payloadClass:(Class)payloadClass
{
    [self verifyCommandClass:commandClass];
    if(payload || payloadClass)
    {
        if(!payloadClass)
        {
            payloadClass = [payload class];
        }
        //Trying to init an NSConcreteNotification will raise an exception. We need to
        //init an NSNotification to get an NSConcreteNotification
        BOOL isConcrete = payloadClass == [NSClassFromString(@"NSConcreteNotification") class];
        if(isConcrete)
        {
            payloadClass = [NSNotification class];
        }
        [self.injector whenAskedForClass:payloadClass supplyInstance:payload];
        
    }
    id<IRCommand>command = [self.injector getObjectForClass: commandClass];
    if(payload || payloadClass)
        [self.injector unmapClass:payloadClass];
        
    [command execute];
}

-(void)releaseCommand:(id<IRCommand>)command
{
    if([self.detainedCommands containsObject:command])
        [self.detainedCommands removeObject:command];
}

-(void)retainCommand:(id<IRCommand>)command
{
    [self.detainedCommands addObject:command];
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)verifyCommandClass:(Class)commandClass
{
    NSString *key = NSStringFromClass(commandClass);
    if(![self.verifiedCommandClasses containsObject: key])
    {
        if([commandClass conformsToProtocol:@protocol(IRCommand)])
        {
            [self.verifiedCommandClasses addObject:key];
        }
        else
        {
           @throw [[[IRContextException alloc] initWithName:E_COMMANDMAP_NOIMPL_NAME 
                                                     reason:E_COMMANDMAP_NOIMPL_REASON 
                                                   userInfo:nil] autorelease];
        }
    }
}

-(BOOL)routeNotificationToCommand:(NSNotification *)notification 
                     commandClass:(Class)commandClass
                          oneshot:(BOOL)oneshot 
        originalNotificationClass:(Class)originalNotificationClass
{
    if (![notification isKindOfClass: originalNotificationClass] && ![notification isMemberOfClass: originalNotificationClass]) 
        return NO;
    [self execute:commandClass payload:notification payloadClass:nil];
        
	if (oneshot) 
        [self unmapNotification:notification.name commandClass:commandClass notificationClass:originalNotificationClass];
			
	return YES;
}



@end

