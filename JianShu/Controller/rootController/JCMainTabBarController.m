//
//  JCMainTabBarController.m
//  JianShu
//
//  Created by molin on 16/2/25.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCMainTabBarController.h"

#import "JCTabBar.h"

#import "JCFindNavigationController.h"
#import "JCFollowViewController.h"
#import "JCFriendViewController.h"
#import "JCMyViewController.h"


@interface JCMainTabBarController ()

@end

@implementation JCMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updataTabBar];
    
    [self setUpItem];
    
    [self addChildViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  更新TabBar
 */
- (void)updataTabBar {
    [self setValue:[[JCTabBar alloc] init] forKey:@"tabBar"];
}

/**
 *  设置Item的属性
 */
- (void)setUpItem
{
    // UIControlStateNormal情况下的文字属性
    NSMutableDictionary *normalAtrrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAtrrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // UIControlStateSelected情况的文字属性
    NSMutableDictionary *selectedAtrrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAtrrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.863 green:0.310 blue:0.251 alpha:1.000];
    
    // 统一给所有的UITabBatItem设置文字属性
    // 只有后面带有UI_APPEARANCE_SELECTOR方法的才可以通过appearance来设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAtrrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAtrrs forState:UIControlStateSelected];
}

/**
 *  添加子控件
 */
- (void)addChildViewControllers {
    // 发现
    JCFindNavigationController *findVC = [[JCFindNavigationController alloc] initWithFindRootViewController:[[JCFindViewController alloc]init]];
    findVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabBar_find_icon"] selectedImage:[[UIImage imageNamed:@"tabBar_find_click_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:findVC];
    
    // 关注
    [self addChildViewController:[[JCFollowViewController alloc]init] Title:@"关注" image:[UIImage imageNamed:@"tabBar_follow_icon"] selectedImage:[[UIImage imageNamed:@"tabBar_follow_click_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 简友圈
    [self addChildViewController:[[JCFriendViewController alloc]init] Title:@"简友圈" image:[UIImage imageNamed:@"tabBar_friend_icon"] selectedImage:[[UIImage imageNamed:@"tabBar_friend_click_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 我的
    [self addChildViewController:[[JCMyViewController alloc]init] Title:@"我的" image:[UIImage imageNamed:@"tabBar_my_icon"] selectedImage:[[UIImage imageNamed:@"tabBar_my_click_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


/**
 *  创建子控制器
 *
 *  @param viewController 子控制器
 *  @param title          标题
 *  @param image          默认时图片
 *  @param selectedImage  选中时图片
 *
 *  @return 导航栏控制器
 */
- (void)addChildViewController:(UIViewController *)viewController Title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    navigationController.tabBarItem =  [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
    [self addChildViewController:navigationController];
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
