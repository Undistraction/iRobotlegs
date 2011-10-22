//
//  SelectImageCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 17/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "SelectNextImageCommand.h"
#import "IRobotlegs.h"

@implementation SelectNextImageCommand

irobotlegs_requires(@"selectedGalleryModel")

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize selectedGalleryModel = selectedGalleryModel_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.selectedGalleryModel release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    [self.selectedGalleryModel selectNextImage];
}

@end
