//
//  RemoveSelectedImageCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 18/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "RemoveSelectedImageCommand.h"
#import "IRobotlegs.h"

@implementation RemoveSelectedImageCommand

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
    [self.selectedGalleryModel removeSelectedImage];
}

@end
