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
#import <QuartzCore/QuartzCore.h>

@interface StartScreenViewController () <MatchingClientDelegate>

@property (nonatomic, strong) MatchingClient *matchingClient;
@property (nonatomic, strong) MatchingDetailViewController *matchingDetailViewController;
@property (weak, nonatomic) IBOutlet UIView *searchingView;
@property (nonatomic, strong) NSArray *users;

@end

@implementation StartScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.matchingClient = [[MatchingClient alloc] init];
    self.matchingClient.delegate = self;
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self.matchingClient fetchAllPossibleUser];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userDeclinedButtonPressed:(id)sender
{
    User *user = self.users[self.matchingDetailViewController.userIndex];
    [self.matchingClient declineUser:user];
    
    [self.matchingDetailViewController userDeclined];
}

- (IBAction)userAcceptedButtonPressed:(id)sender
{
    User *user = self.users[self.matchingDetailViewController.userIndex];
    [self.matchingClient acceptUser:user];
}

#pragma mark - MatchingClientDelegate

- (void)possibleUserLoaded:(NSArray *)users
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"users.count %ld",users.count);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
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
        else
        {
            
        }
    });

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"matchingDetailViewController"])
    {
        self.matchingDetailViewController = segue.destinationViewController;
    }
}


@end
