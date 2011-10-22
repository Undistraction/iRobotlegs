//
//  FlickrUtils.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "FlickrUtils.h"

NSString *const FLICKR_IMAGE_URL_TOKENISED = @"http://farm%@.static.flickr.com/%@/%@_%@%@.%@";
NSString *const FLICKR_KEYWORD_SEARCH_REQUEST_URL_TOKENISED = @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=10&format=json&nojsoncallback=1";
NSString *const DEFAULT_IMAGE_FORMAT = @"jpg";

@implementation FlickrUtils

+ (NSString *)urlStringForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrPhotoFormat)format;
{
	id farm = [flickrInfo objectForKey:@"farm"];
	id server = [flickrInfo objectForKey:@"server"];
	id photo_id = [flickrInfo objectForKey:@"id"];
    
	id secret = (format == FlickrPhotoFormatOriginal) ?
                 [flickrInfo objectForKey:@"originalsecret"] : 
                 [flickrInfo objectForKey:@"secret"];
    
	NSString *fileType = (format == FlickrPhotoFormatOriginal) ? 
                         [flickrInfo objectForKey:@"originalformat"] :
                         DEFAULT_IMAGE_FORMAT;
	
	if (!farm || !server || !photo_id || !secret)
    {
        return nil;
    }
	
	NSString *formatString = @"s";
	switch (format) {
		case FlickrPhotoFormatSquare:    formatString = @"_s";
            break;
		case FlickrPhotoFormatLarge:     formatString = @"_b";
            break;
		case FlickrPhotoFormatThumbnail: formatString = @"_t";
            break;
		case FlickrPhotoFormatSmall:     formatString = @"_m";
            break;
		case FlickrPhotoFormatMedium:    formatString = @"";
            break;
		case FlickrPhotoFormatOriginal:  formatString = @"_o";
            break;
        default:
            break;
	}
	return [NSString stringWithFormat:FLICKR_IMAGE_URL_TOKENISED, farm, server, photo_id, secret, formatString, fileType];
}	

+ (NSData *)imageDataForPhotoWithURLString:(NSString *)urlString
{
	return [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
}

+ (NSData *)imageDataForPhotoWithFlickrInfo:(NSDictionary *)flickrInfo format:(FlickrPhotoFormat)format;
{
	return [self imageDataForPhotoWithURLString:[self urlStringForPhotoWithFlickrInfo:flickrInfo format:format]];
}

@end