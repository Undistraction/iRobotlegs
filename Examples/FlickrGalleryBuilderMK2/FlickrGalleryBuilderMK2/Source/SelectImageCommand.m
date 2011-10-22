//
//  SelectImageCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 21/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "SelectImageCommand.h"
#import "IRobotlegs.h"
#import "SelectedGalleryModel.h"

@implementation SelectImageCommand

irobotlegs_requires(@"notification", @"selectedGalleryModel");

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
    int imageIndex = [(NSNumber *)[self.notification.userInfo objectForKey:@"imageIndex"] intValue];
    self.selectedGalleryModel.selectedImageIndex = imageIndex;
}

@end