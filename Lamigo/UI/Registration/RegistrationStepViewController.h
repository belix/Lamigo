//
//  RegistrationStepViewController.h
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationStepViewController : UIViewController

- (void)setupTableViewModel;

@property (nonatomic, strong) NSString *descriptionText;
@property (strong,nonatomic) NSArray *tableViewModel;

@end
