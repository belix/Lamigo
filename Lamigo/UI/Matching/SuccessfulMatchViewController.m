//
//  SuccessfulMatchViewController.m
//  Lamigo
//
//  Created by Felix Belau on 19.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "SuccessfulMatchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SuccessfulMatchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabe;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

@end

@implementation SuccessfulMatchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.size.width/2;
    self.profilePictureImageView.clipsToBounds = YES;
    self.profilePictureImageView.image = [UIImage imageWithData:self.user.profilePicture];
    self.userDescriptionLabe.text = self.user.username;
    self.flagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag-%@",self.user.nativeLanguage]];
    self.locationLabel.text = @"Munich";
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
