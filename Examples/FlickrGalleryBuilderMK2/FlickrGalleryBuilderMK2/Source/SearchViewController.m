//
//  SearchViewController.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 16/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "SearchViewController.h"
#import "NotificationNames.h"
#import "Image.h"
#import "Gallery.h"

@interface SearchViewController()

-(IBAction)cancelButtonTouchUpInside:(id)sender;
-(void)contextKeywordSearchComplete:(NSNotification *)notification;
-(void)contextKeywordSearchFailed:(NSNotification *)notification;
-(void)showActivityIndictator;
-(void)hideActivityIndicator;

@end

@implementation SearchViewController

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize searchTextField = searchTextField_;
@synthesize cancelButton = cancelButton_;
@synthesize tableView = tableView_;
@synthesize activityIndicator = activityIndicator_;
@synthesize galleries = galleries_;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Search";
    }
    return self;
}

//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.searchTextField release];
    [self.cancelButton release];
    [self.tableView release];
    [self.activityIndicator release];
    [self.galleries release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


//------------------------------------------------------------------------------
//  View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self hideActivityIndicator];
    self.searchTextField.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.cancelButton.hidden = YES;
    self.tableView.rowHeight = 75;
    [self.tableView reloadData];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.searchTextField = nil;
    self.cancelButton = nil;
    self.tableView = nil;
    self.activityIndicator = nil;
}


//------------------------------------------------------------------------------
//  UITextFieldDelegate
//------------------------------------------------------------------------------

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.cancelButton.hidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(self.searchTextField.text.length > 0)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.searchTextField.text forKey:@"keyword"];
        NSNotification *notification = [NSNotification notificationWithName:REQUEST_IMAGES_FOR_KEYWORD 
                                                                     object:self
                                                                   userInfo:userInfo];
        [self showActivityIndictator];
        self.activityIndicator.hidden = NO;
        self.cancelButton.hidden = YES;
        [self post:notification];
    }    
    return NO;
}


//------------------------------------------------------------------------------
//  UITableViewViewDelegate
//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Gallery *gallery = [self.galleries.galleries objectAtIndex:indexPath.row];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:gallery.name forKey:@"name"];
    NSNotification *notification = [NSNotification notificationWithName:REQUEST_VIEW_GALLERY 
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
    return [self.galleries.galleries count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"galleryCell"];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"galleryCell"] autorelease];
    }
    Gallery *gallery = [self.galleries.galleries objectAtIndex:indexPath.row];
    Image *image = [gallery.images objectAtIndex:0];
    NSString *galleryName = gallery.name;
    cell.textLabel.text = [galleryName stringByReplacingCharactersInRange:NSMakeRange(0,1) 
                                                               withString:[[galleryName substringToIndex:1]uppercaseString]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i images", [gallery.images count]];
    cell.imageView.image = [UIImage imageWithData:image.thumbnailData];
    return cell;
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(void)addContextObservers
{
    [self addContextObserver:NOTIFY_GALLERIES_AVAILABLE selector:@selector(contextGalleriesAvailable:)];
    [self addContextObserver:NOTIFY_GALLERIES_CHANGED selector:@selector(contextGalleriesChanged:)];
    [self addContextObserver:NOTIFY_KEYWORD_SEARCH_FAILED selector:@selector(contextKeywordSearchFailed:)];
    [self addContextObserver:NOTIFY_KEYWORD_SEARCH_COMPLETE selector:@selector(contextKeywordSearchComplete:)];
}


//------------------------------------------------------------------------------
//  Context Handlers
//------------------------------------------------------------------------------

-(void)contextKeywordSearchComplete:(NSNotification *)notification
{
    [self hideActivityIndicator];
}

-(void)contextKeywordSearchFailed:(NSNotification *)notification
{
    [self hideActivityIndicator];
}

-(void)contextGalleriesAvailable:(NSNotification *)notification
{
    self.galleries = [notification.userInfo objectForKey:@"galleries"];
    [self.tableView reloadData];
}

-(void)contextGalleriesChanged:(NSNotification *)notification
{
    self.galleries = [notification.userInfo objectForKey:@"galleries"];
    [self.tableView reloadData];
}


//------------------------------------------------------------------------------
//  View Handlers
//------------------------------------------------------------------------------

-(IBAction)cancelButtonTouchUpInside:(id)sender
{

    [self.searchTextField resignFirstResponder];
    self.cancelButton.hidden = YES;
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)showActivityIndictator
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

-(void)hideActivityIndicator
{
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}

@end
