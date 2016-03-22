//
//  JCSliderButton.h
//  JianShu
//
//  Created by molin on 16/2/29.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCSliderButtonDelegate <NSObject>

/**
 *  点击某按钮
 *
 *  @param tag 第几个
 */
- (void)clickSomeButton:(NSInteger)tag;

@end

@interface JCSliderButton : UIView

@property (nonatomic, weak) id<JCSliderButtonDelegate> delegate;

@property (nonatomic, strong) NSMutableArray<NSString *> *titles;  // 按钮的title

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles;

- (void)changeButtonTitleColorWithTag:(NSInteger)tag;

@end
