//
//  JCTextController.m
//  JianShu
//
//  Created by molin on 16/3/11.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCTextController.h"

#import "UIViewController+Replace.h"

@interface JCTextController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView    *scrollView;

@property (nonatomic, assign) CGFloat         recordBeginDragging_y; // 记录开始拖动的Y

@property (nonatomic, strong) UINavigationBar *recordBar;   // 记录原来的NavigationBar

@property (nonatomic, strong) UIView          *functionOptionView; // 功能选项视图

@end

@implementation JCTextController

#pragma mark - ViewController方法

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordBeginDragging_y = 0;
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.functionOptionView];
    
    [self addGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // *** 布局 ***
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = self.view.size;
    self.functionOptionView.width = self.view.width / 3;
    self.functionOptionView.height = self.view.height;
    self.functionOptionView.leftSpacingByView(self.scrollView,0);
    
    // 隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
    
    // 替换NavigationBar
    self.recordBar = self.navigationController.navigationBar;
    [self replaceNavigationBar:[[UINavigationBar alloc] init]];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    // 添加BarButtonItem
    [self addRightNavigationItem];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self replaceNavigationBar:self.recordBar];
}

#pragma mark - 自定义方法

- (void)addRightNavigationItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"..." style:UIBarButtonItemStyleDone target:self action:@selector(navigationBarWithRightBarButtonItem:)];
//    self.navigationController.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  添加手势
 */
- (void)addGestureRecognizer {
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerEvent:)];
    // 右滑
    [swipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerEvent:)];
    // 左滑
    [swipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

/**
 *  视图左滑动画
 */
- (void)viewLeftSlipAnimate {
    [UIView animateWithDuration:0.15 animations:^{
        self.navigationController.navigationBar.x = -(self.view.width / 3);
        self.scrollView.x = -(self.view.width / 3);
        self.functionOptionView.leftSpacingByView(self.scrollView,0);
    }];
}

/**
 *  视图右滑动画
 */
- (void)viewRightSlipAnimate {
    [UIView animateWithDuration:0.15 animations:^{
        self.navigationController.navigationBar.x = 0;
        self.scrollView.x = 0;
        self.functionOptionView.leftSpacingByView(self.scrollView,0);
    }];
}

#pragma mark - 响应事件

- (void)navigationBarWithRightBarButtonItem:(UIBarButtonItem *)sender {
    if (self.scrollView.x < 0) {
        [self viewRightSlipAnimate];
    }else {
        [self viewLeftSlipAnimate];
    }
}

- (void)swipeGestureRecognizerEvent:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self viewLeftSlipAnimate];
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.scrollView.x < 0) {
            [self viewRightSlipAnimate];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
    [self viewRightSlipAnimate];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.recordBeginDragging_y = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat spacing = scrollView.contentOffset.y - self.recordBeginDragging_y;
    if (spacing >= 5) {
        [UIView animateWithDuration:0.15 animations:^{
            self.navigationController.navigationBar.y = -self.navigationController.navigationBar.height;
        }];
    }else if (spacing <= -5) {
        [UIView animateWithDuration:0.15 animations:^{
            self.navigationController.navigationBar.y = 20;
        }];
    }
}

#pragma mark - set/get

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)functionOptionView {
    if (!_functionOptionView) {
        _functionOptionView = [[UIView alloc]init];
        _functionOptionView.backgroundColor = [UIColor greenColor];
    }
    return _functionOptionView;
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
