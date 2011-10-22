//
//  IRInjectorProtocol.h
//  iRobotlegs
//
//  Created by Pedr Browne on 23/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

@protocol IRInjector <NSObject>

//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(id)getObjectForClass:(Class)clazz;
-(id)getObjectForProtocol:(Protocol *)protocol;

-(void)whenAskedForClassSupplySameClass:(Class)clazz;
-(void)whenAskedForClass:(Class)clazz supplyInstance:(id)instance;
-(void)whenAskedForProtocol:(Protocol *)protocol supplyInstance:(id)instance;
-(void)whenAskedForProtocol:(Protocol *)protocol supplyClass:(Class)clazz;
-(void)mapSingleton:(Class)clazz;
-(void)whenAskedForProtocol:(id)protocol supplySingletonOfClass:(Class)clazz;
-(void)whenAskedForClass:(Class)clazz supplySingletonOfClass:(Class)singletonClass;

-(void)unmapClass:(Class)clazz;
-(void)unmapProtocol:(Protocol *)protocol;
-(void)unmapAllClasses;


@end