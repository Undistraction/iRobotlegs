//
//  GalleriesModel.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "Galleries.h"
#import "Gallery.h"

@protocol GalleriesModel <NSObject>

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) Galleries *galleries;
@property (retain, nonatomic) Gallery *selectedGallery;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(void)addGallery:(NSArray *)images named:(NSString *)named;
-(void)selectGalleryNamed:(NSString *)name;
-(void)removeSelectedGallery:(NSString *)name;
-(void)saveGalleries;

@end


