//
//  IRViewController.h
//  IRobotlegs
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <UIKit/UIKit.h>
#import "IRNotificationMapProtocol.h"

@interface IRViewController : UIViewController
{
    NSNotificationCenter *notificationCenter_;
    id<IRNotificationMap> notificationMap_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (nonatomic, retain) NSNotificationCenter *notificationCenter;
@property (nonatomic, retain) id<IRNotificationMap> notificationMap;

//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

-(IRViewController *)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter;
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle notificationCenter:(NSNotificationCenter *)notificationCenter;

//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------ 

-(void)post:(NSNotification *)notification;
-(void)addContextObserver:(NSString *)notificationName selector:(SEL)selector;
-(void)addContextObservers;

@end
