//
//  RegistrationStepViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "RegistrationStepViewController.h"
#import "RegistrationStepTableViewCell.h"

@interface RegistrationStepViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RegistrationStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableViewModel];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupTableViewModel
{
    
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RegistrationStepTableViewCell";
    RegistrationStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.titleLabel.text = self.tableViewModel[indexPath.row];
    
    return cell;
}


#pragma mark - TableView Delegate


#pragma mark - IBActions

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
