//
//  ViewControllerRelationship.h
//  ViewStackController
//
//  Created by Pedr Browne on 13/10/2011.
//  Copyright (c) 2011 the original author or authors
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>
#import "NavigationLink.h"

@interface ViewControllerRelationship : NSObject
{
    @protected
        UIViewController *viewController_;
        NavigationLink *leftLink_;
        NavigationLink *rightLink_;
}


//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) UIViewController *viewController;
@property (retain, nonatomic) NavigationLink *leftLink;
@property (retain, nonatomic) NavigationLink *rightLink;

@end
