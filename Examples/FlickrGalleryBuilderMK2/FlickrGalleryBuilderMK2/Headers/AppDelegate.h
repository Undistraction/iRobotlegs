//
//  AppDelegate.h
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 06/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <UIKit/UIKit.h>
#import "IRobotlegs.h"
#import "AppContext.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    AppContext *applicationContext_;
}

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readwrite, retain, nonatomic) AppContext *applicationContext;


//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

- (NSURL *)applicationDocumentsDirectory;

@end
