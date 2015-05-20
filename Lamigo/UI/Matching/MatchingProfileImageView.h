//
//  MatchingProfileImageView.h
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlippingCardDelegate.h"

@interface MatchingProfileImageView : UIView

@property (nonatomic, weak) IBOutlet UIView *front;
@property (nonatomic, weak) IBOutlet UIView *back;

@property (nonatomic, weak) IBOutlet UIImageView *frontPicture;
@property (nonatomic, weak) IBOutlet UIImageView *backPicture;

@property (nonatomic, weak) IBOutlet UIImageView *frontFeedback;
@property (nonatomic, weak) IBOutlet UIImageView *backFeedback;

@property (nonatomic, weak) id <FlippingCardDelegate> delegate;

- (void)userDeclined;
- (void)userAccepted;
- (void)setupProfilePictureLayout;

@end
