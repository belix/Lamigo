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

static NSString * const BaseURLString = @"http://localhost:8888/allPossibleUser";

@implementation MatchingClient

- (void)fetchAllPossibleUser
{
    NSURL *url = [NSURL URLWithString:BaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSArray *response) {
        
        NSLog(@"response %@",response);
        [self.delegate possibleUserLoaded:response];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error %@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Lotteries loading failed"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];

}

@end
