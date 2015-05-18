//
//  SettingsLanguageViewController.m
//  Lamigo
//
//  Created by Felix Belau on 17.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "SettingsLanguageViewController.h"
#import "User.h"
#import "ContentProvider.h"
#import "SettingsInterestsTableViewCell.h"
#import "SettingsClient.h"
#import "RegistrationStepTableViewCell.h"

@interface SettingsLanguageViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *languageTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic) NSInteger nativeLanguageIndex;
@property (nonatomic) NSInteger learningLanguageIndex;
@property (nonatomic) NSInteger universalLanguageIndex;

@end

@implementation SettingsLanguageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.languageTableView.dataSource = self;
    self.languageTableView.delegate = self;
    User *currentUser = [User currentUser];
    self.nativeLanguageIndex = [currentUser.nativeLanguage integerValue];
    self.learningLanguageIndex = [currentUser.learningLanguage integerValue];
    self.universalLanguageIndex = [currentUser.universalLanguage integerValue];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.settingsClient updateNativeLanguage:@(self.nativeLanguageIndex) learningLanguage:@(self.learningLanguageIndex) universalLanguage:@(self.universalLanguageIndex)];
}

- (IBAction)segmentedControlValueChanged:(id)sender
{
    [self.languageTableView reloadData];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ContentProvider languages].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RegistrationStepTableViewCell";
    RegistrationStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ((RegistrationStepTableViewCell *)cell).titleLabel.text = [ContentProvider languageNameForID:[ContentProvider languages][indexPath.row]];

    if (self.segmentedControl.selectedSegmentIndex == 0 && self.nativeLanguageIndex-1 == indexPath.row)
    {
        cell.selected = YES;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1 && self.learningLanguageIndex-1 == indexPath.row)
    {
        cell.selected = YES;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2 && self.universalLanguageIndex-1 == indexPath.row)
    {
        cell.selected = YES;
    }
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger oldRow;
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        oldRow = self.nativeLanguageIndex-1;
        self.nativeLanguageIndex = indexPath.row+1;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1)
    {
        oldRow = self.learningLanguageIndex-1;
        self.learningLanguageIndex = indexPath.row+1;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2)
    {
        oldRow = self.universalLanguageIndex-1;
        self.universalLanguageIndex = indexPath.row+1;
    }
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:oldRow inSection:0]];
    [oldCell setSelected:NO];
    
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
