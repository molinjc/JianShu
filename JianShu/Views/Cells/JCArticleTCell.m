//
//  JCArticleTCell.m
//  JianShu
//
//  Created by molin on 16/3/28.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCArticleTCell.h"
#import "UIButton+JCMixedArrangement.h"

#define UIFONT_12 [UIFont systemFontOfSize:12]
#define UIFONT_18 [UIFont systemFontOfSize:18]
#define UIFONT_13 [UIFont systemFontOfSize:13];

@implementation JCArticleTCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.user];
        [self addSubview:self.timeLabel];
        [self addSubview:self.titelLabel];
        [self addSubview:self.special];
        [self addSubview:self.articleInfoLabel];
        [self addSubview:self.articleImageView];
    }
    return self;
}

- (void)setSubViewsFrameAndContent:(JCArticleCellModel *)articleCellModel {
    
    CGSize size = [articleCellModel.userName sizeWithAttributes:
                             @{NSFontAttributeName:self.user.titleLabel.font}];
    self.user.frame = CGRectMake(18, 20, size.width + 43.5, 30);
    [self.user setTitle:articleCellModel.userName image:[[UIImage imageNamed:articleCellModel.headPortrait] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.timeLabel.size = CGSizeMake(80, 30);
    self.timeLabel.centerY = self.user.centerY;
    self.timeLabel.leftSpacingByView(self.user,0);
    self.timeLabel.text = articleCellModel.time;
    
    self.titelLabel.topSpacingByView(self.user,0);
    self.titelLabel.leftSpacingEqulTo(self.user,0);
    self.titelLabel.size = CGSizeMake(self.width - self.user.x * 2 , 30);
    self.titelLabel.text = articleCellModel.article;
    
    self.special.leftSpacingEqulTo(self.user,0);
    self.special.topSpacingByView(self.titelLabel,0);
    self.special.height = 20;
    size = [articleCellModel.special sizeWithAttributes:
                       @{NSFontAttributeName:self.special.titleLabel.font}];
    self.special.width = size.width + 13.5;
    self.special.layer.cornerRadius = self.special.height / 2;
    [self.special setTitle:articleCellModel.special forState:UIControlStateNormal];
    
    self.articleInfoLabel.leftSpacingByView(self.special,3);
    self.articleInfoLabel.topSpacingByView(self.titelLabel,0);
    self.articleInfoLabel.size = CGSizeMake(self.width - self.special.x - self.special.width, 20);
    self.articleInfoLabel.text = [NSString stringWithFormat:@"阅读 %@ · 评论 %@ · 喜欢 %@",articleCellModel.reading,articleCellModel.comments,articleCellModel.likes];
    
    self.articleImageView.width = self.articleImageView.height = self.user.height + self.titelLabel.height + self.special.height;
    [self.articleImageView rightForView:self spacing:- (self.articleImageView.width + self.user.x)];
    self.articleImageView.topSpacing = 20;
    self.articleImageView.image = [UIImage imageNamed:articleCellModel.articleImage];
}

#pragma mark 点击事件

- (void)clickUserButton:(UIButton *)sender {
    [self.articleTCellDelegate clickButtonWithUser];
}

- (void)clickSpecialButton:(UIButton *)sender {
    [self.articleTCellDelegate clickButtonWithSpecial];
}

#pragma mark set/get

- (UIButton *)user {
    if (!_user) {
        _user = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _user.titleLabel.font = UIFONT_12;
        [_user addTarget:self action:@selector(clickUserButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _user;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = UIFONT_12;
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UILabel *)titelLabel {
    if (!_titelLabel) {
        _titelLabel = [[UILabel alloc]init];
        _titelLabel.textAlignment = NSTextAlignmentLeft;
        _titelLabel.font = UIFONT_18;
    }
    return _titelLabel;
}

- (UIButton *)special {
    if (!_special) {
        _special = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _special.titleLabel.font = UIFONT_13;
        _special.layer.masksToBounds = YES;
        _special.layer.borderColor  = [UIColor orangeColor].CGColor;
        _special.layer.borderWidth = 1.0f;
        [_special setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_special addTarget:self action:@selector(clickSpecialButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _special;
}

- (UILabel *)articleInfoLabel {
    if (!_articleImageView) {
        _articleInfoLabel = [[UILabel alloc]init];
        _articleInfoLabel.font = UIFONT_12;
        _articleInfoLabel.textColor = [UIColor grayColor];
    }
    return _articleInfoLabel;
}

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = [[UIImageView alloc]init];
    }
    return _articleImageView;
}

@end
