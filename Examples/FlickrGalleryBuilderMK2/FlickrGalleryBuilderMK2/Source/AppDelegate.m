//
//  AppDelegate.m
//  FlickrGalleryBuilderMK2
//
//  Created by Pedr Browne on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchViewController.h"
#import "ImageSelectionViewController.h"
#import "GalleryViewController.h"
#import "ApplicationStackViewController.h"
#import "NavigationLink.h"

@implementation AppDelegate

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize applicationContext = applicationContext_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //Create ApplicationContext
    self.applicationContext = [[[AppContext alloc] initWithAutoStartUp:NO] autorelease];
    self.applicationContext.managedObjectContext = self.managedObjectContext;
    
    //Create and Configure Stack and its child ViewControllers
    ApplicationStackViewController *applicationStackViewController = [[[ApplicationStackViewController alloc] initWithNotificationCenter:self.applicationContext.notificationCenter] autorelease];
    
    SearchViewController *searchViewController = [[[SearchViewController alloc] initWithNotificationCenter:self.applicationContext.notificationCenter] autorelease];
    ImageSelectionViewController *imageSelectionViewController = [[[ImageSelectionViewController alloc] initWithNotificationCenter:self.applicationContext.notificationCenter] autorelease];
    GalleryViewController *galleryViewController = [[[GalleryViewController alloc] initWithNotificationCenter:self.applicationContext.notificationCenter] autorelease];
    
    NavigationLink *imageSelectionViewControllerLeftLink = [[[NavigationLink alloc] initWithViewController:searchViewController 
                                                                                          buttonLabelText:@"New Search"] autorelease];
    NavigationLink *imageSelectionViewControllerRightLink = [[[NavigationLink alloc] initWithViewController:galleryViewController 
                                                                                          buttonLabelText:@"Save Gallery"] autorelease];
    
    NavigationLink *galleryViewControllerLeftLink = [[[NavigationLink alloc] initWithViewController:imageSelectionViewController
                                                                                          buttonLabelText:@"Edit Photos"] autorelease];
    NavigationLink *galleryViewControllerRightLink = [[[NavigationLink alloc] initWithViewController:searchViewController 
                                                                                          buttonLabelText:@"New Search"] autorelease];
                                                                                          
    [applicationStackViewController addViewController:searchViewController
                                       leftLink:nil
                                      rightLink:nil];
                                      
    [applicationStackViewController addViewController:imageSelectionViewController
                                  leftLink:imageSelectionViewControllerLeftLink
                                 rightLink:imageSelectionViewControllerRightLink];
                                 
    [applicationStackViewController addViewController:galleryViewController
                                  leftLink:galleryViewControllerLeftLink
                                 rightLink:galleryViewControllerRightLink];
    
    self.window.rootViewController = applicationStackViewController;
    
    //Set Initial View
    applicationStackViewController.selectedIndex = SEARCH_VIEW_INDEX;
    
    //Framework Startup
    [self.applicationContext startup];
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;
}


//------------------------------------------------------------------------------
//  CoreData
//------------------------------------------------------------------------------ 

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FlickrGalleryBuilderMK2" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FlickrGalleryBuilderMK2.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
