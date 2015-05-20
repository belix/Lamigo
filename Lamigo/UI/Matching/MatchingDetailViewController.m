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
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UIView *userDescriptionContainer;
@property (weak, nonatomic) IBOutlet UIImageView *firstInterestImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondInterestImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdInterestImageView;

//*** constraints for different screensizes ***////
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileImageViewVerticalSpaceConstraint;
@property (nonatomic) NSInteger screenSizeDifferential;

//*** constraints for animation purposes ****///
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userDescriptionContainerHorizontalPositionConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userDescriptionContainerVerticalPositionConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstInterestVerticalPositionConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondInterestHorizontalPositionConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondInterestVerticalPositionConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdInterestHorizontalPositionConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdInterestVerticalPositionConstraint;

@end

@implementation MatchingDetailViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.view.frame.size.width == 320)
    {
        self.profileImageViewWidthConstraint.constant = 220;
        self.profileImageViewHeightConstraint.constant = 220;
        self.profileImageViewVerticalSpaceConstraint.constant = 60;
        self.screenSizeDifferential = 30;
    }
    
    self.userDescriptionContainer.hidden = YES;
    self.firstInterestImageView.hidden = YES;
    self.secondInterestImageView.hidden = YES;
    self.thirdInterestImageView.hidden = YES;
    
    self.profilePictureView.delegate = self;
    self.userIndex = 0;
}

#pragma mark - Setter

- (void)setUsers:(NSArray *)users
{
    _users = users;
    [self.profilePictureView setupProfilePictureLayout];
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
        self.flagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag-%@",user.nativeLanguage]];
    }
    if(_users.count > self.userIndex + 1)
    {
        User *user = _users[self.userIndex+1];
        self.profilePictureView.backPicture.image = [UIImage imageWithData:user.profilePicture];
    }
    self.profilePictureView.front.hidden = NO;
    self.profilePictureView.back.hidden = YES;
    
    [self moveContainerOutWithCompletion:^{}];
}

#pragma mark - DescriptionContainerAnimation

- (void)moveContainerOutWithCompletion:(void(^)())completion
{
    [self.view layoutIfNeeded];
    
    self.userDescriptionContainer.hidden = NO;
    self.firstInterestImageView.hidden = NO;
    self.secondInterestImageView.hidden = NO;
    self.thirdInterestImageView.hidden = NO;
    
    self.userDescriptionContainerHorizontalPositionConstraint.constant = -100 + self.screenSizeDifferential;
    self.userDescriptionContainerVerticalPositionConstraint.constant = 199 - self.screenSizeDifferential;
    self.firstInterestVerticalPositionConstraint.constant = -183 + self.screenSizeDifferential;
    self.secondInterestHorizontalPositionConstraint.constant = 83 - self.screenSizeDifferential;
    self.secondInterestVerticalPositionConstraint.constant = 163 - self.screenSizeDifferential;
    self.thirdInterestHorizontalPositionConstraint.constant = 139 - self.screenSizeDifferential;
    self.thirdInterestVerticalPositionConstraint.constant = 108 - self.screenSizeDifferential;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }
                     completion:^(BOOL finished){
                         completion();
                     }];
}

- (void)moveContainerInWithCompletion:(void(^)())completion
{
    [self.view layoutIfNeeded];
    self.userDescriptionContainerHorizontalPositionConstraint.constant = 0;
    self.userDescriptionContainerVerticalPositionConstraint.constant = 0;
    self.firstInterestVerticalPositionConstraint.constant = 0;
    self.secondInterestHorizontalPositionConstraint.constant = 0;
    self.secondInterestVerticalPositionConstraint.constant = 0;
    self.thirdInterestHorizontalPositionConstraint.constant = 0;
    self.thirdInterestVerticalPositionConstraint.constant = 0;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }
                     completion:^(BOOL finished){
                         completion();
                         self.userDescriptionContainer.hidden = YES;
                         self.firstInterestImageView.hidden = YES;
                         self.secondInterestImageView.hidden = YES;
                         self.thirdInterestImageView.hidden = YES;
                     }];
}

#pragma mark - Public

- (void)userDeclined
{
    [self moveContainerInWithCompletion:^{
        [self.profilePictureView userDeclined];
    }];
}

- (void)userAccepted
{
    [self moveContainerInWithCompletion:^{
        [self.profilePictureView userAccepted];
    }];
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
