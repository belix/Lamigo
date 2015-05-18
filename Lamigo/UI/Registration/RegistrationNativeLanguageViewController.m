//
//  RegistrationNativeLanguageViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "RegistrationNativeLanguageViewController.h"
#import "ContentProvider.h"

@interface RegistrationNativeLanguageViewController ()

@end

@implementation RegistrationNativeLanguageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.descriptionText = @"set native language";
}

- (void)setupTableViewModel
{
    self.tableViewModel = [ContentProvider languages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedNativeLanguage = self.tableViewModel[indexPath.row];
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
