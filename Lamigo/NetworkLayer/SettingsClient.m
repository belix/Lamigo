//
//  SettingsClient.m
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "SettingsClient.h"
#import "AFNetworking.h"
#import "User.h"

static NSString * const BaseURLString = @"http://localhost:8888/";

@implementation SettingsClient

- (void)updateNativeLanguage:(NSNumber *)nativeLanguage learningLanguage:(NSNumber *)learningLanguage universalLanguage:(NSNumber *)universalLanguage
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    User *currentUser = [User currentUser];
    NSDictionary *params = @{
                             @"id" : currentUser.ID,
                             @"nativeLanguage" : nativeLanguage,
                             @"learningLanguage" : learningLanguage,
                             @"universalLanguage" : universalLanguage};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"updateUserSettings" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"response %@",responseObject);
        currentUser.nativeLanguage = nativeLanguage;
        currentUser.learningLanguage = learningLanguage;
        currentUser.universalLanguage = universalLanguage;
        
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:currentUser];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:@"currentUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.delegate settingsUploaded];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error %@",error);
    }];
}


@end
