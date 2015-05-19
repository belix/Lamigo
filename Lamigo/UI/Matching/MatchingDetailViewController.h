//
//  MatchingDetailViewController.h
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "MatchingDetailDelegate.h"

@interface MatchingDetailViewController : UIViewController

@property (nonatomic) NSInteger userIndex;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, weak) id <MatchingDetailDelegate> delegate;

- (void)userDeclined;
- (void)userAccepted;

@end
