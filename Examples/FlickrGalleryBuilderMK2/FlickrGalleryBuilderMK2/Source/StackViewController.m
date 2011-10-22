//
//  StackViewController.m
//  ViewStack
//
//  Created by Pedr Browne on 12/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "StackViewController.h"
#import "NavigationLink.h"
#import "ViewControllerRelationship.h"

@interface StackViewController()
    @property (retain, nonatomic) NSMutableArray *relationshipMappings;
    -(void)presentViewController:(UIViewController *)viewController;
    -(void)clearViewControllers;
    -(ViewControllerRelationship *)getRelationshipsForViewController:(UIViewController *)viewController;
@end

@implementation StackViewController

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize navigationController = navigationController_;
@synthesize viewControllers = viewControllers_;
@synthesize selectedIndex;
@synthesize selectedViewController;
@synthesize navigationBarHidden;
@synthesize relationshipMappings = relationshipMappings_;

-(UIView *)view
{
    return self.navigationController.view;
}

-(NSMutableArray *)viewControllers
{
    if(!viewControllers_)
        self.viewControllers = [[[NSMutableArray alloc] init] autorelease];
    return viewControllers_;
}

-(void)setViewControllers:(NSMutableArray *)value
{
    [self clearViewControllers];
    [viewControllers_ release];
    if(value)
        [value retain];
    viewControllers_ = value;
}

-(NSInteger)selectedIndex
{
    return [self.viewControllers indexOfObject:self.selectedViewController];
}

-(void)setSelectedIndex:(NSInteger)aSelectedIndex
{
    if(aSelectedIndex < (NSInteger)[self.viewControllers count])
    {
        UIViewController *viewControllerAtIndex = (aSelectedIndex >= 0) ? [self.viewControllers objectAtIndex:aSelectedIndex] : nil;
        self.selectedViewController = viewControllerAtIndex;
    }
}

-(UIViewController *)selectedViewController
{
    return [self.navigationController topViewController];
}

-(void)setSelectedViewController:(UIViewController *)value
{
    if(!value || [self.viewControllers containsObject:value])
    {
        [self presentViewController:value];
    }
}

-(BOOL)navigationBarHidden
{
    return self.navigationController.navigationBarHidden;
}

-(void)setNavigationBarHidden:(BOOL)value
{
    self.navigationController.navigationBarHidden = value;
}

-(NSMutableArray *)relationshipMappings
{
    if(!relationshipMappings_)
        self.relationshipMappings = [[[NSMutableArray alloc] init] autorelease];
    return relationshipMappings_;
}


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

-(id)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
{
    if (self = [super initWithNotificationCenter:notificationCenter])
    {
        self.navigationController = [[[UINavigationController alloc] init] autorelease];
    }
    return self;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.navigationController release];
    [self.viewControllers release];
    [self.selectedViewController release];
    [self.relationshipMappings release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)addViewController:(UIViewController *)viewController
{
    if (![self.viewControllers containsObject:viewController])
    {
        [self.viewControllers addObject:viewController];
    }
}

-(void)addViewController:(UIViewController *)viewController leftLink:(NavigationLink *)leftLink rightLink:(NavigationLink *)rightLink
{
    [self addViewController:viewController];
    if(![self getRelationshipsForViewController:viewController])
    {
        ViewControllerRelationship *relationshipMapping = [[[ViewControllerRelationship alloc] init] autorelease];
        relationshipMapping.viewController = viewController;
        relationshipMapping.leftLink = leftLink;
        relationshipMapping.rightLink = rightLink;
        [self.relationshipMappings addObject:relationshipMapping];
        
    }
}

-(void)removeViewController:(UIViewController *)viewController
{
    if ([self.viewControllers containsObject:viewController])
    {
        [self.viewControllers removeObject:viewController];
        ViewControllerRelationship *relationshipMapping = [self getRelationshipsForViewController:viewController];
        if(relationshipMapping)
        {
            [self.relationshipMappings removeObject:relationshipMapping];
        }
        if([self.navigationController.topViewController isEqual: viewController])
        {
            self.selectedViewController = nil;
        }
    }
}

-(void)removeAllViewControllers
{
    self.viewControllers = nil;
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)presentViewController:(UIViewController *)viewController
{
    //We clear all the view controllers before adding a new one
    if([self.navigationController.viewControllers count] > 0)
    {
        [self clearViewControllers];
    }
    if(viewController)
    {
        viewController.navigationItem.hidesBackButton = YES;
        ViewControllerRelationship *relationshipMapping = [self getRelationshipsForViewController:viewController];
        if(relationshipMapping.leftLink)
        {
            viewController.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:relationshipMapping.leftLink.buttonLabelText
                                                                                    style:UIBarButtonItemStylePlain
                                                                                    target:self   
                                                                                    action:@selector(navigateLeftPressed:)] autorelease];
        }
        
        if(relationshipMapping.rightLink)
        {
            viewController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:relationshipMapping.rightLink.buttonLabelText
                                                                                    style:UIBarButtonItemStylePlain
                                                                                    target:self   
                                                                                    action:@selector(navigateRightPressed:)] autorelease];
        }
        [self.navigationController pushViewController:viewController animated:NO];
    }
}

-(void)clearViewControllers
{
    [self.navigationController setViewControllers:[[[NSMutableArray alloc] init] autorelease ]];
}

-(ViewControllerRelationship *)getRelationshipsForViewController:(UIViewController *)viewController
{
    for (ViewControllerRelationship *relationshipMapping in self.relationshipMappings)
    {
        if([relationshipMapping.viewController isEqual: viewController])
            return relationshipMapping;
    }
    return nil;
}


//------------------------------------------------------------------------------
//  Handlers
//------------------------------------------------------------------------------ 

-(IBAction)navigateLeftPressed:(id)sender
{
    
   ViewControllerRelationship *relationshipMapping = [self getRelationshipsForViewController:self.navigationController.topViewController];
   UIViewController *toViewController = relationshipMapping.leftLink.viewController;
   self.selectedViewController = toViewController;
}

-(IBAction)navigateRightPressed:(id)sender
{
    ViewControllerRelationship *relationshipMapping = [self getRelationshipsForViewController:self.navigationController.topViewController];
    UIViewController *toViewController = relationshipMapping.rightLink.viewController;
    self.selectedViewController = toViewController;
}

@end