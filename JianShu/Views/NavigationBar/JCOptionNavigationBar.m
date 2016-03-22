//
//  JCOptionNavigationBar.m
//  JianShu
//
//  Created by molin on 16/3/3.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCOptionNavigationBar.h"

@interface JCOptionNavigationBar ()

@property (nonatomic, strong) UIButton *selectedButton; // 选中的

@end

@implementation JCOptionNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.selectedButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];    // 一定要写上这句代码，不然导航栏会变灰
    self.selectedButton.frame = CGRectMake(0, 0, 100, self.height);
    self.selectedButton.centerX = self.centerX;
}

- (void)showOptionView:(UIButton *)sender {
    [self.optionDelegate selectedAction];
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectedButton addTarget:self action:@selector(showOptionView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

- (void)setOptionTitle:(NSString *)optionTitle {
    [self.selectedButton setTitle:optionTitle forState:UIControlStateNormal];
    _optionTitle = optionTitle;
}

@end
