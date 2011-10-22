//
//  IRMediatorMap.h
//  iRobotlegs
//
//  Created by Pedr Browne on 19/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRInjectorProtocol.h"
#import "IRMediatorMapProtocol.h"

@interface IRMediatorMap : NSObject<IRMediatorMap>
{
    @private
        id<IRInjector> injector_;
        BOOL enabled_;
        BOOL isObserving_;
        NSNotificationCenter *notificationCenter_;
        
		CFMutableDictionaryRef mediatorByMediatedObject_;
		CFMutableDictionaryRef mappingByMediatedObject_;
		NSMutableDictionary *mappingByMediatedObjectClass_;
}

-(id) initWithInjector:(id<IRInjector>)injector notificationCenter:(NSNotificationCenter *)notificationCenter;

-(void) mapMediatedObjectClass:(Class)mediatedObjectClass 
               toMediatorClass:(Class)mediatorClass 
        injectMediatedObjectAs:(id)injectMediatedObjectAs
                    autoCreate:(BOOL)autoCreate
                    autoRemove:(BOOL)autoRemove;
                    
-(void) unmapMediatedObject:(Class)viewClass;

-(id<IRMediator>) createMediatorForMediatedObject:(NSObject *)mediatedObject;
-(void) registerMediatorForMediatedObject:(NSObject *)mediatedObject mediator:(id<IRMediator>)mediator;
-(id<IRMediator>) removeMediator:(id<IRMediator>)mediator;
-(id<IRMediator>) removeMediatorForMediatedObject:(NSObject *)mediatedObject;
-(id<IRMediator>) retrieveMediatorForMediatedObject:(NSObject *)mediatedObject;

-(BOOL) hasMappingForMediatedObject:(NSObject *)mediatedObject;
-(BOOL) hasMediatorForMediatedObject:(NSObject *)mediatedObject;
-(BOOL) hasMediator:(id<IRMediator>)mediator;

@end
