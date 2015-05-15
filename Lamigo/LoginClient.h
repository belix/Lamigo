//
//  LoginClient.h
//  Halleluja
//
//  Created by Felix Belau on 07.03.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoginClientDelegate.h"
#import "User.h"

@interface LoginClient : NSObject

- (void)signUpWithForUser:(User *)user;
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
- (void)loginWithFacebook;
- (void)logout;

@property (nonatomic) BOOL userIsLoggedIn;
@property (nonatomic, weak) id <LoginClientDelegate> delegate;

@end
