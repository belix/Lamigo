//
//  ChatClient.m
//  Lamigo
//
//  Created by Felix Belau on 22.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "ChatClient.h"
#import "AFNetworking.h"
#import "User.h"

static NSString * const BaseURLString =@"http://localhost:8888/";

@implementation ChatClient

- (void)getChatHistoryForFriendshipID:(NSNumber *)friendshipID completion:(void (^)(BOOL success, NSArray * chatHistory))completion
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    NSDictionary *params = @{
                             @"friends_id" : @5};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"getChatHistory" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completion(YES, responseObject);
        NSLog(@"chat response %@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error %@",error);
    }];
}

- (void)sentMessage:(NSString *)message friendshipID:(NSNumber *)friendshipID completion:(void (^)(BOOL success))completion
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    NSDictionary *params = @{
                             @"user_creator_id" : [User currentUser].ID,
                             @"friends_id" : @5,
                             @"message" : message
                             };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"createNewMessage" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completion(YES);
        NSLog(@"message response %@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error %@",error);
    }];
}

@end
