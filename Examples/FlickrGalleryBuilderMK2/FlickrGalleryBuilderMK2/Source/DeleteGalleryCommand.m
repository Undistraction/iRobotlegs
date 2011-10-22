//
//  DeleteGalleryCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 19/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "DeleteGalleryCommand.h"
#import "IRobotlegs.h"
#import "SelectedGalleryModel.h"
#import "GalleriesModel.h"

@implementation DeleteGalleryCommand

irobotlegs_requires(@"galleriesModel", @"selectedGalleryModel");

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize galleriesModel = galleriesModel_;
@synthesize selectedGalleryModel = selectedGalleryModel_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.galleriesModel release];
    [self.selectedGalleryModel release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    NSString *galleryName = self.selectedGalleryModel.selectedGallery.name;
    [self.galleriesModel removeSelectedGallery:galleryName];
}

@end
