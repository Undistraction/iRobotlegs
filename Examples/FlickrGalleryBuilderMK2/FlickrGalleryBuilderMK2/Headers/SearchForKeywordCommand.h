//
//  SearchForKeywordCommand.h
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 06/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRCommand.h"
#import "ImageSearchService.h"

@interface SearchForKeywordCommand : IRCommand
{
    NSNotification *notification_;
    id<ImageSearchService> imageSearchService_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSNotification *notification;
@property (retain, nonatomic) id<ImageSearchService> imageSearchService;

@end
