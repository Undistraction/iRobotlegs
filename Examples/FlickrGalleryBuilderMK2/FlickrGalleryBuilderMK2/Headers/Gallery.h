//
//  Gallery.h
//  IRobotlegs
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Gallery.h"
#import "Galleries.h"

@class Image;

@interface Gallery : NSManagedObject

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Galleries *galleries;
@property (nonatomic, retain) NSOrderedSet *images;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

+(Gallery *)initWithName:(NSString *)name photos:(NSArray *)photos managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (void)addImages:(NSOrderedSet *)values;
- (void)addImagesObject:(Image *)value;


@end

