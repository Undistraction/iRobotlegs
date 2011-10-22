//
//  SaveGalleriesCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 11/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "SaveGalleriesCommand.h"
#import "IRobotlegs.h"

@implementation SaveGalleriesCommand

irobotlegs_requires(@"galleriesModel");

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize galleriesModel = galleriesModel_;

//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.galleriesModel release];
    [super dealloc];
}

//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    [self.galleriesModel saveGalleries];
}

@end
