//
//  JCTableViewCell.m
//  JianShu
//
//  Created by molin on 16/3/22.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCTableViewCell.h"

@implementation JCTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCellModel:(id)cellModel {
    if ([cellModel isKindOfClass:[JCArticleCellModel class]]) {
        
    }
}

- (void)addSubview:(UIView *)view {
    [self removeFromSuperview];
    [super addSubview:view];
}

@end
