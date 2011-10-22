//
//  GalleryViewController.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <UIKit/UIKit.h>
#import "IRViewController.h"
#import "Gallery.h"

@interface GalleryViewController : IRViewController<UITableViewDelegate,UITableViewDataSource>
{
    @private
        UILabel *titleTextField_;
        UITableView *tableView_;
        Gallery *gallery_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) IBOutlet UILabel*titleTextField;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) Gallery *gallery;

@end