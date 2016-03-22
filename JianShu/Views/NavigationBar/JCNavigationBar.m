//
//  JCNavigationBar.m
//  JianShu
//
//  Created by molin on 16/2/26.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCNavigationBar.h"

#define NavigationBar_Line 3.0  // 线条宽度
#define ButtonWidth         80.0 // 按钮的宽度

@interface JCNavigationBar ()

@property (nonatomic, strong) UIButton *articleButton;  // 文章

@property (nonatomic, strong) UIButton *specialButton;  // 专题

@property (nonatomic, strong) UIView   *verticalLine;   // 竖线

@property (nonatomic, strong) UIView   *transverseLine; // 横线

@end

@implementation JCNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.articleButton];
        [self addSubview:self.specialButton];
        [self addSubview:self.verticalLine];
        [self addSubview:self.transverseLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // NavigationBar的尺寸
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.verticalLine.frame = CGRectMake((width - NavigationBar_Line) * 0.5, height * 0.25, NavigationBar_Line * 0.5, height * 0.5);
    
    if (self.transverseLine.x == self.specialButton.x) {
        self.transverseLine.frame = CGRectMake(self.specialButton.x, height - NavigationBar_Line, self.articleButton.width, NavigationBar_Line);
    }else {
        self.transverseLine.frame = CGRectMake(self.articleButton.x, height - NavigationBar_Line, self.articleButton.width, NavigationBar_Line);
    }
    
    self.articleButton.frame = CGRectMake(width * 0.5 - ButtonWidth - NavigationBar_Line, 0, ButtonWidth, height);
    self.specialButton.frame = CGRectMake(width * 0.5 + NavigationBar_Line, 0, ButtonWidth, height);
}

- (void)articleAndspecialButtonAction:(UIButton *)sender {
    [UIView animateWithDuration:0.1 animations:^{
        self.transverseLine.x = sender.x;
    }];
    
    BOOL switchView = YES;
    
    if (sender.tag == 101) {
        switchView = YES;
        [sender setTitleColor:JCColor_red_1 forState:UIControlStateNormal];
        [self.specialButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }else {
        switchView = NO;
        [sender setTitleColor:JCColor_red_1 forState:UIControlStateNormal];
        [self.articleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    [self.navigationBarDelegate switchView:switchView];
}

- (UIButton *)articleButton {
    if (!_articleButton) {
        _articleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _articleButton.tag = 101;
        [_articleButton setTitle:@"文章" forState:UIControlStateNormal];
        [_articleButton setTitleColor:JCColor_red_1 forState:UIControlStateNormal];
        [_articleButton addTarget:self action:@selector(articleAndspecialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _articleButton;
}

- (UIButton *)specialButton {
    if (!_specialButton) {
        _specialButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _specialButton.tag = 102;
        [_specialButton setTitle:@"专题" forState:UIControlStateNormal];
        [_specialButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_specialButton addTarget:self action:@selector(articleAndspecialButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _specialButton;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = [UIColor grayColor];
    }
    return _verticalLine;
}

- (UIView *)transverseLine {
    if (!_transverseLine) {
        _transverseLine = [[UIView alloc] init];
        _transverseLine.backgroundColor = JCColor_red_1;
    }
    return _transverseLine;
}

@end
