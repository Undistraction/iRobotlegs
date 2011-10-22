//
//  SearchForKeywordCommand.m
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 06/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "SearchForKeywordCommand.h"
#import "IRobotlegs.h"

@implementation SearchForKeywordCommand

irobotlegs_requires(@"notification", @"imageSearchService");

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize notification = notification_;
@synthesize imageSearchService = imageSearchService_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.notification release];
    [self.imageSearchService release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)execute
{
    UIApplication* application = [UIApplication sharedApplication];
	application.networkActivityIndicatorVisible = YES;
    
    NSString *keyword = [self.notification.userInfo objectForKey:@"keyword"];
    [self.imageSearchService searchUsingKeyword:keyword];
}

@end
