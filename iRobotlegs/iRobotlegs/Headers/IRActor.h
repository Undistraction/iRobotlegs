//
//  Actor.h
//  iRobotlegs
//
//  Created by Pedr Browne on 16/09/2011.
//  Copyright (c) 2011 the original author or authors

//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "IRNotificationMapProtocol.h"

@interface IRActor : NSObject
{
    @private
        NSNotificationCenter *notificationCenter_;
        id<IRNotificationMap> notificationMap_;
}


//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSNotificationCenter *notificationCenter;
@property (retain, nonatomic) id<IRNotificationMap> notificationMap;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------ 

-(void)post:(NSNotification *)notification;

@end
