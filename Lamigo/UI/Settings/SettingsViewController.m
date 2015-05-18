//
//  SettingsViewController.m
//  Lamigo
//
//  Created by Felix Belau on 16.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsInterestsTableViewCell.h"
#import "User.h"
#import "ContentProvider.h"
#import "SettingsClient.h"
#import "SettingsLanguageViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController () <SettingsClientDelegate>

@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nativeLanguageImageView;
@property (weak, nonatomic) IBOutlet UIImageView *learningLanguageImageVie;
@property (weak, nonatomic) IBOutlet UIImageView *universalLanguageImageView;

@property (weak, nonatomic) IBOutlet UITableView *interestsTableView;
@property (nonatomic, strong) NSArray *interests;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;


@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) SettingsClient *settingsClient;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentUser = [User currentUser];

    self.userDescriptionLabel.text = self.currentUser.username;
    self.profilePicture.image = [UIImage imageWithData:self.currentUser.profilePicture];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
    
    self.settingsClient = [[SettingsClient alloc] init];
    self.settingsClient.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUserInterface];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableViewHeightConstraint.constant = self.interestsTableView.contentSize.height;
    [self.view layoutIfNeeded];
}

- (void)updateUserInterface
{
    self.currentUser = [User currentUser];
    
    self.nativeLanguageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag-%@",self.currentUser.nativeLanguage]];
    self.learningLanguageImageVie.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag-%@",self.currentUser.learningLanguage]];
    self.universalLanguageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag-%@",self.currentUser.universalLanguage]];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentUser.interests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingsInterestsTableViewCell";
    SettingsInterestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.titleLabel.text = [ContentProvider interestNameForID:self.currentUser.interests[indexPath.row]];
    cell.interestsImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"interests-%@-icon-black",[self.interests[indexPath.row] lowercaseString]]];
    
    return cell;
}

#pragma mark SettingsClientDelegate

- (void)settingsUploaded
{
    [self updateUserInterface];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLanguageSettings"])
    {
        SettingsLanguageViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.settingsClient = self.settingsClient;
    }
}


@end
