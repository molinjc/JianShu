//
//  JCSliderButton.m
//  JianShu
//
//  Created by molin on 16/2/29.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCSliderButton.h"

#define BUTTON_WIDTH  80.0

@interface JCSliderButton ()

@property (nonatomic, strong) UIScrollView   *backgroundScrollView; // 作为底部的view，可滑动

@end

@implementation JCSliderButton

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.backgroundScrollView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles {
    if (self = [super init]) {
        self.frame = frame;
        self.titles = titles;
    }
    return self;
}

- (void)changeButtonTitleColorWithTag:(NSInteger)tag {
    if (tag < 100) {
        tag += 100;
    }
    for (UIView *view in self.backgroundScrollView.subviews) {
        if (![NSStringFromClass(view.class) isEqualToString:@"UIButton"]) {
            continue;
        }
        UIButton *button = (UIButton *)view;
        if (tag == button.tag) {
            [button setTitleColor:JCColor_red_1 forState:UIControlStateNormal];
        }else {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}

- (void)buttonsClick:(UIButton *)sender {
    [self changeButtonTitleColorWithTag:sender.tag];
    [self.delegate clickSomeButton:sender.tag-100];
}

- (void)setTitles:(NSMutableArray *)titles {
    
    _titles = titles;
    
    NSString *backgroundScrollViewFrame = NSStringFromCGRect(self.backgroundScrollView.frame);
    if ([backgroundScrollViewFrame isEqualToString:@"{{0, 0}, {0, 0}}"]) {
        self.backgroundScrollView.frame = self.bounds;
    }
    
    if (titles.count == 0) {
        return;
    }
    
    CGFloat buttons_width = BUTTON_WIDTH * titles.count;
    if (buttons_width <= self.width) {
        buttons_width = self.width;
    }
    self.backgroundScrollView.contentSize = CGSizeMake(buttons_width, self.height);
    
    CGFloat width = BUTTON_WIDTH;
    if (titles.count <= 2) {
        width = self.width / titles.count;
    }
    
    for (int i=0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(width * i, 0, width, self.height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag  = i + 100;
        [button addTarget:self action:@selector(buttonsClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [button setTitleColor:JCColor_red_1 forState:UIControlStateNormal];
        }else {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        
        [self.backgroundScrollView addSubview:button];
    }

}

- (UIScrollView *)backgroundScrollView {
    if (!_backgroundScrollView) {
        _backgroundScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _backgroundScrollView.backgroundColor = [UIColor colorWithRed:0.929 green:0.937 blue:0.941 alpha:1.000];
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.showsVerticalScrollIndicator = NO;
       // _backgroundScrollView.automaticallyAdjustsScrollViewInsets = NO;
       // _backgroundScrollView.autoresizesSubviews = NO;
    }
    return _backgroundScrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
