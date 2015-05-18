//
//  FriendsClient.m
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "FriendsClient.h"
#import "AFNetworking.h"
#import "User.h"

static NSString * const BaseURLString = @"http://localhost:8888/";


@implementation FriendsClient

- (void)loadFriends
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    User *currentUser = [User currentUser];
    NSDictionary *params = @{
                             @"id" : currentUser.ID};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"getAllMatches" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"response %@",responseObject);
        NSMutableArray *users = [[NSMutableArray alloc] init];
        for(NSDictionary *userDict in responseObject)
        {
            User *user = [[User alloc] init];
            user.ID = userDict[@"id"];
            user.username = userDict[@"name"];
            user.learningLanguage = userDict[@"learningLanguage"];
            user.nativeLanguage = userDict[@"nativeLanguage"];
            user.universalLanguage = userDict[@"universalLanguage"];
            user.profilePicture = [[NSData alloc] initWithBase64EncodedString:userDict[@"profilePicture"] options:0];
            [users addObject:user];
        }
        
        [self.delegate friendsLoaded:users];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error %@",error);
    }];
}

@end
