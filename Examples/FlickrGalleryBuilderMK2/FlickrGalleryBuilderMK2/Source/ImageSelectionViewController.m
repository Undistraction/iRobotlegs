//
//  ImageSelectionViewController.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "ImageSelectionViewController.h"
#import "NotificationNames.h"
#import "Image.h"
#import "ScrollViewUtils.h"

@interface ImageSelectionViewController()

-(void)contextSelectedGallerySelectedImageChanged:(NSNotification *)notification;
-(void)updateImage;
-(void)disableSelectionButtons;
-(void)enableSelectionButtons;
@end

@implementation ImageSelectionViewController

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize acceptButton = acceptButton_;
@synthesize rejectButton = rejectButton_;
@synthesize imageView = imageView_;
@synthesize scrollView = scrollView_;
@synthesize activityIndicator = activityIndicator_;
@synthesize image = image_;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Choose";
    }
    return self;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.acceptButton release];
    [self.rejectButton release];
    [self.imageView release];
    [self.imageView release];
    [self.scrollView release];
    [self.image release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = YES;
    self.activityIndicator.hidden = YES;
    [self enableSelectionButtons];
    [self updateImage];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView flashScrollIndicators];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.acceptButton = nil;
    self.rejectButton = nil;
    self.imageView = nil;
    self.imageView = nil;
    self.scrollView = nil;
    self.image = nil;
}


//------------------------------------------------------------------------------
//  UIScrollViewDelegate
//------------------------------------------------------------------------------

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [ScrollViewUtils centerViewIfSmaller:self.imageView inScrollView:self.scrollView];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)addContextObservers
{
    [self addContextObserver:NOTIFY_SELECTED_GALLERY_SELECTED_IMAGE_CHANGED selector:@selector(contextSelectedGallerySelectedImageChanged:)];
    [self addContextObserver:NOTIFY_SELECTED_GALLERY_EMPTY selector:@selector(contextSelectedGalleryEmpty:)];
    [self addContextObserver:NOTIFY_SELECTED_GALLERY_IMAGE_SELECTION_REACHED_END selector:@selector(contextSelectedGalleryImageSelectionREachedEnd:)];
}


//------------------------------------------------------------------------------
//  View Handlers
//------------------------------------------------------------------------------ 

-(IBAction)acceptButtonTouchUpInside:(id)sender
{
    NSNotification *notification = [NSNotification notificationWithName:REQUEST_ACCEPT_IMAGE
                                                                 object:self];
    [self post:notification];
}

-(IBAction)rejectButtonTouchUpInside:(id)sender
{
    NSNotification *notification = [NSNotification notificationWithName:REQUEST_REJECT_IMAGE
                                                                 object:self];
    [self post:notification];
}


//------------------------------------------------------------------------------
//  Context Handlers
//------------------------------------------------------------------------------

-(void)contextSelectedGallerySelectedImageChanged:(NSNotification *)notification
{
    self.image = [notification.userInfo objectForKey:@"image"];
    [self updateImage];
}

-(void)contextSelectedGalleryEmpty:(NSNotification *)notification
{
    [self disableSelectionButtons];
}

-(void)contextSelectedGalleryImageSelectionREachedEnd:(NSNotification *)notification
{
    [self disableSelectionButtons];
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)updateImage
{
    if(!self.scrollView)
        return;
    self.activityIndicator.hidden = NO;
    NSURL *url = [NSURL URLWithString:self.image.imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData: data];
    self.activityIndicator.hidden = YES;
    
    CGRect bounds;
    bounds.origin = CGPointZero;
    bounds.size = image.size;
   
    [self.imageView setImage:image];
    self.imageView.contentMode = UIViewContentModeTopLeft;
    self.imageView.bounds = bounds;
    //Bug with placing UIImageView in UIScrollView in InterfaceBuilder requires that 
    //the UIImageView's origini is reset to 0/0
    CGRect frame = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.imageView.frame = frame;
    self.scrollView.contentSize = bounds.size;
    [self.imageView removeFromSuperview];
    [self.scrollView addSubview:self.imageView];
    
    
    self.scrollView.clipsToBounds = YES;
    self.scrollView.maximumZoomScale = 1;
    self.scrollView.minimumZoomScale = [ScrollViewUtils minimumZoomScaleToShowAllOfView:self.imageView inScrollView:self.scrollView];
    [self.scrollView setZoomScale:1.0 animated:NO];
    [ScrollViewUtils centerView:self.imageView inScrollView:self.scrollView];
    [self enableSelectionButtons];
}

-(void)disableSelectionButtons
{
    self.acceptButton.enabled = NO;
    self.acceptButton.alpha = 0.4;
    self.rejectButton.enabled = NO;
    self.rejectButton.alpha = 0.4;
}

-(void)enableSelectionButtons;
{
    self.acceptButton.enabled = YES;
    self.acceptButton.alpha = 1;
    self.rejectButton.enabled = YES;
    self.rejectButton.alpha = 1;
}

@end
