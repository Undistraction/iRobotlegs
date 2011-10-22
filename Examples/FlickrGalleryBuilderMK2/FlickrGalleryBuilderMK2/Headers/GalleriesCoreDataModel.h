//
//  UserGalleriesModel.h
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 04/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRActor.h"
#import "GalleriesModel.h"
#import "Galleries.h"
#import "Gallery.h"

@interface GalleriesCoreDataModel : IRActor<GalleriesModel>
{
    @private
        NSManagedObjectContext *managedObjectContext_;
        Galleries *galleries_;
        Gallery *selectedGallery_;
}


//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) Galleries *galleries;
@property (retain, nonatomic) Gallery *selectedGallery;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(void)addGallery:(NSArray *)images named:(NSString *)name;
-(void)selectGalleryNamed:(NSString *)name;
-(Gallery *)galleryNamed:(NSString *)name;
-(void)removeSelectedGallery:(NSString *)name;
-(void)saveGalleries;

@end
