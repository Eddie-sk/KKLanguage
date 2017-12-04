//
//  KKLanguageManager.h
//  KKLanguage
//
//  Created by sunkai on 2016/11/9.
//  Copyright © 2016年 Kook. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const KKLanguageDidChangeNotification;

typedef NS_ENUM(NSUInteger, KKLanguage) {
    KKLanguageUnknown = 0,
    KKLanguageChinese,
    KKLanguageEnglish,
    
    // Add other language enum here
    
    KKLanguageMax,
};

@interface KKLanguageManager : NSObject

+ (void)setUpPreferredLanguage;

+ (void)saveLanguage:(KKLanguage)language completion:(void(^)(void))completion;

// @[@"English", @"简体中文"]
+ (NSArray<NSString *>*)supportLanguageDescriptions;

+ (KKLanguage)currentLanguage;

+ (KKLanguage)languageTypeWithDescription:(NSString *)languageDes;

+ (KKLanguage)languageTypeWithShorthand:(NSString *)languageShorthand;

// "en" "zh-Hans-CN"
+ (NSString *)languageShorthand:(KKLanguage)language;

// "English" "简体中文"
+ (NSString *)languageDescription:(KKLanguage)language;

+ (NSString *)currentLanguageShorthand;

@end

