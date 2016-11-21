//
//  KKLanguageManager.m
//  KKLanguage
//
//  Created by sunkai on 2016/11/9.
//  Copyright © 2016年 Kook. All rights reserved.
//

#import "KKLanguageManager.h"
#import "NSBundle+Language.h"

static NSString *const KKLanguageKey = @"KKLanguageKey";
static NSString *const KKLanguageCode[] = {@"en", @"zh-Hans"};
static NSString *const KKLanguageStrings[] = {@"English", @"简体中文"};

#define KKCurrentLanguageCode [[NSUserDefaults standardUserDefaults] objectForKey:@"KKLanguageKey"];
#define KKSaveLanguageCode(languageCode) [[NSUserDefaults standardUserDefaults] setValue:languageCode forKey:@"KKLanguageKey"]; \
        [[NSUserDefaults standardUserDefaults] synchronize];


@implementation KKLanguageManager

+ (void)setupLanguage {
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:KKLanguageKey];
    
    if (!currentLanguage) {
        NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        if (languages.count > 0) {
            currentLanguage = languages[0];
            KKSaveLanguageCode(currentLanguage)
        }
    }
    
    [NSBundle setLanguage:currentLanguage];
}

+ (NSArray *)languages {
    NSMutableArray *languages = [NSMutableArray array];
    
    for (int i = 0 ; i < KKLanguageCount; i++) {
        NSString *language = NSLocalizedString(KKLanguageStrings[i], @"");
        [languages addObject:language];
    }
    return [languages copy];
}

+ (void)saveLanguageOfStringIndex:(NSInteger)index {
    if (index >= 0 && index < KKLanguageCount) {
        NSString *languageCode = KKLanguageCode[index];
        KKSaveLanguageCode(languageCode)
        [NSBundle setLanguage:languageCode];
    }
}

+ (NSInteger)currentLanguageIndex {
    NSInteger index = 0;
    NSString *currentLanguageCode = KKCurrentLanguageCode;
    for (int i = 0; i < KKLanguageCount; i++) {
        NSString *languageCode = KKLanguageCode[i];
        if ([currentLanguageCode isEqualToString:languageCode]) {
            index = i;
            break;
        }
    }
    return index;
}

@end
