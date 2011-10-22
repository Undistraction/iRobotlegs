//
//  NavigationLink.m
//  ViewStackController
//
//  Created by Pedr Browne on 13/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "NavigationLink.h"

@implementation NavigationLink

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize viewController = viewController_;
@synthesize buttonLabelText = buttonLabelText_;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

-(id)initWithViewController:(UIViewController *)viewController buttonLabelText:(NSString *)buttonLabelText
{
    if(self = [super init])
    {
        self.viewController = viewController;
        self.buttonLabelText = buttonLabelText;
    }
    return self;
}

-(id)init
{
    return [self initWithViewController:nil buttonLabelText:nil];
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

-(void)dealloc
{
    [self.viewController release];
    [self.buttonLabelText release];
    [super dealloc];
}

@end
