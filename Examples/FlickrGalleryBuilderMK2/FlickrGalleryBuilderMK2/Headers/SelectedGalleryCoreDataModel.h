//
//  GalleryCoreDataModel.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 15/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRActor.h"
#import "Gallery.h"
#import "SelectedGalleryModel.h"

@interface SelectedGalleryCoreDataModel : IRActor<SelectedGalleryModel>
{
    @private
        NSManagedObjectContext *managedObjectContext_;
        Gallery *selectedGallery_;
        int selectedImageIndex_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;  
@property (retain, nonatomic) Gallery *selectedGallery;
@property (nonatomic, readonly) int numberOfImages;
@property (nonatomic) int selectedImageIndex;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(void)selectNextImage;
-(void)removeSelectedImage;

@end
