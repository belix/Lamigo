//
//  User.h
//  Halleluja
//
//  Created by Felix Belau on 02.04.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *facebookID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic) NSInteger gender;
@property (nonatomic, strong) NSData *profilePicture;
@property (nonatomic, strong) NSNumber *nativeLanguage;
@property (nonatomic, strong) NSNumber *learningLanguage;
@property (nonatomic, strong) NSNumber *universalLanguage;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSMutableArray *interests;

+ (void)logOut;
+ (User *)currentUser;

@end
