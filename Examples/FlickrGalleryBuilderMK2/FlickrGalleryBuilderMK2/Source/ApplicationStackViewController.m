//
//  ApplicationStackController.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 20/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "ApplicationStackViewController.h"
#import "NotificationNames.h"
#import "ImageSelectionViewController.h"

@interface ApplicationStackViewController()

-(void)contextKeywordSearchComplete:(NSNotification *)notification;
-(void)contextRequestGotoSearchView:(NSNotification *)notification;
-(void)contextRequestSaveGalleryView:(NSNotification *)notification;
-(void)contextRequestViewGallery:(NSNotification *)notification;

@end

@implementation ApplicationStackViewController

int const SEARCH_VIEW_INDEX = 0;
int const IMAGE_SELECTION_VIEW_INDEX = 1;
int const GALLERY_VIEW_INDEX = 2;

//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)addContextObservers
{
    [self addContextObserver:NOTIFY_KEYWORD_SEARCH_COMPLETE selector:@selector(contextKeywordSearchComplete:)];
    [self addContextObserver:REQUEST_DELETE_GALLERY selector:@selector(contextRequestGotoSearchView:)];
    [self addContextObserver:REQUEST_SAVE_GALLERY selector:@selector(contextRequestSaveGalleryView:)];
    [self addContextObserver:REQUEST_VIEW_GALLERY selector:@selector(contextRequestViewGallery:)];
    [self addContextObserver:REQUEST_SELECT_IMAGE selector:@selector(contextRequestSelectImage:)];
}


//------------------------------------------------------------------------------
//  View Handlers
//------------------------------------------------------------------------------ 

//TODO:This is nasty. We need to react to 'Save Gallery' being pressed, sending of 
//REQUEST_SAVE_NOTIFICATION. If we call super before, the selectedViewController will have
//changed by the time we come to check it. If we call it after, we will have already changed
//selectedViewController, causing super:navigateRightButtonPressed to react to the wrong
//selectedViewController.
-(IBAction)navigateRightPressed:(id)sender
{
    //Need a reference to selectedViewController
    UIViewController *selectedViewControllerCached = self.selectedViewController;
    [super navigateRightPressed:sender];
    //TODO: This class should not need a direct reference to ImageSelectionViewController
   if([selectedViewControllerCached isMemberOfClass:[ImageSelectionViewController class]])
   {
        NSNotification *notification = [NSNotification notificationWithName:REQUEST_SAVE_GALLERY 
                                                                     object:self];
    [self post:notification];
   }  
}

-(IBAction)navigateLeftPressed:(id)sender
{
    //Need a reference to selectedViewController
    UIViewController *selectedViewControllerCached = self.selectedViewController;
    [super navigateLeftPressed:sender];
    //TODO: This class should not need a direct reference to ImageSelectionViewController
   if([selectedViewControllerCached isMemberOfClass:[ImageSelectionViewController class]])
   {
        NSNotification *notification = [NSNotification notificationWithName:REQUEST_DELETE_GALLERY 
                                                                     object:self];
    [self post:notification];
   }  
}


//------------------------------------------------------------------------------
//  Context Handlers
//------------------------------------------------------------------------------

-(void)contextKeywordSearchComplete:(NSNotification *)notification
{
    self.selectedIndex = IMAGE_SELECTION_VIEW_INDEX;
}

-(void)contextRequestGotoSearchView:(NSNotification *)notification
{
    self.selectedIndex = SEARCH_VIEW_INDEX;
}

-(void)contextRequestSaveGalleryView:(NSNotification *)notification
{
    self.selectedIndex = GALLERY_VIEW_INDEX;
}

-(void)contextRequestViewGallery:(NSNotification *)notification
{
    self.selectedIndex = GALLERY_VIEW_INDEX;
}

-(void)contextRequestSelectImage:(NSNotification *)notification
{
    self.selectedIndex = IMAGE_SELECTION_VIEW_INDEX;
}

@end
