//
//  IRStoryboard.h
//  iRobotlegs
//
//  Created by Pedr Browne on 26/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRStoryboard.h"

@interface IRStoryboard()
@property (retain, nonatomic) UIStoryboard *decoratedStoryboard;
@property (retain, nonatomic) NSNotificationCenter *notificationCenter;
@end

//
// We are decorating UIStoryboard so we can pass the notification center off to
// our created ViewControllers.
// You will have to manually instantiate the storyboard rather than relying on
// UIApplication doing it automatically. Remove the reference to the main 
// storyboard from the project's info.plist, then do something like this in your
// AppDelegate:
//
// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
// {
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window = window;
//    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
//    UIStoryboard *storyboard = [IRStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle] notificationCenter:notificationCenter];
//    ViewController *viewController = [storyboard instantiateInitialViewController];
//    self.window.rootViewController = viewController;
//    [self.window makeKeyAndVisible];
//    return YES;
// }
//

@implementation IRStoryboard

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize decoratedStoryboard = decoratedStoryboard_;
@synthesize notificationCenter = notificationCenter_;


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

+ (UIStoryboard *)storyboardWithName:(NSString *)name 
                              bundle:(NSBundle *)storyboardBundleOrNil
                  notificationCenter:(NSNotificationCenter *)notificationCenter
{
    IRStoryboard *storyboard = [[IRStoryboard alloc] init];
    storyboard.decoratedStoryboard = [UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil];
    storyboard.notificationCenter = notificationCenter;
    return storyboard;
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

+ (UIStoryboard *)storyboardWithName:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil
{
    return  [self storyboardWithName:name bundle:storyboardBundleOrNil notificationCenter:nil];
}

- (id)instantiateInitialViewController
{
    UIViewController *viewController = [self.decoratedStoryboard instantiateInitialViewController];
    if([viewController respondsToSelector:@selector(notificationCenter)])
    {
        [viewController performSelector:@selector(setNotificationCenter:) withObject:self.notificationCenter];
    }
    return viewController;
}

-(id)instantiateViewControllerWithIdentifier:(NSString *)identifier
{
    UIViewController *viewController = [self.decoratedStoryboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

@end
