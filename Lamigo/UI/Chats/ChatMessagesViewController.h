//
//  ChatMessagesViewController.h
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "JSQMessagesViewController.h"
#import "DemoModelData.h"
#import "User.h"

@interface ChatMessagesViewController : JSQMessagesViewController

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) User *chatUser;

@end
