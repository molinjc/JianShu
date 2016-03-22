//
//  JCTabBar.m
//  JianShu
//
//  Created by molin on 16/2/26.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCTabBar.h"
#import "JCWriteViewController.h"

@interface JCTabBar ()

@property (nonatomic, strong) UIButton *writeButton;

@end

@implementation JCTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.writeButton];
    }
    return self;
}

/**
 *  重写layoutSubviews方法，布局子控件
 *  在frame改变时，会自动调用。（重定向子视图）
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // TabBar的尺寸
    CGFloat width = self.width;
    CGFloat height = self.height;
    // 设置编写按钮的位置
    self.writeButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置索引
    int index = 0;
    // 按钮的尺寸
    CGFloat tabBarButtonWidth = self.width / 5;
    CGFloat tabBarButtonHeight = self.height;
    CGFloat tabBarButtonY = 0;
    
    // 设置四个TabBarButton的frame
    for (UIView *tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        // 计算按钮的X的值
        CGFloat tabBarButtonX = index * tabBarButtonWidth;
        
        if (index >=2 ) {
            tabBarButtonX += tabBarButtonWidth; // 给后面2个button增加一个宽度的X值
        }
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonWidth, tabBarButtonHeight);
        index++;
    }
}

- (void)writeButtonAction:(UIButton *)sender {
    JCWriteViewController *writeVC = [[JCWriteViewController alloc] init];
    [self.window.rootViewController presentViewController:writeVC animated:NO completion:nil];
}


// 在frame改变时，会自动调用。（重定向子视图）
- (UIButton *)writeButton {
    if (!_writeButton) {
        _writeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_writeButton setBackgroundImage:[UIImage imageNamed:@"tabBar_write_icon"] forState:UIControlStateNormal];
        [_writeButton setBackgroundImage:[UIImage imageNamed:@"tabBar_write_click_icon"] forState:UIControlStateHighlighted];
        [_writeButton sizeToFit]; // 调整大小并移动接收者视图大小所以他包含了他的子视图
        [_writeButton addTarget:self action:@selector(writeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _writeButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
