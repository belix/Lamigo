//
//  FriendsClient.h
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendsClientDelegate.h"

@interface FriendsClient : NSObject

@property (weak, nonatomic) id <FriendsClientDelegate> delegate;

- (void)loadFriends;

@end
