//
//  ViewController.m
//  KKLanguage
//
//  Created by sunkai on 2016/11/8.
//  Copyright © 2016年 Kook. All rights reserved.
//

#import "ViewController.h"
#import "NSBundle+Language.h"
#import "KKLanguageManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *languages;
}

@property (weak, nonatomic) IBOutlet UIButton *languageBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    languages = [KKLanguageManager supportLanguageDescriptions];
    _label1.text = NSLocalizedString(@"ThisALabel", @"");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeLanguage:(id)sender {
    [NSBundle setLanguage:@"zh-Hans"];
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [s instantiateInitialViewController];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = languages[indexPath.row];
    if (indexPath.row == [KKLanguageManager currentLanguage] - 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KKLanguage language = [KKLanguageManager languageTypeWithDescription:languages[indexPath.row]];
    [KKLanguageManager saveLanguage:language completion:^{
        [self.tableView reloadData];
        UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [s instantiateInitialViewController];
    }];
}

@end
