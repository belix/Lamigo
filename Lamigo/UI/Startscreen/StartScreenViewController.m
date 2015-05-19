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
#import "MatchingDetailViewController.h"
#import "MBProgressHUD.h"
#import "SuccessfulMatchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StartScreenViewController () <MatchingClientDelegate,MatchingDetailDelegate>

@property (nonatomic, strong) MatchingClient *matchingClient;
@property (nonatomic, strong) MatchingDetailViewController *matchingDetailViewController;
@property (weak, nonatomic) IBOutlet UIView *searchingView;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) User *matchedUser;

@end

@implementation StartScreenViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.matchingClient = [[MatchingClient alloc] init];
    self.matchingClient.delegate = self;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self.matchingClient fetchAllPossibleUser];
    });
}

#pragma mark - IBActions

- (IBAction)userDeclinedButtonPressed:(id)sender
{
    User *user = self.users[self.matchingDetailViewController.userIndex];
    [self.matchingClient declineUser:user];
    
    [self.matchingDetailViewController userDeclined];
}

- (IBAction)userAcceptedButtonPressed:(id)sender
{
    User *user = self.users[self.matchingDetailViewController.userIndex];
    [self.matchingClient acceptUser:user completion:^(BOOL success, User *user){
        
        if (success)
        {
            self.matchedUser = user;
            [self performSegueWithIdentifier:@"showSuccessfullMatchView" sender:nil];
        }
        
    }];
    
    [self.matchingDetailViewController userAccepted];
}

#pragma mark - MatchingClientDelegate

- (void)possibleUserLoaded:(NSArray *)users
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (users.count > 0)
        {
            self.users = users;
            self.matchingDetailViewController.users = users;
            //fade out searching view
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options: UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.searchingView.alpha = 0;
                             }
                             completion:^(BOOL finished){
                                 self.searchingView.hidden = YES;
                             }];
        }
    });

}

#pragma mark - MatchingDetailDelegate

- (void)noMoreUsers
{
    self.searchingView.hidden = NO;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.searchingView.alpha = 1;
                     }
                     completion:^(BOOL finished){

                     }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"matchingDetailViewController"])
    {
        self.matchingDetailViewController = segue.destinationViewController;
        self.matchingDetailViewController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"showSuccessfullMatchView"])
    {
        SuccessfulMatchViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.user = self.matchedUser;
    }
}


@end
