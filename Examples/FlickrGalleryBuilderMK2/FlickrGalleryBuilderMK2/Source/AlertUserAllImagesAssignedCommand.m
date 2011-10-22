//
//  AlertUserAllImagesAssigned.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 19/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "AlertUserAllImagesAssignedCommand.h"
#import "NotificationNames.h"

@implementation AlertUserAllImagesAssignedCommand

//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------

-(void)execute
{
    [self.commandMap retainCommand:self];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"All Images Assigned"
                                                        message:@"You have assigned all images. Do you want to save this gallery or delete it?" 
                                                       delegate:self 
                                              cancelButtonTitle:@"Delete Gallery"
                                              otherButtonTitles:@"Save Gallery", nil];
	[alertView show];
	[alertView release];
}


//------------------------------------------------------------------------------
//  UIAlertViewDelegate
//------------------------------------------------------------------------------

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *notificationName = nil;
    if(buttonIndex == 0)
    {
        notificationName = REQUEST_DELETE_GALLERY;
    }
    else
    {
        notificationName = REQUEST_SAVE_GALLERY;
    }
    NSNotification *notification = [NSNotification notificationWithName:notificationName
                                                                 object:self];
    
    [self post:notification];
    [self.commandMap releaseCommand:self];
}

@end