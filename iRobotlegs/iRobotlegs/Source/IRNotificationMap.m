//
//  EventMap.m
//  iRobotlegs
//
//  Created by Pedr Browne on 16/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRNotificationMap.h"
#import "IRContextException.h"
#import "IRNotificationMapping.h"

@interface IRNotificationMap()
    @property (nonatomic, retain) NSMutableArray *observers;
    @property (nonatomic) BOOL notifierListeningEnabled;
    -(void)routeNotificationToListener:(NSNotification *)notification;
@end

@implementation IRNotificationMap

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize observers = observers_;
@synthesize notificationCenter = notificationCenter_;
@synthesize notifierListeningEnabled = notifierListeningEnabled_;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------ 

- (id)init
{
    return [self initWithNotificationCenter: nil];
}

//Dedicated Initialiser
-(id)initWithNotificationCenter: (NSNotificationCenter *)notificationCenter
{
    if (self = [super init])
    {
        self.notificationCenter = notificationCenter;
        //Set default values
        self.notifierListeningEnabled = YES;
        self.observers = [[[NSMutableArray alloc] init] autorelease];
    }
    return self;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------ 

-(void) dealloc
{
    self.notificationCenter = nil;
    self.observers = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void) mapObserver:(id)observer 
           selector:(SEL)selector
  notificationName:(NSString *)notificationName 
  notificationClass:(Class)notificationClass
 notificationCenter:(NSNotificationCenter *)notificationCenter
{
    if(!self.notifierListeningEnabled && [notificationCenter isEqual: self.notificationCenter])
    {
        @throw [[[IRContextException alloc] initWithName:E_EVENTMAP_NOSNOOPING_NAME
                                                  reason:E_EVENTMAP_NOSNOOPING_REASON
                                                userInfo:nil] autorelease];
    }
    
    if(!notificationClass)
        notificationClass = [NSNotification class];
    
    NSString *selectorString = NSStringFromSelector(selector);
            
    for (IRNotificationMapping *mapping in self.observers)
    {
        //Check whether we have already registered this configuration
        if([mapping.notificationName isEqual: notificationName ]
            && [mapping.notificationClass isEqual: notificationClass]
            && [mapping.notificationCenter isEqual: notificationCenter]
            && [mapping.selector isEqual: selectorString]
            && [mapping.observer isEqual: observer])
        {
            return;
        }
    }
    
    IRNotificationMapping *mapping = [[[IRNotificationMapping alloc] init] autorelease];
    mapping.notificationName = notificationName;
    mapping.notificationClass = notificationClass;
    mapping.notificationCenter = notificationCenter;
    mapping.selector = selectorString;
    mapping.observer = observer;
    
    //Add parameters to observers array
    [self.observers addObject: mapping];
    
    [self.notificationCenter addObserver:self selector:@selector(routeNotificationToListener:) name:notificationName object:nil];
}

-(void)unmapObserver:(id)observer
            selector:(SEL)selector
    notificationName:(NSString *)notificationName
   notificationClass:(Class)notificationClass
  notificationCenter:(NSNotificationCenter *)notificationCenter
{
    NSString *selectorString = NSStringFromSelector(selector);
    
    if(!notificationClass)
        notificationClass = [NSNotification class];
    
    for (IRNotificationMapping *mapping in self.observers)
    {
        if([mapping.notificationName isEqual: notificationName ]
            && [mapping.notificationClass isEqual: notificationClass]
            && [mapping.notificationCenter isEqual: notificationCenter]
            && [mapping.selector isEqual: selectorString]
            && [mapping.observer isEqual: observer])
        {
            [self.notificationCenter removeObserver: observer name:notificationName object:nil];
            [self.observers removeObject: mapping];
			return;
        }
    }
}

-(void)unmapObservers
{
    for (IRNotificationMapping *mapping in self.observers)
    {
        [self.notificationCenter removeObserver:self name:mapping.notificationName object:nil];
    }
    
    [self.observers removeAllObjects];
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------ 

-(void)routeNotificationToListener:(NSNotification *)notification
{
    for (IRNotificationMapping *mapping in self.observers)
    {
        if([mapping.notificationName isEqual: notification.name])
        {
            if(![notification isKindOfClass:mapping.notificationClass] && ![notification isMemberOfClass:mapping.notificationClass])
                return;
            SEL selector = NSSelectorFromString(mapping.selector);
            [mapping.observer performSelector:selector withObject: notification];
        }
    }
}		

@end
