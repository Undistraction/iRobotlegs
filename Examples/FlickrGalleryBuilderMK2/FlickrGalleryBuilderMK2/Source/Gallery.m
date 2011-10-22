//
//  Gallery.m
//  IRobotlegs
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//
//

#import "Gallery.h"
#import "Galleries.h"
#import "Image.h"

@implementation Gallery

@dynamic name;
@dynamic galleries;
@dynamic images;

//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------ 

+(Gallery *)initWithName:(NSString *)name photos:(NSArray *)photos managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    request.entity = [NSEntityDescription entityForName:@"Gallery" inManagedObjectContext:managedObjectContext];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    NSError *error = nil;
    Gallery *gallery = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];
    
    if(!gallery && !error)
    {
        gallery = [NSEntityDescription insertNewObjectForEntityForName:@"Gallery"
                                              inManagedObjectContext:managedObjectContext];
        gallery.name = name;
    }
    
    for (NSDictionary *photo in photos)
    {
        Image *image = [Image initWithFlickrData:photo managedObjectContext:managedObjectContext];
        [gallery addImagesObject:image];
    }
    return gallery;
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

- (void)addImages:(NSOrderedSet *)values
{
    self.images = values;
}

- (void)addImagesObject:(Image *)value
{
    NSMutableOrderedSet *mutableImages = [NSMutableOrderedSet orderedSetWithOrderedSet:self.images];
    [mutableImages addObject:value];
    self.images = [NSOrderedSet orderedSetWithOrderedSet:mutableImages];
}

- (void)removeImagesObject:(Image *)value
{
    NSMutableOrderedSet *mutableImages = [NSMutableOrderedSet orderedSetWithOrderedSet:self.images];
    [mutableImages removeObject:value];
    self.images = [NSOrderedSet orderedSetWithOrderedSet:mutableImages];
    [self.managedObjectContext deleteObject:value];
}

@end
