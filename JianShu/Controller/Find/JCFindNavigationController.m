//
//  JCFindNavigationController.m
//  JianShu
//
//  Created by molin on 16/2/26.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCFindNavigationController.h"
#import "UIViewController+Replace.h"
#import "JCNavigationBar.h"

@interface JCFindNavigationController ()<JCNavigationBarDelegate>

@property (nonatomic, strong) JCNavigationBar  *findNavigationBar;       // NavigationBar

@property (nonatomic, strong) JCFindViewController *findRootViewController;  // 跟视图

@end

@implementation JCFindNavigationController

- (instancetype)initWithFindRootViewController:(JCFindViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.findRootViewController = rootViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self replaceNavigationBar:self.findNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - JCNavigationBarDelegate代理

- (void)switchView:(BOOL)sview {
    [UIView animateWithDuration:0.2 animations:^{
        if (sview) {
            self.findRootViewController.firstView.x = 0;
            self.findRootViewController.secondView.x = self.view.width;
        }else {
            self.findRootViewController.firstView.x = -self.view.width;
            self.findRootViewController.secondView.x = 0;
        }
    }];
}

- (JCNavigationBar *)findNavigationBar {
    if (!_findNavigationBar) {
        _findNavigationBar = [[JCNavigationBar alloc] init];
        _findNavigationBar.navigationBarDelegate = self;
    }
    return _findNavigationBar;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
