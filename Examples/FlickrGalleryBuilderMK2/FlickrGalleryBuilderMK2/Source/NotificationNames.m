//
//  NotificationNames.m
//  FlickrGalleryBuilder
//
//  Created by Pedr Browne on 04/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "NotificationNames.h"

NSString *const SELECTED_GALLERY_CHANGED = @"selectedGalleryChanged";

NSString *const REQUEST_IMAGES_FOR_KEYWORD = @"requestImagesForKeyword";

NSString *const NOTIFY_KEYWORD_SEARCH_COMPLETE = @"notifyKeywordSearchComplete";
NSString *const NOTIFY_KEYWORD_SEARCH_FAILED = @"notifyKeywordSearchFailed";

NSString *const NOTIFY_GALLERIES_AVAILABLE = @"notifyGalleriesAvailable";
NSString *const NOTIFY_GALLERIES_CHANGED = @"notifyGalleriesChanged";
NSString *const NOTIFY_GALLERIES_SAVED = @"notifyGalleriesSaved";
NSString *const NOTIFY_GALLERY_ADDED = @"notifyGalleryAdded";
NSString *const NOTIFY_SELECTED_GALLERY_CHANGED = @"notifyGallerySelected";

NSString *const NOTIFY_SELECTED_GALLERY_SELECTED_IMAGE_CHANGED = @"notifySelectedGallerySelectedImageChanged";
NSString *const NOTIFY_SELECTED_GALLERY_IMAGE_SELECTION_REACHED_END = @"notifySelectedGalleryImageSelectionComplete";
NSString *const NOTIFY_SELECTED_GALLERY_IMAGES_CHANGED = @"notifySelectedGalleryImagesChanged";
NSString *const NOTIFY_SELECTED_GALLERY_EMPTY = @"notifySelectedGalleryEmpty";

NSString *const REQUEST_REJECT_IMAGE = @"requestRejectImage";
NSString *const REQUEST_ACCEPT_IMAGE = @"requestAcceptImage";
NSString *const REQUEST_SELECT_IMAGE = @"requestSelectImage";

NSString *const REQUEST_DELETE_GALLERY = @"requestDeleteGallery";
NSString *const REQUEST_SAVE_GALLERY = @"requestSaveGallery";

NSString *const REQUEST_VIEW_GALLERY = @"requestViewGallery";

NSString *const REQUEST_SELECTED_GALLERY = @"requestSelectedGallery";
NSString *const RESPONSE_SELECTED_GALLERY = @"responseSelectedGallery";
