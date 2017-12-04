//
//  main.m
//  KKLanguage
//
//  Created by sunkai on 2016/11/8.
//  Copyright © 2016年 Kook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KKLanguageManager.h"


int main(int argc, char * argv[]) {
    @autoreleasepool {
        [KKLanguageManager setUpPreferredLanguage];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
