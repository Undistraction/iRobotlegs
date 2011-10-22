//
//  TestNotification.h
//  iRobotlegs
//
//  Created by Pedr Browne on 27/09/2011.
//  Copyright (c) 2011 the original author or authors

//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import <Foundation/Foundation.h>

extern NSString *const TEST_NOTIFICATION_NAME;


@interface TestNotification : NSNotification
{
    id object_;
}

-(id)initWithObject:(id)object;

@end
