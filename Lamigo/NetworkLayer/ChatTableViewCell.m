//
//  ChatTableViewCell.m
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "ChatTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ChatTableViewCell

- (void)awakeFromNib
{
    self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.size.width/2;
    self.profilePictureImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
