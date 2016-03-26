//
//  JCFindView.h
//  JianShu
//
//  Created by molin on 16/2/29.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCCellModel.h"

@class JCFindView;

@protocol JCFindViewDataDelegate <NSObject>

- (NSInteger)findView:(JCFindView *)findView numberDataFromTag:(NSInteger)tag;

- (JCCellModel *)findView:(JCFindView *)findView dataFromTag:(NSInteger)tag item:(NSInteger)index;

- (UIView *)findView:(JCFindView *)findView customCellWithDataFromTag:(NSInteger)tag item:(NSInteger)index;
- (CGFloat)findView:(JCFindView *)findView heightForRowTag:(NSInteger)tag item:(NSInteger)index;

- (CGFloat)findView:(JCFindView *)findView heightForHeaderTag:(NSInteger)tag;

- (UIView *)findView:(JCFindView *)findView viewForHeaderTag:(NSInteger)tag;

- (void)findView:(JCFindView *)findView didSelectTag:(NSInteger)tag selectRowAtIndex:(NSInteger)index;

@end

@interface JCFindView : UIView

@property (nonatomic, weak) id<JCFindViewDataDelegate> dataDelegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles;

@end
