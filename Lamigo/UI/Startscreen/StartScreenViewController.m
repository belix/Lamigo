//
//  StartScreenViewController.m
//  Lamigo
//
//  Created by Felix Belau on 13.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "StartScreenViewController.h"
#import "User.h"
#import "MatchingClient.h"
#import <QuartzCore/QuartzCore.h>

@interface StartScreenViewController () <MatchingClientDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (nonatomic, strong) MatchingClient *matchingClient;

@end

@implementation StartScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MatchingClient *matchingClient = [[MatchingClient alloc] init];
    matchingClient.delegate = self;
    [matchingClient fetchAllPossibleUser];
    
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MatchingClientDelegate

- (void)possibleUserLoaded:(NSArray *)users
{
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:users[0][@"profilePicture"] options:0];
    self.profilePicture.image = [UIImage imageWithData:imageData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end