//
//  JCMyViewController.m
//  JianShu
//
//  Created by molin on 16/2/25.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCMyViewController.h"

#import "JCHeadNavigationViewController.h"

@interface JCMyViewController ()

@property (nonatomic, strong) UINavigationBar *orgnavigationBar;

@end

@implementation JCMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.orgnavigationBar = self.navigationController.navigationBar;
    
    self.title = @"我的";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    [button setTitle:@"我的" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pusMyVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)viewDidAppear:(BOOL)animated {
//    [self.navigationController setValue:self.orgnavigationBar forKey:@"navigationBar"];
}

- (void)pusMyVC:(UIButton *)sender {
    JCHeadNavigationViewController *headNVC = [[JCHeadNavigationViewController alloc]init];
    [self.navigationController pushViewController:headNVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
