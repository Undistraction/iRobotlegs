//
//  FlickrSearchService.m
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 04/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "FlickrAPIKey.h"
#import "FlickrUtils.h"
#import "FlickrSearchService.h"
#import "SBJson.h"
#import "NotificationNames.h"
#import "IRobotlegs.h"

@interface FlickrSearchService()
    @property (retain, nonatomic) NSString *searchRequest;
    @property (retain, nonatomic) NSURLConnection *connection;
@end

@implementation FlickrSearchService

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize searchRequest = searchRequest_;
@synthesize connection = connection_;

//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)searchUsingKeyword:(NSString *)keyword
{
    NSString *urlEncodedKeyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
    NSString *urlString = [NSString stringWithFormat:FLICKR_KEYWORD_SEARCH_REQUEST_URL_TOKENISED, 
     FLICKR_API_KEY, urlEncodedKeyword];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    self.searchRequest = keyword;
    self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.connection release];
    [self.searchRequest release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  NSURLDelegate
//------------------------------------------------------------------------------

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.connection = nil;
    NSString *errorMessage = [NSString stringWithFormat:@"Connection Failed. Error: &@ %@", [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
          
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage forKey:@"errorMessage"];
    NSNotification *notification = [NSNotification notificationWithName:NOTIFY_KEYWORD_SEARCH_FAILED
                                                                 object:self 
                                                               userInfo:userInfo];
    [self post:notification];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    NSMutableArray *photoData = [[NSMutableArray alloc] init];
    // Store incoming data into a string
    NSString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    // Create a dictionary from the JSON string
    NSDictionary *results = [jsonString JSONValue];
    // Build an array from the dictionary for easy access to each entry
    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];

    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithArray:photos], @"photos",
                                                                                         self.searchRequest, @"keyword",
                                                                                                       nil];
                                                                                                     
     NSNotification *notification = [NSNotification notificationWithName:NOTIFY_KEYWORD_SEARCH_COMPLETE
                                                                  object:self 
                                                                userInfo:userInfo];
    [photoData release];
    [self post:notification];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.connection = nil;
}

@end