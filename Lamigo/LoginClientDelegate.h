//
//  LoginClientDelegate.h
//  Halleluja
//
//  Created by Felix Belau on 07.03.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginClientDelegate <NSObject>

@optional
- (void)signUpSuccessful;
- (void)loginSuccessful;
- (void)facebookUserNotAvailable;
- (void)loginFailedWithError:(NSString *)error;
- (void)logoutSuccessful;

@end
