//
//  MainMenuViewController.m
//  F.I.T.
//
//  Created by Felix Belau on 17.02.15.
//  Copyright (c) 2015 FIT-Team. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MainMenuTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "User.h"

@interface MainMenuViewController ()


@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (nonatomic, strong) LoginClient *loginClient;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;

@property (weak, nonatomic) IBOutlet UISwitch *offlineVersionSwitch;

@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuTitles = @[@"Lamigoo", @"Chats",@"Settings", @"Help"];
    self.menuIcons = @[@"home-icon", @"chats-icon", @"settings-icon", @"help-icon"];
    self.loginClient = [[LoginClient alloc] init];
    self.loginClient.delegate = self;
    self.profilePictureImageView.layer.cornerRadius = 25;
    self.profilePictureImageView.clipsToBounds = YES;
    
    User *currentUser = [User currentUser];
    self.usernameLabel.text = currentUser.username;
    self.profilePictureImageView.image = [UIImage imageWithData:currentUser.profilePicture];
}

#pragma mark - IBActions

- (IBAction)offlineVersionSwitch:(UISwitch *)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.isOfflineVersion = sender.isOn;
}

- (IBAction)logoutButtonPressed:(id)sender
{
    [self.loginClient logout];
}

- (IBAction)feedbackButtonPressed:(id)sender
{
    NSString *recipients = @"mailto:?to=support@halleluja.com&subject=Feedback for Halleluja";
    NSString *body = @"&body=How dou you like the app? Just leave some Feedback here: ";
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"startscreenNavController"]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            break;
            [self.sideMenuViewController setContentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"couponNavController"]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];

        case 2:
            break;
            [self.sideMenuViewController setContentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"partnerNavController"]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            NSLog(@"show exercises screen");
            break;
        case 4:
            NSLog(@"show statistics screen");
            break;
        default:
            break;
    }
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuCell";
    
    MainMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];

    cell.titleLabel.text = self.menuTitles[indexPath.row];
    cell.cellIcon.image = [UIImage imageNamed:self.menuIcons[indexPath.row]];
    
    return cell;
}

#pragma mark - LoginClientDelegateMethods

- (void)logoutSuccessful
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
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
