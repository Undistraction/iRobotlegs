//
//  RemoveSelectedImageCommand.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 18/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRCommand.h"
#import "SelectedGalleryModel.h"

@interface RemoveSelectedImageCommand : IRCommand
{
    @private
        NSNotification *notification_;
        id<SelectedGalleryModel> selectedGalleryModel_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) NSNotification *notification;
@property (retain, nonatomic) id<SelectedGalleryModel> selectedGalleryModel;

@end