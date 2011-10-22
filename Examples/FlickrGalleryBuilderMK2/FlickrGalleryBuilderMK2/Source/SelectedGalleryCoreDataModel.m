//
//  GalleryCoreDataModel.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Objection-iOS/Objection.h>
#import "SelectedGalleryCoreDataModel.h"
#import "Gallery.h"
#import "NotificationNames.h"
#import "IRobotlegs.h"

@implementation SelectedGalleryCoreDataModel

irobotlegs_requires(@"managedObjectContext");

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize managedObjectContext = managedObjectContext_;
@synthesize selectedGallery = selectedGallery_;
@synthesize numberOfImages;
@synthesize selectedImageIndex = selectedImageIndex_;

-(void)setSelectedGallery:(Gallery *)selectedGallery
{
    if(selectedGallery_)
        [selectedGallery_ release];
    
    if(selectedGallery)
    {
        selectedGallery_ = [selectedGallery retain];
        selectedImageIndex_ = -1;
    }
}

-(int)numberOfImages
{
    return [self.selectedGallery.images count];
}

-(void)setSelectedImageIndex:(int)selectedImageIndex
{
    if(selectedImageIndex < self.numberOfImages && selectedImageIndex >= 0)
    {
        selectedImageIndex_ = selectedImageIndex;
        Image *image = [self.selectedGallery.images objectAtIndex:selectedImageIndex];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:image forKey:@"image"];
        NSNotification *notification = [NSNotification notificationWithName:NOTIFY_SELECTED_GALLERY_SELECTED_IMAGE_CHANGED
                                                                 object:self
                                                               userInfo:userInfo];
        [self post:notification];
    }
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.managedObjectContext release];
    [self.selectedGallery release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------

-(void)selectNextImage
{
    if(self.selectedImageIndex < self.numberOfImages-1)
    {
        self.selectedImageIndex++;
    }
    else
    {
        NSNotification *notification = [NSNotification notificationWithName:NOTIFY_SELECTED_GALLERY_IMAGE_SELECTION_REACHED_END
                                                                 object:self];
        [self post:notification];
    }
}

-(void)removeSelectedImage
{
    [(NSMutableOrderedSet *)self.selectedGallery.images removeObjectAtIndex:self.selectedImageIndex];
    //Either the next image will drop down into the selected position, 
    //or we have no more images to select, in which case we have reached the end.
    NSNotification *notification = nil;
    if(self.numberOfImages == 0)
    {
    
        notification = [NSNotification notificationWithName:NOTIFY_SELECTED_GALLERY_EMPTY
                                                                 object:self];
    }
    else if(self.selectedImageIndex > self.numberOfImages-1)
    {
        notification = [NSNotification notificationWithName:NOTIFY_SELECTED_GALLERY_IMAGE_SELECTION_REACHED_END
                                                                 object:self];
    }
    else
    {
        self.selectedImageIndex = self.selectedImageIndex;
        notification = [NSNotification notificationWithName:NOTIFY_SELECTED_GALLERY_IMAGES_CHANGED
                                                                 object:self];
    }
    
    if(notification)
    {
        [self post:notification];
    }
}

@end
