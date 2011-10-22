//
//  IRobotlegs.h
//  iRobotlegs
//
//  Created by Pedr Browne on 03/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRConstants.h"

//Core
#import "IRMediatorMapProtocol.h"
#import "IRMediatorProtocol.h"
#import "IRNotificationMapProtocol.h"
#import "IRCommandMapProtocol.h"
#import "IRCommandMapProtocol.h"
#import "IRInjectorProtocol.h"

//Base
#import "IRNotificationMap.h"
#import "IRMediatorMap.h"
#import "IRCommandMap.h"
#import "IRContextException.h"
// - Helper
#import "IRMediatorMapping.h"
#import "IRNotificationMapping.h"
#import "IRCallback.h"

//MVCS
#import "IRContext.h"
#import "IRActor.h"
#import "IRMediator.h"
#import "IRCommand.h"

//Injection
#import "IRObjectionInjector.h"
#import "IRObjectionInjectorException.h"

//Macros
#define irobotlegs_requires(args...) \
  + (NSSet *)objectionRequires { \
      NSSet *requirements = [NSSet setWithObjects: args, nil]; \
      return JSObjectionUtils.buildDependenciesForClass(self, requirements); \
    }
