//
//  KKLanguageManager.m
//  KKLanguage
//
//  Created by sunkai on 2016/11/9.
//  Copyright © 2016年 Kook. All rights reserved.
//

#import "KKLanguageManager.h"
#import "NSBundle+Language.h"

static NSDictionary *kLanguageDic = nil;

static NSString *const kLanguageInAppKey = @"kLanguageInAppKey";
NSString *const KKLanguageDidChangeNotification = @"KKLanguageDidChangeNotification";

static NSString *kUnknownLanguage = @"unknown";

static NSString *kEnglishShorthand = @"en";
static NSString *kChineseShorthand = @"zh-Hans";

static NSString *kEnglishDesc = @"English";
static NSString *kChineseDesc = @"简体中文";

@implementation KKLanguageManager

+ (void)setUpPreferredLanguage {
    NSString *languageInApp = [[NSUserDefaults standardUserDefaults] objectForKey:kLanguageInAppKey];
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    if (!languageInApp) {
        NSString *prefferdLanguage = [self _verifyLanguage:languages.firstObject];
        languageInApp = prefferdLanguage;
        [self _savePreferredLanguage:languageInApp];
    }
    
    [NSBundle setLanguage:languageInApp];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kLanguageDic = @{@(KKLanguageUnknown): kUnknownLanguage,
                         @(KKLanguageEnglish): kEnglishShorthand,
                         @(KKLanguageChinese): kChineseShorthand};
    });
}

+ (KKLanguage)currentLanguage {
    NSString *lanShorthand = [self _preferredLanguage:kLanguageInAppKey];
    return [self languageTypeWithShorthand:lanShorthand];
}

+ (NSArray<NSString *>*)supportLanguageDescriptions {
    return @[kChineseDesc, kEnglishDesc];
}

+ (void)saveLanguage:(KKLanguage)language completion:(void (^)(void))completion {
    if (language == KKLanguageUnknown || language >= KKLanguageMax) {
        return;
    }
    if (language == [KKLanguageManager currentLanguage]) {
        return;
    }
    NSString *lanShorthand = kLanguageDic[@(language)];
    if (lanShorthand) {
        [self _savePreferredLanguage:lanShorthand];
        [NSBundle setLanguage:lanShorthand];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KKLanguageDidChangeNotification object:@(language)];
        });
        if (completion) {
            completion();
        }
    }
}

+ (KKLanguage)languageTypeWithDescription:(NSString *)languageDes {
    if (!languageDes) {
        return KKLanguageUnknown;
    }
    if ([languageDes isEqualToString:kChineseDesc]) {
        return KKLanguageChinese;
    } else if ([languageDes isEqualToString:kEnglishDesc]) {
        return KKLanguageEnglish;
    }
    return KKLanguageUnknown;
}

+ (KKLanguage)languageTypeWithShorthand:(NSString *)languageShorthand {
    if (!languageShorthand) {
        return KKLanguageUnknown;
    }
    if ([languageShorthand isEqualToString:kChineseShorthand]) {
        return KKLanguageChinese;
    } else if ([languageShorthand isEqualToString:kEnglishShorthand]) {
        return KKLanguageEnglish;
    }
    return KKLanguageUnknown;
}

+ (NSString *)languageShorthand:(KKLanguage)language {
    switch (language) {
        case KKLanguageEnglish:
            return kEnglishShorthand;
        case KKLanguageChinese:
            return kChineseShorthand;
        default:
            return kUnknownLanguage;
    }
}

+ (NSString *)languageDescription:(KKLanguage)language {
    switch (language) {
        case KKLanguageEnglish:
            return kEnglishDesc;
        case KKLanguageChinese:
            return kChineseDesc;
        default:
            return kUnknownLanguage;
    }
}

+ (NSString *)currentLanguageShorthand {
    KKLanguage language = [KKLanguageManager currentLanguage];
    return [self languageShorthand:language];
}
#pragma mark - Private Methods

+ (void)_savePreferredLanguage:(NSString *)prefferdLanguage {
    if (!prefferdLanguage) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:prefferdLanguage forKey:kLanguageInAppKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)_preferredLanguage:(NSString *)key {
    if (!key) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (NSString *)_verifyLanguage:(NSString *)languageStr {
    if (!languageStr || languageStr.length == 0) {
        return kEnglishShorthand;
    }
    if ([languageStr hasPrefix:@"zh"]) {
        return kChineseShorthand;
    }
    return kEnglishShorthand;
}

@end

