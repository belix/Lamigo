//
//  User.m
//  Halleluja
//
//  Created by Felix Belau on 02.04.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "User.h"

#define k_username @"username"
#define k_email @"email"
#define k_gender @"gender"
#define k_birthday @"birthday"
#define k_ID @"ID"
#define k_profilePicture @"profilePicture"
#define k_nativeLanguage @"nativeLanguage"
#define k_learningLanguage @"learningLanguage"
#define k_universalLanguage @"universalLanguage"
#define k_interests @"interests"

@implementation User

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.ID = [aDecoder decodeObjectForKey:k_ID];
        self.username = [aDecoder decodeObjectForKey:k_username];
        self.birthday = [aDecoder decodeObjectForKey:k_birthday];
        self.gender = [aDecoder decodeIntegerForKey:k_gender];
        self.email = [aDecoder decodeObjectForKey:k_email];
        self.profilePicture = [aDecoder decodeObjectForKey:k_profilePicture];
        self.nativeLanguage = [aDecoder decodeObjectForKey:k_nativeLanguage];
        self.learningLanguage = [aDecoder decodeObjectForKey:k_learningLanguage];
        self.universalLanguage = [aDecoder decodeObjectForKey:k_universalLanguage];
        self.interests = [aDecoder decodeObjectForKey:k_interests];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ID forKey:k_ID];
    [aCoder encodeObject:self.username forKey:k_username];
    [aCoder encodeObject:self.birthday forKey:k_birthday];
    [aCoder encodeObject:self.email forKey:k_email];
    [aCoder encodeInteger:self.gender forKey:k_gender];
    [aCoder encodeObject:self.profilePicture forKey:k_profilePicture];
    [aCoder encodeObject:self.nativeLanguage forKey:k_nativeLanguage];
    [aCoder encodeObject:self.learningLanguage forKey:k_learningLanguage];
    [aCoder encodeObject:self.universalLanguage forKey:k_universalLanguage];
    [aCoder encodeObject:self.interests forKey:k_interests];
}

+ (User *)currentUser
{
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
}

+ (void)logOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentUser"];
}

@end
