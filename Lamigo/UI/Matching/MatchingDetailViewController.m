//
//  MatchingDetailViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "MatchingDetailViewController.h"
#import "MatchingProfileImageView.h"
#import "FlippingCardDelegate.h"

@interface MatchingDetailViewController () <FlippingCardDelegate>

@property (weak, nonatomic) IBOutlet MatchingProfileImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation MatchingDetailViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profilePictureView.delegate = self;
    self.userIndex = 0;
}

#pragma mark - Setter

- (void)setUsers:(NSArray *)users
{
    _users = users;
    [self updateUI];
}

#pragma mark - Internal

- (void)updateUI
{
    if(_users.count > self.userIndex)
    {
        User *user = _users[self.userIndex];
        self.profilePictureView.frontPicture.image = [UIImage imageWithData:user.profilePicture];
        self.usernameLabel.text = user.username;
    }
    if(_users.count > self.userIndex + 1)
    {
        User *user = _users[self.userIndex+1];
        self.profilePictureView.backPicture.image = [UIImage imageWithData:user.profilePicture];
    }
    self.profilePictureView.front.hidden = NO;
    self.profilePictureView.back.hidden = YES;
}

#pragma mark - Public

- (void)userDeclined
{
    [self.profilePictureView userDeclined];
}

- (void)userAccepted
{
    [self.profilePictureView userAccepted];
}

#pragma mark - FlippingCardDelegate

- (void)cardFlippingFinished
{
    self.userIndex++;
    if (self.userIndex >= self.users.count - 1)
    {
        [self.delegate noMoreUsers];
        NSLog(@"no more matches");
    }
    else
    {
        [self updateUI];
    }
}

@end
