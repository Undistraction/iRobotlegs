//
//  NotificationMappingData.h
//  iRobotlegs
//
//  Created by Pedr Browne on 23/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

@interface IRNotificationMapping : NSObject
{
    @private 
        NSString *notificationName_;
        NSNotificationCenter *notificationCenter_;
        NSString *selector_;
        id observer_;
        Class notificationClass_;
} 

@property (retain, nonatomic) NSString *notificationName;
@property (retain, nonatomic) NSNotificationCenter *notificationCenter;
@property (retain, nonatomic) NSString *selector;
@property (retain, nonatomic) id observer;
@property (retain, nonatomic) Class notificationClass;

@end

