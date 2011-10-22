//
//  SearchViewController.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <UIKit/UIKit.h>
#import "IRViewController.h"
#import "Galleries.h"

@interface SearchViewController : IRViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
{
    @private
        UITextField *searchTextField_;
        UIButton *cancelButton_;
        UITableView *tableView_;
        UIActivityIndicatorView *activityIndicator_;
        Galleries *galleries_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) Galleries *galleries;

@end
