//
//  SettingsViewController.m
//  Lamigo
//
//  Created by Felix Belau on 16.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsInterestsTableViewCell.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *interestsTableView;
@property (nonatomic, strong) NSArray *interests;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interests = @[@"Gaming",@"Sports",@"Music",@"Gaming",@"Sports",@"Music"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableViewHeightConstraint.constant = self.interestsTableView.contentSize.height;
    [self.view layoutIfNeeded];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.interests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingsInterestsTableViewCell";
    SettingsInterestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.titleLabel.text = self.interests[indexPath.row];
    cell.interestsImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"interests-%@-icon-black",[self.interests[indexPath.row] lowercaseString]]];
    
    return cell;
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
