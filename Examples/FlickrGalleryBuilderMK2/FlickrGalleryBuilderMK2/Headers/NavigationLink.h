//
//  NavigationLink.h
//  ViewStackController
//
//  Created by Pedr Browne on 13/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

@interface NavigationLink : NSObject
{
    @private
        UIViewController *viewController_;
        NSString *buttonLabelText_;
}


//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) UIViewController *viewController;
@property (retain, nonatomic) NSString *buttonLabelText;


//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

-(id)initWithViewController:(UIViewController *)viewController buttonLabelText:(NSString *)buttonLabelText;

@end
