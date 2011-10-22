//
//  FlickrUtils.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

extern NSString *const FLICKR_IMAGE_URL_TOKENISED;
extern NSString *const FLICKR_KEYWORD_SEARCH_REQUEST_URL_TOKENISED;
extern NSString *const DEFAULT_IMAGE_FORMAT;

typedef enum {
	FlickrPhotoFormatSquare,
	FlickrPhotoFormatLarge,
	FlickrPhotoFormatThumbnail,
	FlickrPhotoFormatSmall,
	FlickrPhotoFormatMedium,
	FlickrPhotoFormatOriginal
} FlickrPhotoFormat;

@interface FlickrUtils : NSObject

//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

+ (NSData *)imageDataForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrPhotoFormat)format;
+ (NSString *)urlStringForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrPhotoFormat)format;
+ (NSData *)imageDataForPhotoWithURLString:(NSString *)urlString;

@end
