//
//  HandleGallerySelectedCommand.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 18/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "HandleGallerySelectedCommand.h"
#import "IRobotlegs.h"
#import "SelectedGalleryModel.h"
#import "TransferSelectedModelCommand.h"
#import "SelectNextImageCommand.h"

@implementation HandleGallerySelectedCommand

irobotlegs_requires(@"notification",@"selectedGalleryModel");

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
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    TransferSelectedModelCommand *transferModelCommand = [self.injector getObjectForClass:[TransferSelectedModelCommand class]];
    transferModelCommand.notification = self.notification;
    [transferModelCommand execute];
    
    SelectNextImageCommand *selectNextImageCommand = [self.injector getObjectForClass:[SelectNextImageCommand class]];
    [selectNextImageCommand execute];
}

@end
