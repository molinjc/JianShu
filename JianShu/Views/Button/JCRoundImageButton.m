//
//  JCRoundImageButton.m
//  JianShu
//
//  Created by molin on 16/3/22.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCRoundImageButton.h"

@interface JCRoundImageButton ()

@property (nonatomic, strong) UIImageView *roundImageView;

@property (nonatomic, strong) UILabel *labelText;

@end

@implementation JCRoundImageButton


- (UIImageView *)roundImageView {
    if (!_roundImageView) {
        _roundImageView = [[UIImageView alloc]init];
    }
    return _roundImageView;
}

- (UILabel *)labelText {
    if (!_labelText) {
        _labelText = [[UILabel alloc]init];
    }
    return _labelText;
}

@end
