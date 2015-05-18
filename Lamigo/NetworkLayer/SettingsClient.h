//
//  SettingsClient.h
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsClientDelegate.h"

@interface SettingsClient : NSObject

@property (weak, nonatomic) id <SettingsClientDelegate> delegate;

- (void)updateNativeLanguage:(NSNumber *)nativeLanguage learningLanguage:(NSNumber *)learningLanguage universalLanguage:(NSNumber *)universalLanguage;

@end
