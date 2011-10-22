//
//  Galleries.m
//  IRobotlegs
//
//  Created by Pedr Browne on 15/10/2011.
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//  Copyright (c) 2011 the original author or authors


#import "Galleries.h"
#import "Gallery.h"

@implementation Galleries

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@dynamic galleries;

//------------------------------------------------------------------------------
//  Initialsation
//------------------------------------------------------------------------------ 

+(Galleries *)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Galleries"
                                         inManagedObjectContext:managedObjectContext];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

- (void)addGalleriesObject:(Gallery *)value
{
    NSMutableOrderedSet *mutableGalleries = [NSMutableOrderedSet orderedSetWithOrderedSet:self.galleries];
    [mutableGalleries addObject:value];
    self.galleries = [NSOrderedSet orderedSetWithOrderedSet:mutableGalleries];
}

- (void)removeGalleriesObject:(Gallery *)value
{
    NSMutableOrderedSet *mutableGalleries = [NSMutableOrderedSet orderedSetWithOrderedSet:self.galleries];
    [mutableGalleries removeObject:value];
    self.galleries = [NSOrderedSet orderedSetWithOrderedSet:mutableGalleries];
    [self.managedObjectContext deleteObject:value];
}

@end