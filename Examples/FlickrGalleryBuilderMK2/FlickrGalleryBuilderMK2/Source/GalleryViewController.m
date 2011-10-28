//
//  GalleryViewController.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "GalleryViewController.h"
#import "NotificationNames.h"
#import "Image.h"

@implementation GalleryViewController

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize titleTextField = titleTextField_;
@synthesize tableView = tableView_;
@synthesize gallery = gallery_;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Gallery";
    }
    return self;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.titleTextField release];
    [self.tableView release];
    [self.gallery release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 75;
    NSString *galleryName = self.gallery.name;
    self.titleTextField.text = [galleryName stringByReplacingCharactersInRange:NSMakeRange(0,1) 
                                                               withString:[[galleryName substringToIndex:1]uppercaseString]];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.titleTextField = nil;
    self.tableView = nil;
    self.gallery = nil;
}


//------------------------------------------------------------------------------
//  UITableViewViewDelegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSNumber *imageIndex = [[[NSNumber alloc] initWithInt:indexPath.row] autorelease];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:imageIndex forKey:@"imageIndex"];
    NSNotification *notification = [NSNotification notificationWithName:REQUEST_SELECT_IMAGE 
                                                                     object:self
                                                                   userInfo:userInfo];
    [self post:notification];
}


//------------------------------------------------------------------------------
//  UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gallery.images count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"galleryCell"];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"galleryCell"] autorelease];
    }
    Image *image = [self.gallery.images objectAtIndex:indexPath.row];
    cell.textLabel.text = image.name;
    cell.imageView.image = [UIImage imageWithData:image.thumbnailData];
    return cell;
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)addContextObservers
{
    [self addContextObserver:NOTIFY_SELECTED_GALLERY_CHANGED selector:@selector(contextSelectedGalleryChanged:)];
    [self addContextObserver:NOTIFY_SELECTED_GALLERY_IMAGES_CHANGED selector:@selector(contextSelectedGalleryImagesChanged:)];
}


//------------------------------------------------------------------------------
//  Context Handlers
//------------------------------------------------------------------------------

-(void)contextSelectedGalleryChanged:(NSNotification *)notification
{
    self.gallery = [notification.userInfo objectForKey:@"gallery"];
    NSString *galleryName = self.gallery.name;
    self.titleTextField.text = [galleryName stringByReplacingCharactersInRange:NSMakeRange(0,1) 
                                                               withString:[[galleryName substringToIndex:1]uppercaseString]];
    [self.tableView reloadData];
}

-(void)contextSelectedGalleryImagesChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

@end
