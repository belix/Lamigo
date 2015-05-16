//
//  MatchingDetailViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "MatchingDetailViewController.h"
#import "MatchingProfileImageView.h"

@interface MatchingDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet MatchingProfileImageView *profilePictureView;

@end

@implementation MatchingDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)userDeclined
{
    [self.profilePictureView flip];
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
