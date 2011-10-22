//
//  TransferSelectedModelCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 18/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "TransferSelectedModelCommand.h"
#import "IRobotlegs.h"
#import "Gallery.h"
#import "SelectedGalleryModel.h"
#import "SelectNextImageCommand.h"

@implementation TransferSelectedModelCommand

irobotlegs_requires(@"selectedGalleryModel")

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize notification = notification_;
@synthesize selectedGalleryModel = selectedGalleryModel_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.notification release];
    [self.selectedGalleryModel release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    Gallery *gallery = [self.notification.userInfo objectForKey:@"gallery"];
    self.selectedGalleryModel.selectedGallery = gallery;
}

@end