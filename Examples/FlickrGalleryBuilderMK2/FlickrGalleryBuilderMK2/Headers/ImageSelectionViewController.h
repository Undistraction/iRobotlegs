//
//  ImageSelectionViewController.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <UIKit/UIKit.h>
#import "IRViewController.h"
#import "Image.h"

@interface ImageSelectionViewController : IRViewController<UIScrollViewDelegate>
{
    @private
        UIButton *acceptButton_;
        UIButton *rejectButton_;
        UIImageView *imageView_;
        UIScrollView *scrollView_;
        UIActivityIndicatorView *activityIndicator_;
        Image *image_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) IBOutlet UIButton *acceptButton;
@property (retain, nonatomic) IBOutlet UIButton *rejectButton;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) Image *image;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

-(IBAction)acceptButtonTouchUpInside:(id)sender;
-(IBAction)rejectButtonTouchUpInside:(id)sender;

@end