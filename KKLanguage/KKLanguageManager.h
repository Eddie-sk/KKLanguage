//
//  KKLanguageManager.h
//  KKLanguage
//
//  Created by sunkai on 2016/11/9.
//  Copyright © 2016年 Kook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KKLanguage) {
    KKLanguageEnglish,
    KKLanguageChinese,
    
    KKLanguageCount
};

@interface KKLanguageManager : NSObject

+ (void)setupLanguage;

/**
 支持的多语言列表
 
 @return 多语言列表
 */
+ (NSArray *)languages;


/**
 选择某语言，设置并保存语言对应的code（语言环境）。 PS：languageString的index等价于languageCode的index

 @param index 语言列表（LanguageString）对应的index
 */
+ (void)saveLanguageOfStringIndex:(NSInteger)index;


/**
 用语标记当前语言环境对应的index

 @return index
 */
+ (NSInteger)currentLanguageIndex;

@end
