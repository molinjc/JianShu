//
//  UIButton+JCMixedArrangement.m
//  JianShu
//
//  Created by molin on 16/3/28.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "UIButton+JCMixedArrangement.h"

@implementation UIButton (JCMixedArrangement)

- (void)setTitle:(NSString *)title image:(UIImage *)image {
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, self.width-self.height)];
    self.imageView.layer.cornerRadius = self.height / 2;
    self.imageView.layer.masksToBounds = YES;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.width * 2.2, 0, 0)];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

@end
