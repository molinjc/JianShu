//
//  JCMenuView.h
//  JianShu
//
//  Created by molin on 16/4/28.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCMenuItem;
@class JCMenuView;

@protocol JCMenuViewDelegate <NSObject>

- (void)menuView:(nonnull JCMenuView *)menuView didSelectItem:(NSInteger)index state:(BOOL)select;

@end


@interface JCMenuView : UIView

@property (nonnull, nonatomic, copy) NSArray<JCMenuItem *> *items;

@property (nonatomic, weak) id<JCMenuViewDelegate> delegate;

- (nonnull instancetype)initWithBottom:(CGPoint)bottom size:(CGSize)size;

@end

@interface JCMenuItem : NSObject

@property (nonnull, nonatomic, strong)  UIImage  *defaultImage;

@property (nullable, nonatomic, strong) UIImage  *selectImage;

@property (nullable, nonatomic, copy)   NSString *title;

- (nonnull instancetype)initWithDefaultImage:(nonnull UIImage *)defaultImage selectImage:(nullable UIImage *)selectImage titile:(nullable NSString *)title;

@end