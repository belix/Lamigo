//
//  MatchingClient.h
//  Lamigo
//
//  Created by Felix Belau on 13.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchingClientDelegate.h"
#import "User.h"

@interface MatchingClient : NSObject

- (void)fetchAllPossibleUser;
- (void)acceptUser:(User *)user completion:(void (^)(BOOL success, User *user))completion;
- (void)declineUser:(User *)user;

@property (nonatomic, weak) id <MatchingClientDelegate> delegate;

@end
