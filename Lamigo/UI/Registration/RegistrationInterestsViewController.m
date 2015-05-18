//
//  RegistrationInterestsViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "RegistrationInterestsViewController.h"

@interface RegistrationInterestsViewController ()

@end

@implementation RegistrationInterestsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedInterests = [[NSMutableArray alloc] init];
    self.descriptionText = @"set your topic you want to talk about";
}


- (void)setupTableViewModel
{
    self.tableViewModel = @[@"Sport",@"Musik",@"Beruf",@"Reisen",@"Kultur",@"Sex", @"Essen",@"Sprachen",@"Kinder",@"Familie",@"Unterhaltung",@"Technologien"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *selectedValue = @(indexPath.row+1);
    if(![self.selectedInterests containsObject:selectedValue])
    {
        [self.selectedInterests addObject:selectedValue];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *selectedValue = @(indexPath.row+1);
    if([self.selectedInterests containsObject:selectedValue])
    {
        [self.selectedInterests removeObject:selectedValue];
    }
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
