//
//  RetrieveSavedGalleriesCommand.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 19/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRCommand.h"
#import "GalleriesModel.h"

@interface RetrieveSavedGalleriesCommand : IRCommand
{
    @private
        id<GalleriesModel> galleriesModel_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property(retain, nonatomic) id<GalleriesModel> galleriesModel;

@end
