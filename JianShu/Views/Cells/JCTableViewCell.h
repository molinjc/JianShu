//
//  JCTableViewCell.h
//  JianShu
//
//  Created by molin on 16/3/22.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCCellModel.h"

@interface JCTableViewCell : UITableViewCell

@property (nonatomic, strong) id cellModel;

@property (nonatomic, strong) UIImageView *headPortrait;

@property (nonatomic, strong) UILabel     *userNameLabel;

@property (nonatomic, strong) UILabel     *timeLabel;

@end
