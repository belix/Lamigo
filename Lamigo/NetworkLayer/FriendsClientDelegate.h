//
//  FriendsClientDelegate.h
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FriendsClientDelegate <NSObject>

- (void)friendsLoaded:(NSArray *)friends;

@end
