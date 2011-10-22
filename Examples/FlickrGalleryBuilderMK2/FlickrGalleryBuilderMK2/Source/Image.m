//
//  Image.m
//  IRobotlegs
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//
//

#import "Image.h"
#import "Gallery.h"
#import "FlickrUtils.h"

@implementation Image

@dynamic imageURL;
@dynamic name;
@dynamic thumbnailData;
@dynamic thumbnailURL;
@dynamic uid;
@dynamic gallery;

//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

+(Image *)initWithFlickrData:(NSDictionary *)flickrData
        managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    request.entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:managedObjectContext];
    request.predicate = [NSPredicate predicateWithFormat:@"uid = %@", [flickrData objectForKey:@"id"]];
    
    NSError *error = nil;
    Image *image = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];
    
    if(!image && !error)
    {
        image = [NSEntityDescription insertNewObjectForEntityForName:@"Image"
                                              inManagedObjectContext:managedObjectContext];
        NSString *imageName = [flickrData objectForKey:@"title"];
        image.name = imageName ? imageName : @"Unknown";
        image.uid = [flickrData objectForKey:@"id"];
        image.thumbnailURL = [FlickrUtils urlStringForPhotoWithFlickrInfo:flickrData format:FlickrPhotoFormatSquare];
        image.imageURL = [FlickrUtils urlStringForPhotoWithFlickrInfo:flickrData format:FlickrPhotoFormatLarge];
        image.thumbnailData = [NSData dataWithContentsOfURL:[NSURL URLWithString:image.thumbnailURL]];
    }
                                              
    return image;
}

@end
