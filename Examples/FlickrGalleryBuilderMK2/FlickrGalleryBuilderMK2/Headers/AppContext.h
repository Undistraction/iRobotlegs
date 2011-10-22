//
//  ApplicationContext.h
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 04/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRobotlegs.h"

@interface AppContext : IRContext
{
    @private
        NSManagedObjectContext *managedObjectContext_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
