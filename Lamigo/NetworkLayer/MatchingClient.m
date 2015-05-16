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

static NSString * const BaseURLString = @"http://localhost:8888/";

@implementation MatchingClient

- (void)fetchAllPossibleUser
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    User *currentUser = [User currentUser];
    NSDictionary *params = @{
                             @"nativeLanguage" : currentUser.nativeLanguage,
                             @"learningLanguage" : currentUser.learningLanguage,
                             @"universalLanguage" : currentUser.universalLanguage
                             };
    
    [manager POST:@"allPossibleUser" parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
    {
        
        NSLog(@"response %@",responseObject);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        NSLog(@"error %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Signing up"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

@end
