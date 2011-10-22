//
//  iRViewController.m
//  iRobotlegs
//
//  Created by Pedr Browne on 18/09/2011.
//  Copyright (c) 2011 the original author or authors
//  Based on the Robotlegs Framework for Actionscript 3: http://www.robotlegs.org
//  Permission is hereby granted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it.
//

#import "IRMediatedViewController.h"
#import "IRConstants.h"

@interface IRMediatedViewController()

-(void)postCreated;
-(void)postDestroyed;

@end


@implementation IRMediatedViewController

//------------------------------------------------------------------------------
//  Initialisation
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self postCreated];
    return self;
}


//------------------------------------------------------------------------------
//  Lifecycle
//------------------------------------------------------------------------------

-(void)dealloc
{
    [self postDestroyed];
    [super dealloc];
}


//------------------------------------------------------------------------------
//  Private
//------------------------------------------------------------------------------

-(void)postCreated
{
    NSNotification *notification = [NSNotification notificationWithName:OBJECT_ALLOCATED object:self];
    [[NSNotificationCenter defaultCenter] postNotification: notification];
}

-(void)postDestroyed
{
    NSNotification *notification = [NSNotification notificationWithName:OBJECT_DEALLOCATED object:self];
    [[NSNotificationCenter defaultCenter] postNotification: notification];
}



@end
