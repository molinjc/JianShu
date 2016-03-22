//
//  JCButtonItemView.h
//  JianShu
//
//  Created by molin on 16/3/16.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

//NSString *const kOptionItemViewTitle = @"title";
//NSString *const kOptionItemViewImage = @"image";

#define kOptionItemViewTitle  @"title"
#define kOptionItemViewImage  @"image"


@protocol JCOptionItemViewDelegate;

@interface JCOptionItemView : UIView

@property (nonatomic, weak) id<JCOptionItemViewDelegate> optionItemViewDeleagate;

@property (nonatomic, assign) BOOL optionSeparatorStyle;  // 分割线

@property (nonatomic, strong) UIColor *optionItemBackgroundColor;

@property (nonatomic, strong) UIColor *optionItemTitleColor;  // 字体颜色

- (instancetype)initWithPoint:(CGPoint)point items:(NSArray *)items;

- (void)show;

@end

@protocol JCOptionItemViewDelegate <NSObject>

- (void)optionItemView:(JCOptionItemView *)optionItemView item:(NSInteger)item;

@end
