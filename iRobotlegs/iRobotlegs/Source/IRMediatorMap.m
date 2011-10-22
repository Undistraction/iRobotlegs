//
//  IRMediatorMap.m
//  iRobotlegs
//
//  Created by Pedr Browne on 19/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <objc/runtime.h>
#import <Objection-iOS/Objection.h>
#import "IRMediatorMapping.h"
#import "IRMediatorMap.h"
#import "IRConstants.h"
#import "IRInjectorProtocol.h"
#import "IRMediatorProtocol.h"
#import "IRContextException.h"

@interface IRMediatorMap()

@property (retain, nonatomic) id<IRInjector> injector;
@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL isObserving;
@property (retain, nonatomic) NSNotificationCenter *notificationCenter;
@property (nonatomic) CFMutableDictionaryRef mediatorByMediatedObject;
@property (nonatomic) CFMutableDictionaryRef mappingByMediatedObject;
@property (retain, nonatomic) NSMutableDictionary *mappingByMediatedObjectClass;

-(void)addObservers;
-(void)removeObservers;
-(void)mediatedObjectWasAdded:(NSNotification *)notification;

-(id<IRMediator>)createMediatorUsing:(NSObject *)mediatedObject 
                 mediatedObjectClass:(Class)mediatedObject 
                              mediatorMapping:(IRMediatorMapping *)mediatorMapping;
@end

@implementation IRMediatorMap

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize injector = injector_;
@synthesize enabled = enabled_;
@synthesize isObserving = isObserving_;
@synthesize notificationCenter = notificationCenter_;
@synthesize mediatorByMediatedObject = mediatorByMediatedObject_;
@synthesize mappingByMediatedObject = mappingByMediatedObject_;
@synthesize mappingByMediatedObjectClass = mappingByMediatedObjectClass_;

-(void)setEnabled:(BOOL)enabled
{
    if(enabled != enabled_)
    {
        [self removeObservers];
        enabled_ = enabled;
        
        if([self.mappingByMediatedObjectClass count] == 0)
        {
            [self addObservers];
        }
    }
}

-(void)setMediatorByMediatedObject:(CFMutableDictionaryRef)mediatorByMediatedObject
{
    if(mediatorByMediatedObject != self.mediatorByMediatedObject)
    {
        if(self.mediatorByMediatedObject)
        {
            CFRelease(self.mediatorByMediatedObject);
        }
        mediatorByMediatedObject_ = mediatorByMediatedObject;
    }
}

-(void)setMappingByMediatedObject:(CFMutableDictionaryRef)mappingByMediatedObject
{
    if(mappingByMediatedObject != self.mappingByMediatedObject)
    {
        if(self.mappingByMediatedObject)
        {
            CFRelease(self.mappingByMediatedObject);
        }
        mappingByMediatedObject_ = mappingByMediatedObject;
    }
}

-(NSNotificationCenter *)notificationCenter
{
    if(!notificationCenter_)
    {
        self.notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return notificationCenter_;
}


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

//Designated Initializer
-(id) initWithInjector:(id<IRInjector>)injector notificationCenter:(NSNotificationCenter *)notificationCenter
{
    self = [super init];
    if (self)
    {
        self.injector = injector;
        self.notificationCenter = notificationCenter;
        //We don't want to retain our references to the mediated objects otherwise 
        //they will never be released. We want to let them be released and react to
        //it. I.E. We should never be in a situation where we are preventing a 
        //mediated object from being deallocated.
        self.mediatorByMediatedObject = CFDictionaryCreateMutable(NULL, 0, NULL, &kCFTypeDictionaryValueCallBacks);
		self.mappingByMediatedObject = CFDictionaryCreateMutable(NULL, 0, NULL, &kCFTypeDictionaryValueCallBacks);
		self.mappingByMediatedObjectClass = [[[NSMutableDictionary alloc] init] autorelease];
        self.enabled = YES;
        
    }
    return self;
}

- (id)init
{
    return [self initWithInjector:nil notificationCenter:nil];
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

-(void)dealloc
{
    self.mediatorByMediatedObject = nil;
    self.mappingByMediatedObject = nil;
    self.mappingByMediatedObjectClass = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------

-(void) mapMediatedObjectClass:(Class)mediatedObjectClass 
               toMediatorClass:(Class)mediatorClass 
        injectMediatedObjectAs:(id)injectMediatedObjectAs
                    autoCreate:(BOOL)autoCreate
                    autoRemove:(BOOL)autoRemove
{
    if (CFDictionaryGetValue((CFDictionaryRef)self.mappingByMediatedObjectClass, mediatedObjectClass))
    {
        @throw [[[IRContextException alloc] initWithName:E_MEDIATORMAP_OVR_NAME 
                                                  reason:E_MEDIATORMAP_OVR_REASON
                                                userInfo:nil] autorelease];        
    }
    
    if(![mediatorClass conformsToProtocol: @protocol(IRMediator)])
    {
        @throw [[[IRContextException alloc] initWithName:E_MEDIATORMAP_NOIMPL_NAME
                                                  reason:E_MEDIATORMAP_NOIMPL_NAME
                                                userInfo:nil] autorelease];
    }
    
    IRMediatorMapping *mediatorMapping = [[[IRMediatorMapping alloc] init] autorelease];
    mediatorMapping.mediatorClass = mediatorClass;
    mediatorMapping.autoCreate = autoCreate;
    mediatorMapping.autoRemove = autoRemove;
    if(injectMediatedObjectAs)
    {
        if( class_isMetaClass(object_getClass(injectMediatedObjectAs)))
        {
            mediatorMapping.typedMediatedObjectClasses = [[[NSMutableArray alloc] initWithObjects: injectMediatedObjectAs, nil] autorelease];
        }
        else if([injectMediatedObjectAs isKindOfClass:[NSArray class]])
        {
            mediatorMapping.typedMediatedObjectClasses = [NSArray arrayWithArray: injectMediatedObjectAs];
        }
    }
    [self.mappingByMediatedObjectClass setObject:mediatorMapping forKey:mediatedObjectClass];
    //We need to be aware of Notifications if we aren't already registered
    if (autoCreate || autoRemove)
    {
        if(!self.isObserving)
            [self addObservers];
    }
}

-(void) unmapMediatedObject:(Class)mediatedObjectClass
{
    const IRMediatorMapping *mediatorMapping = [self.mappingByMediatedObjectClass objectForKey:mediatedObjectClass];
    if(mediatorMapping && (mediatorMapping.autoCreate || mediatorMapping.autoRemove))
    {
        if([self.mappingByMediatedObjectClass count] == 1 && self.isObserving)
        {
            [self removeObservers];
        }
    }
    [self.mappingByMediatedObjectClass removeObjectForKey:mediatedObjectClass];
}

-(id<IRMediator>) createMediatorForMediatedObject:(NSObject *)mediatedObject
{
    return [self createMediatorUsing:mediatedObject mediatedObjectClass:nil mediatorMapping:nil];
}

-(void) registerMediatorForMediatedObject:(NSObject *)mediatedObject mediator:(id<IRMediator>)mediator
{
    [self.injector whenAskedForClass: [mediator class] supplyInstance:mediatedObject];
    IRMediatorMapping *mediatorMapping = [self.mappingByMediatedObjectClass objectForKey:[mediatedObject class]];
    CFDictionarySetValue(self.mediatorByMediatedObject, mediatedObject, mediator);
    CFDictionarySetValue(self.mappingByMediatedObject, mediatedObject, mediatorMapping);
    mediator.mediatedObject = mediatedObject;
    [mediator mediatedObjectWillBeRegistered];
}

-(id<IRMediator>) removeMediator:(id<IRMediator>)mediator
{
    NSObject *mediatedObject = mediator.mediatedObject;
    CFDictionaryRemoveValue(self.mediatorByMediatedObject, mediatedObject); //TODO: Possible Memory Leak
    CFDictionaryRemoveValue(self.mappingByMediatedObject, mediatedObject);
    [mediator mediatedObjectWillBeUnregistered];
    mediator.mediatedObject = nil;
    [self.injector unmapClass:[mediatedObject class]];
    return mediator;
}

-(id<IRMediator>) removeMediatorForMediatedObject:(NSObject *)mediatedObject
{
    id<IRMediator> mediator = [self retrieveMediatorForMediatedObject:mediatedObject];
    return [self removeMediator:mediator];
}

-(id<IRMediator>)retrieveMediatorForMediatedObject:(NSObject *)mediatedObject
{
    
    id<IRMediator> mediator = (id<IRMediator>)CFDictionaryGetValue(self.mediatorByMediatedObject, mediatedObject);
    return mediator;
}

-(BOOL)hasMappingForMediatedObject:(NSObject *)mediatedObject
{
    Class mediatedObjectClass = [mediatedObject class];
    return [self.mappingByMediatedObjectClass objectForKey:mediatedObjectClass] != nil;
}

-(BOOL)hasMediatorForMediatedObject:(NSObject *)mediatedObject
{
    return CFDictionaryGetValue(self.mediatorByMediatedObject, mediatedObject) != nil;
}

-(BOOL)hasMediator:(id<IRMediator>)mediator
{
    return CFDictionaryContainsValue(self.mediatorByMediatedObject, mediator);
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)addObservers
{
    self.isObserving = YES;
    [self.notificationCenter addObserver:self selector:@selector(mediatedObjectWasAdded:) name:OBJECT_ALLOCATED object:nil];
    [self.notificationCenter addObserver:self selector:@selector(mediatedObjectWasRemoved:) name:OBJECT_DEALLOCATED object:nil];
}

-(void)removeObservers
{
    self.isObserving = NO;
    [self.notificationCenter removeObserver:self];
}

-(void)mediatedObjectWasAdded:(NSNotification *)notification
{

    Class mediatedObjectClass = [notification.object class];
    IRMediatorMapping *mediatorMapping = [self.mappingByMediatedObjectClass objectForKey:mediatedObjectClass];
	if (mediatorMapping && mediatorMapping.autoCreate)
        [self createMediatorUsing:notification.object 
              mediatedObjectClass:mediatedObjectClass 
                           mediatorMapping:mediatorMapping];
}

-(void)mediatedObjectWasRemoved:(NSNotification *)notification
{
    Class mediatedObjectClass = [notification.object class];
    const IRMediatorMapping *mediatorMapping = [self.mappingByMediatedObjectClass objectForKey:mediatedObjectClass];
	if (mediatorMapping && mediatorMapping.autoRemove)
        [self removeMediatorForMediatedObject:notification.object];
}

-(id<IRMediator>)createMediatorUsing:(NSObject *)mediatedObject 
       mediatedObjectClass:(Class)mediatedObjectClass 
                    mediatorMapping:(IRMediatorMapping *)mediatorMapping
{
    id<IRMediator> mediator = (id<IRMediator>)CFDictionaryGetValue(self.mediatorByMediatedObject, mediatedObject);
    if(!mediator)
    {
        if(!mediatedObjectClass)
            mediatedObjectClass = [mediatedObject class];
        if(!mediatorMapping)
        {
            mediatorMapping = [self.mappingByMediatedObjectClass objectForKey:mediatedObjectClass];
        }
        if(mediatorMapping)
        {
            for(Class clazz in mediatorMapping.typedMediatedObjectClasses)
            {
                [self.injector whenAskedForClass:clazz supplyInstance:mediatedObject]; 
            
            }
            //TODO: Why do I need to register it here? It is not preregistered in original version,
            //so it seems SS auto-creates an instance if there is no mapping already available.
            [self.injector whenAskedForClassSupplySameClass:mediatorMapping.mediatorClass];
            mediator = [self.injector getObjectForClass: mediatorMapping.mediatorClass];
            for(Class clazz in mediatorMapping.typedMediatedObjectClasses)
            {
                [self.injector unmapClass:clazz]; 
            
            }
            [self registerMediatorForMediatedObject:mediatedObject mediator:mediator];
        }
    }
    return mediator;
}

@end