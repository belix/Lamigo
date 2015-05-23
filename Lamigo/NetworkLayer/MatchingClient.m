//
//  MatchingClient.m
//  Lamigo
//
//  Created by Felix Belau on 13.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "MatchingClient.h"
#import "AFNetworking.h"
#import "User.h"

static NSString * const BaseURLString =@"http://vidiviciserver-dev.elasticbeanstalk.com/";

@implementation MatchingClient

- (void)fetchAllPossibleUser
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    User *currentUser = [User currentUser];
    NSDictionary *params = @{
                             @"user_id" : currentUser.ID,
                             @"nativeLanguage" : currentUser.nativeLanguage,
                             @"learningLanguage" : currentUser.learningLanguage,
                             @"universalLanguage" : currentUser.universalLanguage
                             };
    
    [manager POST:@"allPossibleUser" parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSMutableArray *users = [[NSMutableArray alloc] init];
        for(NSDictionary *userDict in responseObject)
        {
            User *user = [[User alloc] init];
            user.ID = userDict[@"id"];
            user.username = userDict[@"name"];
            user.learningLanguage = userDict[@"learningLanguage"];
            user.nativeLanguage = userDict[@"nativeLanguage"];
            user.universalLanguage = userDict[@"universalLanguage"];
            if(userDict[@"profilePicture"] != nil && ![userDict[@"profilePicture"] isKindOfClass: [NSNull class]])
            {
                user.profilePicture = [[NSData alloc] initWithBase64EncodedString:userDict[@"profilePicture"] options:0];
            }
            else
            {
                user.profilePicture = UIImagePNGRepresentation([UIImage imageNamed:@"avatar-male"]);
            }
            [users addObject:user];
        }
        
        [self.delegate possibleUserLoaded:users];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error %@",error);
    }];
}

- (void)declineUser:(User *)user
{
    return;
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    User *currentUser = [User currentUser];
    NSDictionary *params = @{
                             @"user_id" : currentUser.ID,
                             @"friend_id" : user.ID,
                             };
    
    [manager POST:@"declineUser" parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
         NSLog(@"error %@",error);
     }];
}

- (void)acceptUser:(User *)user completion:(void (^)(BOOL success, User *))completion
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    User *currentUser = [User currentUser];
    NSDictionary *params = @{
                             @"user_id" : currentUser.ID,
                             @"friend_id" : user.ID,
                             };
    
    [manager POST:@"acceptUser" parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"response %@",responseObject[@"response"]);
         if ([responseObject[@"response"] isEqualToString:@"match"])
         {
             completion(YES, user);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
         NSLog(@"error %@",error);
     }];
}

@end
