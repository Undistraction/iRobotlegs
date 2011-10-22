//
//  Galleries.h
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

@interface Galleries : NSManagedObject

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (nonatomic, retain) NSOrderedSet *galleries;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

+(Galleries *)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (void)addGalleriesObject:(Gallery *)value;
- (void)removeGalleriesObject:(Gallery *)value;

@end
