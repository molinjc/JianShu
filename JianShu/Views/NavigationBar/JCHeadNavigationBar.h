//
//  JCHeadNavigationBar.h
//  JianShu
//
//  Created by molin on 16/3/2.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCHeadNavigationBar : UINavigationBar

@property (nonatomic, strong) UIImage *headPortrait;  // 头像图片

- (void)reviseHeadPortraitSizeWithY:(CGFloat)y;

/**
 *  缩小头像大小
 */
- (void)reduceHeadPortraitSize;

/**
 *  放大头像大小
 */
- (void)enlargeHeadPortraitSize;

@end
