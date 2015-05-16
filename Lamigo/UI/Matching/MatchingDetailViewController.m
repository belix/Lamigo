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
@property (nonatomic) NSInteger userIndex;

@end

@implementation MatchingDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profilePictureView.delegate = self;
    self.userIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter

- (void)setUsers:(NSArray *)users
{
    _users = users;
    [self updateUI];
}

- (void)updateUI
{
    
    if(_users[self.userIndex])
    {
        User *user = _users[self.userIndex];
        self.profilePictureView.frontPicture.image = [UIImage imageWithData:user.profilePicture];
        self.usernameLabel.text = user.username;
    }
    if(_users[self.userIndex+1])
    {
        User *user = _users[self.userIndex+1];
        self.profilePictureView.backPicture.image = [UIImage imageWithData:user.profilePicture];
    }
    self.profilePictureView.front.hidden = NO;
    self.profilePictureView.back.hidden = YES;
}

- (void)userDeclined
{
    [self.profilePictureView flip];
}

#pragma mark - FlippingCardDelegate

- (void)cardFlippingFinished
{
    self.userIndex++;
    if (self.userIndex >= self.users.count - 1)
    {
        NSLog(@"no more matches");
    }
    else
    {
        [self updateUI];
    }
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
