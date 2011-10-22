//
//  IRMappingConfig.h
//  iRobotlegs
//
//  Created by Pedr Browne on 20/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

@interface IRMediatorMapping : NSObject//<NSCopying>
{
    @private 
        Class mediatorClass_;
        BOOL autoCreate_;
        BOOL autoRemove_;
        NSMutableArray *typedMediatedObjectClasses_;
} 

//------------------------------------------------------------------------------
//  Getter / Setter
//------------------------------------------------------------------------------

@property (retain, nonatomic) Class mediatorClass;
@property (nonatomic) BOOL autoCreate;
@property (nonatomic) BOOL autoRemove;
@property (retain, nonatomic) NSMutableArray *typedMediatedObjectClasses;

@end