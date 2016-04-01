//
//  JCTableViewCell.m
//  JianShu
//
//  Created by molin on 16/3/22.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCTableViewCell.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface JCTableViewCell ()<JCArticleTCellDelegate>

@end

@implementation JCTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCellModel:(JCCellModel *)cellModel {
    self.width = [UIScreen mainScreen].bounds.size.width;
    switch (cellModel.cellModelType) {
        case JCFindCellModelTypeOther: {
            
            break;
        }
        case JCFindCellModelTypedefault: {
            
            break;
        }
        case JCFindCellModelTypeArticle: {
            BOOL isExisted = NO;
            for (UIView *subV in self.subviews) {
                if ([subV isKindOfClass:[JCArticleTCell class]]) {
                    isExisted = YES;
                    break;
                }else {
                    [subV removeFromSuperview];
                }
            }
            
            if (!self.articleTCell || !isExisted) {
                self.articleTCell = [[JCArticleTCell alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 119)];
                self.articleTCell.articleTCellDelegate = self;
                [self addSubview:self.articleTCell];
            }
            [self.articleTCell setSubViewsFrameAndContent:cellModel.articles];
            
            break;
        }
        case JCFindCellModelTypeSpecial: {
            
            break;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - JCArticleTCellDelegate

- (void)clickButtonWithUser {
    JCLog(@"用户");
}

- (void)clickButtonWithSpecial {
    JCLog(@"专题");
}

@end
