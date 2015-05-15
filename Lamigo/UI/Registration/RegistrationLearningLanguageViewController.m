//
//  RegistrationLearningLanguageViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "RegistrationLearningLanguageViewController.h"

@interface RegistrationLearningLanguageViewController ()

@end

@implementation RegistrationLearningLanguageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.descriptionText = @"set learning language";
}

- (void)setupTableViewModel
{
    self.tableViewModel = @[@"Deutsch",@"Englisch",@"Französisch",@"Spanisch",@"Japanisch",@"Italienisch", @"Chinesisch",@"Portugiesisch"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedLearningLanguage = self.tableViewModel[indexPath.row];
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
