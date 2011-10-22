//
//  Image.h
//  IRobotlegs
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Gallery;

@interface Image : NSManagedObject

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSData *thumbnailData;
@property (nonatomic, retain) NSString *thumbnailURL;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) Gallery *gallery;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

+(Image *)initWithFlickrData:(NSDictionary *)flickrData
   managedObjectContext:(NSManagedObjectContext *)managedObjectContext;


@end
