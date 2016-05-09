//
//  JCFollowViewController.m
//  JianShu
//
//  Created by molin on 16/2/25.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCFollowViewController.h"

#import "JCOptionNavigationBar.h"
#import "UIViewController+Replace.h"
#import "JCOptionItemView.h"

@interface JCFollowViewController ()<JCOptionNavigationBarDelegate,JCOptionItemViewDelegate>

@property (nonatomic, strong) JCOptionNavigationBar *optionNavigationBar;

@end

@implementation JCFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self replaceNavigationBar:self.optionNavigationBar];
    self.optionNavigationBar.optionTitle = @"全部关注";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JCOptionNavigationBarDelegate

- (void)selectedAction {
    NSArray *items = @[
  @{kOptionItemViewTitle:@"全部关注",kOptionItemViewImage:@""},
  @{kOptionItemViewTitle:@"只看专题",kOptionItemViewImage:@""},
  @{kOptionItemViewTitle:@"只看文集",kOptionItemViewImage:@""},
  @{kOptionItemViewTitle:@"只看用户",kOptionItemViewImage:@""},
  @{kOptionItemViewTitle:@"只看推送更新",kOptionItemViewImage:@""}];
    
    JCOptionItemView *optionItemView = [[JCOptionItemView alloc]initWithPoint:CGPointMake(self.view.centerX, 60) items:items];
    optionItemView.optionItemViewDeleagate = self;
    optionItemView.optionItemBackgroundColor = [UIColor blackColor];
    optionItemView.optionItemTitleColor = [UIColor whiteColor];
    [optionItemView show];
}

#pragma mark - JCOptionItemViewDelegate

- (void)optionItemView:(JCOptionItemView *)optionItemView item:(NSInteger)item {
    JCLog(@"sss");
}

- (JCOptionNavigationBar *)optionNavigationBar {
    if (!_optionNavigationBar) {
        _optionNavigationBar = [[JCOptionNavigationBar alloc]init];
        _optionNavigationBar.optionDelegate = self;
    }
    return _optionNavigationBar;
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
