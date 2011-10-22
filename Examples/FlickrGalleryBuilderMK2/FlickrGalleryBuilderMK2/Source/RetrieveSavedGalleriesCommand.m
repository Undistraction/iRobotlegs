//
//  RetrieveSavedGalleriesCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 19/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "RetrieveSavedGalleriesCommand.h"
#import "IRobotlegs.h"
#import "Galleries.h"
#import "GalleriesModel.h"
#import "NotificationNames.h"

@implementation RetrieveSavedGalleriesCommand

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
    Galleries *galleries = self.galleriesModel.galleries;
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:galleries forKey:@"galleries"];
    
    NSNotification *notification = [NSNotification notificationWithName:NOTIFY_GALLERIES_AVAILABLE
                                                                 object:self
                                                               userInfo:userInfo];
    [self post:notification];
}

@end
