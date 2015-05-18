//
//  RegistrationStepTableViewCell.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "RegistrationStepTableViewCell.h"

@implementation RegistrationStepTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.checkBoxImageView.image = selected ? [UIImage imageNamed:@"checkbox-ticked"] : [UIImage imageNamed:@"checkbox-unticked"];
}



@end
