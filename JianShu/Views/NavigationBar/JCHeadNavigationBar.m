//
//  JCHeadNavigationBar.m
//  JianShu
//
//  Created by molin on 16/3/2.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCHeadNavigationBar.h"

#define HEADPORTRAIT_RADIUS  34.0   // 头像的半径
#define HEADPORTRAIT_Y       10.0   // 头像的y

@interface JCHeadNavigationBar ()

@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation JCHeadNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.headImageView.x == 0) {
        self.headImageView.size = CGSizeMake(HEADPORTRAIT_RADIUS * 2, HEADPORTRAIT_RADIUS * 2);
        self.headImageView.centerX = self.centerX;
        self.headImageView.y = HEADPORTRAIT_Y;
        self.headImageView.layer.cornerRadius = HEADPORTRAIT_RADIUS;
        self.headImageView.layer.masksToBounds = YES;
    }
}

- (void)reviseHeadPortraitSizeWithY:(CGFloat)y {
    CGFloat changeHeight;
    CGFloat height = HEADPORTRAIT_RADIUS * 2;
    if (y >= 0.0 && y <= HEADPORTRAIT_RADIUS + 2) {
        changeHeight = y;
    }else if (y > HEADPORTRAIT_RADIUS + 2) {
        changeHeight = HEADPORTRAIT_RADIUS + 2;
    }else {
         changeHeight = 0;
    }
    self.headImageView.size = CGSizeMake(height - changeHeight, height - changeHeight);
    self.headImageView.centerX = self.centerX;
    self.headImageView.layer.cornerRadius = self.headImageView.height / 2;
}

- (void)reduceHeadPortraitSize {
    if (self.headImageView.height >= HEADPORTRAIT_RADIUS-1) {
        CGSize size = self.headImageView.size;
        self.headImageView.size = CGSizeMake(size.height-1, size.height -1);
        self.headImageView.centerX = self.centerX;
        self.headImageView.layer.cornerRadius = self.headImageView.height / 2;
    }
}

- (void)enlargeHeadPortraitSize {
    if (self.headImageView.height <= HEADPORTRAIT_RADIUS * 2) {
        CGSize size = self.headImageView.size;
        self.headImageView.size = CGSizeMake(size.height + 1, size.height + 1);
        self.headImageView.centerX = self.centerX;
        self.headImageView.layer.cornerRadius = self.headImageView.height / 2;
    }
}

- (void)setHeadPortrait:(UIImage *)headPortrait {
    self.headImageView.image = headPortrait;
    _headPortrait = headPortrait;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
    }
    return _headImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
