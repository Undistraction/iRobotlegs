//
//  AddGalleryCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 11/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "AddGalleryCommand.h"
#import "IRobotlegs.h"
#import "NotificationNames.h"

@implementation AddGalleryCommand

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
    UIApplication* application = [UIApplication sharedApplication];
	application.networkActivityIndicatorVisible = NO;
    
    NSArray *photos = [self.notification.userInfo objectForKey:@"photos"];
    NSString *name = [self.notification.userInfo objectForKey:@"keyword"];
    [self.galleriesModel addGallery:photos named:name];
}

@end
