//
//  UserGalleriesModel.m
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 04/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Objection-iOS/Objection.h>
#import "GalleriesCoreDataModel.h"
#import "Galleries.h"
#import "Gallery.h"
#import "Image.h"
#import "IRobotlegs.h"
#import "NotificationNames.h"

@interface GalleriesCoreDataModel()
    -(void)postGalleriesChanged;
@end

@implementation GalleriesCoreDataModel

irobotlegs_requires(@"managedObjectContext");

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize managedObjectContext = managedObjectContext_;
@synthesize galleries = galleries_;
@synthesize selectedGallery = selectedGallery_;

-(Galleries *)galleries
{
    if(!galleries_)
    {
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease]; 
        request.entity = [NSEntityDescription entityForName:@"Galleries" inManagedObjectContext:self.managedObjectContext];
        NSError *error = nil;
        NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:request error:&error];
        self.galleries = [fetchedObjects lastObject];
        if(!galleries_ && !error)
        {
            self.galleries = [Galleries initWithManagedObjectContext:self.managedObjectContext];
        }
    }
    return galleries_;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [self.managedObjectContext release];
    [self.galleries release];
    [self.selectedGallery release];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Public
//------------------------------------------------------------------------------ 

-(void)addGallery:(NSArray *)images named:(NSString *)name;
{
    Gallery *gallery = [Gallery initWithName:name photos:images managedObjectContext:self.managedObjectContext];
    [self.galleries addGalleriesObject:gallery];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:name forKey:@"name"];
    NSNotification *notification = [NSNotification notificationWithName:NOTIFY_GALLERY_ADDED
                                                                 object:self
                                                               userInfo:userInfo];
    [self post:notification];
    [self postGalleriesChanged];
}

-(void)selectGalleryNamed:(NSString *)name
{
    self.selectedGallery = [self galleryNamed:name];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.selectedGallery forKey:@"gallery"];
    NSNotification *notification = [NSNotification notificationWithName:NOTIFY_SELECTED_GALLERY_CHANGED
                                                                 object:self
                                                               userInfo:userInfo];
    NSLog(@"POSTING CHANGE NOTE");
    [self post:notification];
}


-(Gallery *)galleryNamed:(NSString *)name
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    request.entity = [NSEntityDescription entityForName:@"Gallery" inManagedObjectContext:self.managedObjectContext];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSError *error = nil;
    Gallery *gallery = [self.managedObjectContext executeFetchRequest:request error:&error].lastObject;
    return gallery;
}

-(void)removeSelectedGallery:(NSString *)name
{
    Gallery *gallery = [self galleryNamed:name];
    [self.galleries removeGalleriesObject:gallery];
    self.selectedGallery = nil;
    [self postGalleriesChanged];
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)postGalleriesChanged
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.galleries forKey:@"galleries"];
    NSNotification *notification = [NSNotification notificationWithName:NOTIFY_GALLERIES_CHANGED
                                                                 object:self
                                                               userInfo:userInfo];
    [self post:notification];
}

-(void)saveGalleries
{
    NSError *error = nil;
    [self.managedObjectContext save:&error];
    if(!error)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self.galleries forKey:@"galleries"];
        NSNotification *notification = [NSNotification notificationWithName:NOTIFY_GALLERIES_SAVED
                                                                 object:self
                                                               userInfo:userInfo];
        [self post:notification];
    }
}

@end