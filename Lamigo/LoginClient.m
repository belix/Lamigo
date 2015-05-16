//
//  LoginClient.m
//  Halleluja
//
//  Created by Felix Belau on 07.03.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "LoginClient.h"
#import "AFNetworking.h"
#import "User.h"

static NSString * const BaseURLString = @"http://localhost:8888/";


@implementation LoginClient

#pragma mark - Internal

#pragma mark - Public

- (void)signUpWithForUser:(User *)user
{
    NSString *encodedString = [user.profilePicture base64EncodedStringWithOptions:0];
    
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    NSDictionary *params = @{@"name": user.username,
                             @"password": @"",
                             @"email": user.facebookID,
                             @"profilePicture" : encodedString,
                             @"facebookID" : user.facebookID,
                             @"nativeLanguage" : user.nativeLanguage,
                             @"learningLanguage" : user.learningLanguage,
                             @"universalLanguage" : user.universalLanguage};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [manager POST:@"createUser" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"response %@",responseObject);
        user.ID = responseObject[@"id"];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:@"currentUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.delegate signUpSuccessful];
        
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

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password
{
    
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    NSDictionary *params = @{@"username": username,
                             @"password": password
                             };
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"loginUser.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                
        User *user = [[User alloc] init];
        user.username = responseObject[@"username"];
        user.email = responseObject[@"email"];
        user.birthday = responseObject[@"birthday"];
        user.gender = [responseObject[@"gender"] integerValue];
        user.ID = responseObject[@"ID"];
        
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:@"currentUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.delegate loginSuccessful];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.delegate loginFailedWithError:[error localizedDescription]];
    }];
}

- (void)loginWithFacebook
{

}

- (void)logout
{
    [User logOut];
    [self.delegate logoutSuccessful];
}

#pragma mark - Getter

- (BOOL)userIsLoggedIn
{
    return [User currentUser];
}


@end
