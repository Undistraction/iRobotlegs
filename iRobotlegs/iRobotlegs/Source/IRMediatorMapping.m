//
//  IRMappingConfig.m
//  iRobotlegs
//
//  Created by Pedr Browne on 20/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRMediatorMapping.h"

@implementation IRMediatorMapping

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@synthesize mediatorClass = mediatorClass_;
@synthesize autoCreate = autoCreate_;
@synthesize autoRemove = autoRemove_;
@synthesize typedMediatedObjectClasses = typedMediatedObjectClasses_;


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

- (void)dealloc {
    self.mediatorClass = nil;
    self.typedMediatedObjectClasses = nil;
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Overridden
//------------------------------------------------------------------------------ 

-(NSString *) description {
    return [NSString stringWithFormat:@"<IRMediatorMapping: %p>\n   mediatorClass: %@\n   autoCreate: %@\n   autoRemove: %@\n   typedMediatedObjectClasses %@",
            self, self.mediatorClass, (self.autoCreate ? @"YES" : @"NO"), (self.autoRemove ? @"YES" : @"NO"), self.typedMediatedObjectClasses];
}

@end
