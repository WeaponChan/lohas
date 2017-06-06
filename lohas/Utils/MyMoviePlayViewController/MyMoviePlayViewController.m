//
//  MyMoviePlayViewController.m
//  musicleague
//
//  Created by mudboy on 14-4-20.
//  Copyright (c) 2014年 cuuse. All rights reserved.
//

#import "MyMoviePlayViewController.h"

@interface MyMoviePlayViewController ()

@end

@implementation MyMoviePlayViewController


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return UIDeviceOrientationIsLandscape(interfaceOrientation);
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (NSUInteger)application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window
{
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
