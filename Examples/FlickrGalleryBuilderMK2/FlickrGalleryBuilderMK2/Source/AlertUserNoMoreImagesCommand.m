//
//  AlertUserNoMoreImages.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 19/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "AlertUserNoMoreImagesCommand.h"
#import "NotificationNames.h"

@implementation AlertUserNoMoreImagesCommand

//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    [self.commandMap retainCommand:self];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"No More Images"
                                                        message:@"You have rejected all the images in this gallery" 
                                                       delegate:self 
                                              cancelButtonTitle:@"New Search"
                                              otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}


//------------------------------------------------------------------------------
//  UIAlertViewDelegate
//------------------------------------------------------------------------------

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSNotification *notification = [NSNotification notificationWithName:REQUEST_DELETE_GALLERY
                                                                 object:self];
    [self post:notification];
    [self.commandMap releaseCommand:self];
}

@end
