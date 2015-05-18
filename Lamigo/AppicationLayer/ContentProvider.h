//
//  ContentProvider.h
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentProvider : NSObject

+ (NSString *)interestNameForID:(NSNumber *)interestID;
+ (NSArray *)languages;
+ (NSString *)languageNameForID:(NSNumber *)langauageID;

@end
