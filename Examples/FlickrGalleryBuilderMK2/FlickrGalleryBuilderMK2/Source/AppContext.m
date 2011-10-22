//
//  ApplicationContext.m
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 04/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "AppContext.h"
#import "IRConstants.h"
#import "NotificationNames.h"
#import "FlickrSearchService.h"
#import "ImageSearchService.h"
#import "GalleriesCoreDataModel.h"
#import "GalleriesModel.h"
#import "SelectedGalleryCoreDataModel.h"
#import "SelectedGalleryModel.h"
#import "SearchForKeywordCommand.h"
#import "AddGalleryCommand.h"
#import "SelectGalleryCommand.h"
#import "SelectNextImageCommand.h"
#import "HandleGallerySelectedCommand.h"
#import "RemoveSelectedImageCommand.h"
#import "AlertUserNoMoreImagesCommand.h"
#import "AlertUserAllImagesAssignedCommand.h"
#import "RetrieveSavedGalleriesCommand.h"
#import "SaveGalleriesCommand.h"
#import "DeleteGalleryCommand.h"
#import "SelectImageCommand.h"

@interface AppContext()
  -(void)mapCommands;
  -(void)mapServices;
  -(void)mapModels;
@end

@implementation AppContext

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize managedObjectContext = managedObjectContext_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.managedObjectContext release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)startup
{
    [self.injector whenAskedForClass:[NSManagedObjectContext class] 
                      supplyInstance:self.managedObjectContext];
    [self mapCommands];
    [self mapModels];
    [self mapServices];
    [super startup];
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)mapCommands
{
    [self.commandMap mapNotification:CONTEXT_STARTUP_COMPLETE
                        commandClass:[RetrieveSavedGalleriesCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:REQUEST_IMAGES_FOR_KEYWORD
                        commandClass:[SearchForKeywordCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:NOTIFY_KEYWORD_SEARCH_COMPLETE
                        commandClass:[AddGalleryCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:NOTIFY_GALLERY_ADDED
                        commandClass:[SelectGalleryCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:REQUEST_ACCEPT_IMAGE
                        commandClass:[SelectNextImageCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:REQUEST_REJECT_IMAGE
                        commandClass:[RemoveSelectedImageCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:NOTIFY_SELECTED_GALLERY_CHANGED
                        commandClass:[HandleGallerySelectedCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:NOTIFY_SELECTED_GALLERY_EMPTY
                        commandClass:[AlertUserNoMoreImagesCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:NOTIFY_SELECTED_GALLERY_IMAGE_SELECTION_REACHED_END
                        commandClass:[AlertUserAllImagesAssignedCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:REQUEST_SAVE_GALLERY
                        commandClass:[SaveGalleriesCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:REQUEST_DELETE_GALLERY
                        commandClass:[DeleteGalleryCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:REQUEST_VIEW_GALLERY
                        commandClass:[SelectGalleryCommand class]
                   notificationClass:nil
                             oneshot:NO];
    [self.commandMap mapNotification:REQUEST_SELECT_IMAGE
                        commandClass:[SelectImageCommand class]
                   notificationClass:nil
                             oneshot:NO];
}

-(void)mapServices
{
    [self.injector whenAskedForProtocol:@protocol(ImageSearchService)
                 supplySingletonOfClass:[FlickrSearchService class]];
}

-(void)mapModels
{
    [self.injector whenAskedForProtocol:@protocol(GalleriesModel) 
                 supplySingletonOfClass:[GalleriesCoreDataModel class]];
    [self.injector whenAskedForProtocol:@protocol(SelectedGalleryModel) 
                 supplySingletonOfClass:[SelectedGalleryCoreDataModel class]];
}

@end