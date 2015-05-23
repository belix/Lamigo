//
//  ChatClient.h
//  Lamigo
//
//  Created by Felix Belau on 22.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatClient : NSObject

- (void)getChatHistoryForFriendshipID:(NSNumber *)friendshipID completion:(void (^)(BOOL success, NSArray * chatHistory))completion;

- (void)sentMessage:(NSString *)message friendshipID:(NSNumber *)friendshipID completion:(void (^)(BOOL success))completion;

@end
