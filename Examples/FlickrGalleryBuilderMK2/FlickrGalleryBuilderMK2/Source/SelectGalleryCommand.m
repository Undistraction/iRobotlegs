//
//  SelectGalleryCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 11/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "SelectGalleryCommand.h"
#import "IRobotlegs.h"

@implementation SelectGalleryCommand

irobotlegs_requires(@"notification",@"galleriesModel");

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize notification = notification_;
@synthesize galleriesModel = galleriesModel_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.notification release];
    [self.galleriesModel release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    NSLog(@"SELECT GALLERY EXECUTE");
    NSString *galleryName = [self.notification.userInfo objectForKey:@"name"];
    [self.galleriesModel selectGalleryNamed:galleryName];
    NSLog(@"SELECT EXECUTED");
}

@end
