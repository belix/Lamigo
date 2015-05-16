//
//  MatchingProfileImageView.h
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchingProfileImageView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *front;
@property (nonatomic, weak) IBOutlet UIImageView *back;

- (void)flip;

@end
