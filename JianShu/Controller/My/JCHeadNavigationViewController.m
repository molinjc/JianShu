//
//  JCHeadNavigationViewController.m
//  JianShu
//
//  Created by molin on 16/3/2.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCHeadNavigationViewController.h"

#import "JCHeadNavigationBar.h"
#import "UIViewController+Replace.h"

@interface JCHeadNavigationViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) JCHeadNavigationBar *headNavigationBar;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JCHeadNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.scrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64);
    [self.scrollView setContentSize:CGSizeMake(self.view.width, self.view.height*1.2)];
    
    [self replaceNavigationBar:self.headNavigationBar];
    self.headNavigationBar.headPortrait = [UIImage imageNamed:@"222"];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.headNavigationBar.headPortrait = nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headNavigationBar reviseHeadPortraitSizeWithY:scrollView.contentOffset.y];
}

- (JCHeadNavigationBar *)headNavigationBar {
    if (!_headNavigationBar) {
        _headNavigationBar = [[JCHeadNavigationBar alloc]init];
    }
    return _headNavigationBar;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
    
        }
    return _scrollView;
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
