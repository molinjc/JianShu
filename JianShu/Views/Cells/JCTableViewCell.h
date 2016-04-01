//
//  JCTableViewCell.h
//  JianShu
//
//  Created by molin on 16/3/22.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCArticleTCell.h"

@interface JCTableViewCell : UITableViewCell

@property (nonatomic, strong) JCCellModel *cellModel;

@property (nonatomic, strong) JCArticleTCell *articleTCell;

@end
