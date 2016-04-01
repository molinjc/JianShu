//
//  JCArticleTCell.h
//  JianShu
//
//  Created by molin on 16/3/28.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCCellModel.h"

@protocol JCArticleTCellDelegate <NSObject>

- (void)clickButtonWithUser;
- (void)clickButtonWithSpecial;

@end

@interface JCArticleTCell : UIView

@property (nonatomic, weak) id<JCArticleTCellDelegate> articleTCellDelegate;

@property (nonatomic, strong) UIButton    *user;

@property (nonatomic, strong) UILabel     *timeLabel;

@property (nonatomic, strong) UILabel     *titelLabel;

@property (nonatomic, strong) UIButton    *special;

@property (nonatomic, strong) UILabel     *articleInfoLabel;

@property (nonatomic, strong) UIImageView *articleImageView;

- (void)setSubViewsFrameAndContent:(JCArticleCellModel *)articleCellModel;

@end
