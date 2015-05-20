//
//  MatchingProfileImageView.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "MatchingProfileImageView.h"
#import "CAAnimation+CompletionBlock.h"
#import <QuartzCore/QuartzCore.h>

@implementation MatchingProfileImageView

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setupProfilePictureLayout
{
    self.frontPicture.layer.cornerRadius = self.frontPicture.frame.size.width/2;
    self.frontPicture.clipsToBounds = YES;
    self.backPicture.layer.cornerRadius = self.backPicture.frame.size.width/2;
    self.backPicture.clipsToBounds = YES;
}

#pragma mark - Public

- (void)userDeclined
{
    self.frontFeedback.image = [UIImage imageNamed:@"circle-red"];
    [self animateFeedbackView];
}

- (void)userAccepted
{
    self.frontFeedback.image = [UIImage imageNamed:@"circle-blue"];
    [self animateFeedbackView];
}

#pragma mark - Internal

- (void)animateFeedbackView
{
    self.frontFeedback.alpha = 0;
    self.frontFeedback.hidden = NO;
    //move new container to center of the screen
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frontFeedback.alpha = .5f;
                     }
                     completion:^(BOOL finished){
                         [self flip];
                     }];
}

- (void)resetCard
{
    self.frontFeedback.hidden = YES;
    self.backFeedback.hidden = YES;
    [self.front.layer removeAllAnimations];
    [self.back.layer removeAllAnimations];
}

- (void)flip
{
    [self resetCard];
    
    CFTimeInterval duration = 0.3;
    CGFloat xScale = 1;
    CGFloat yScale = 1;
    
    CATransform3D frontRotation = CATransform3DMakeRotation(M_PI / 2.0, 0, 1, 0);
    frontRotation = CATransform3DScale(frontRotation, xScale, yScale, 1);
    frontRotation.m34 = - 1.0 / 200.0;
    
    CATransform3D backRotation = CATransform3DMakeRotation(- M_PI / 2.0, 0, 1, 0);
    backRotation = CATransform3DScale(backRotation, 1.0 / xScale, 1.0 / yScale, 1);
    backRotation.m34 = - 1.0 / 200.0;
    
    CABasicAnimation *frontAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [frontAnimation setDuration:duration / 2.0];
    [frontAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [frontAnimation setToValue:[NSValue valueWithCATransform3D:frontRotation]];
    frontAnimation.fillMode = kCAFillModeForwards;
    frontAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *backAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    backAnimation.duration = duration / 2.0;
    backAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    backAnimation.fromValue = [NSValue valueWithCATransform3D:backRotation];
    backAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    backAnimation.fillMode = kCAFillModeForwards;
    backAnimation.removedOnCompletion = NO;
    
    [backAnimation setCompletion:^(BOOL finished) {
        [self.delegate cardFlippingFinished];
        [self resetCard];
    }];
    
    [frontAnimation setCompletion:^(BOOL finished) {
        self.front.hidden = YES;
        self.back.hidden = NO;
        [self.back.layer addAnimation:backAnimation forKey:nil];
    }];
    
    [self.front.layer addAnimation:frontAnimation forKey:nil];
}

@end
