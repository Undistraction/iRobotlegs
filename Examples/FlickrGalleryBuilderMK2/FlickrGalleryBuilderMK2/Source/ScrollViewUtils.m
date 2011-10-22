//
//  ScrollViewUtils.m
//  Places2
//
//  Created by Pedr Browne on 13/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "ScrollViewUtils.h"

@implementation ScrollViewUtils

+ (void)centerViewIfSmaller:(UIView *)view inScrollView:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)? 
                      (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)? 
                      (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    view.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, 
                                   scrollView.contentSize.height * 0.5 + offsetY);
}

+ (void)centerView:(UIView *)view inScrollView:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5;
    CGFloat offsetY = (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5;
    [scrollView setContentOffset:CGPointMake(-offsetX, -offsetY)];
}

+ (float)minimumZoomScaleToShowAllOfView:(UIView * )view inScrollView:(UIScrollView *)scrollView
{
    double horizontalRatio = scrollView.bounds.size.width / scrollView.contentSize.width;
    double verticalRatio = scrollView.bounds.size.height / scrollView.contentSize.height;
    
    double minimumZoomScale = (horizontalRatio < verticalRatio) ? horizontalRatio : verticalRatio;
    return minimumZoomScale;
}


@end
