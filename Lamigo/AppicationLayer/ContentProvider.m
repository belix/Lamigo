//
//  ContentProvider.m
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "ContentProvider.h"

@implementation ContentProvider

+ (NSString *)interestNameForID:(NSNumber *)interestID
{
    NSString *interestName;
    switch ([interestID integerValue]) {
        case 1:
            interestName = @"Sport";
            break;
        case 2:
            interestName = @"Musik";
            break;
        case 3:
            interestName = @"Beruf";
            break;
        case 4:
            interestName = @"Reisen";
            break;
        case 5:
            interestName = @"Kultur";
            break;
        case 6:
            interestName = @"Sex";
            break;
        case 7:
            interestName = @"Essen";
            break;
        case 8:
            interestName = @"Sprachen";
            break;
        case 9:
            interestName = @"Kinder";
            break;
        case 10:
            interestName = @"Familie";
            break;
        case 11:
            interestName = @"Unterhaltung";
            break;
        case 12:
            interestName = @"Technologien";
            break;
        default:
            break;
    }
    return interestName;
}

+ (NSArray *)languages
{
    return @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
}

+ (NSString *)languageNameForID:(NSNumber *)langauageID
{
    NSString *languageName;
    switch ([langauageID integerValue]) {
        case 1:
            languageName = @"Deutsch";
            break;
        case 2:
            languageName = @"Englisch";
            break;
        case 3:
            languageName = @"Französisch";
            break;
        case 4:
            languageName = @"Spanisch";
            break;
        case 5:
            languageName = @"Italienisch";
            break;
        case 6:
            languageName = @"Portugiesisch";
            break;
        case 7:
            languageName = @"Russisch";
            break;
        case 8:
            languageName = @"Chinesisch";
            break;
        case 9:
            languageName = @"Japanisch";
            break;
        case 10:
            languageName = @"Türkisch";
            break;
        default:
            break;
    }
    return languageName;
}


@end
