//
//  StackViewController.h
//  ViewStack
//
//  Created by Pedr Browne on 12/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <UIKit/UIKit.h>
#import "NavigationLink.h"
#import "IRViewController.h"

@interface StackViewController : IRViewController
{
    @protected
        UINavigationController *navigationController_;
        NSMutableArray *viewControllers;
        NSMutableArray *relationshipMappings_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) UINavigationController *navigationController;
@property (retain, nonatomic) NSMutableArray *viewControllers;
@property (nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) UIViewController *selectedViewController;
@property (nonatomic) BOOL navigationBarHidden;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(void)addViewController:(UIViewController *)viewController;
-(void)addViewController:(UIViewController *)viewController leftLink:(NavigationLink *)leftLink rightLink:(NavigationLink *)rightLink;
-(void)removeViewController:(UIViewController *)viewController;
-(void)removeAllViewControllers;
-(IBAction)navigateLeftPressed:(id)sender;
-(IBAction)navigateRightPressed:(id)sender;

@end