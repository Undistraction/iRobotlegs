//
//  ScrollViewUtils.h
//  Places2
//
//  Created by Pedr Browne on 13/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

@interface ScrollViewUtils : NSObject

//------------------------------------------------------------------------------
//  API
//------------------------------------------------------------------------------

+ (void)centerView:(UIView *)view inScrollView:(UIScrollView *)scrollView;
+ (void)centerViewIfSmaller:(UIView *)view inScrollView:(UIScrollView *)scrollView;
+ (float)minimumZoomScaleToShowAllOfView:(UIView * )view inScrollView:(UIScrollView *)scrollView;

@end
