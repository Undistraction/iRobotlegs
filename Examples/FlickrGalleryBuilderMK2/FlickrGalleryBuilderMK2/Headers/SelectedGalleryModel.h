//
//  SelectedGalleryModel.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "Gallery.h"

@protocol SelectedGalleryModel <NSObject>

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;  
@property (retain, nonatomic) Gallery *selectedGallery;
@property (nonatomic) int selectedImageIndex;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(void)selectNextImage;
-(void)removeSelectedImage;

@end
