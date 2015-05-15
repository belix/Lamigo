//
//  RootViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "RootViewController.h"
#import "User.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([User currentUser])
    {
        [self performSegueWithIdentifier:@"showStartscreenViewController" sender:nil];
        NSLog(@"user already logged in");
        // User is logged in, do work such as go to next view controller.
    }
    else
    {
        [self performSegueWithIdentifier:@"showLoginViewController" sender:nil];
    }
    
}


@end
