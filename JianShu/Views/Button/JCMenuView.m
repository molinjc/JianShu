//
//  JCMenuView.m
//  JianShu
//
//  Created by molin on 16/4/28.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCMenuView.h"
#import "JCButton.h"

@interface JCMenuView ()

@property (nonatomic, assign) CGPoint bottom;

@end

@implementation JCMenuView

- (instancetype)initWithBottom:(CGPoint)bottom size:(CGSize)size {
    if (self = [super init]) {
        self.size = size;
        self.bottom = bottom;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)itemButtonAction:(JCButton *)sender {
    JCLog(@"itemButtonAction:%ld",(long)sender.tag);
    JCMenuItem *item = self.items[sender.tag];
    sender.isSelect = !sender.isSelect;
    if (sender.isSelect) {
        [sender setImage:[item.selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        [sender setImage:[item.defaultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    
    [self.delegate menuView:self didSelectItem:sender.tag state:sender.isSelect];
    
}

- (void)setBottom:(CGPoint)bottom {
    CGFloat x = bottom.x - self.width / 2;
    CGFloat y = bottom.y - self.height - 10;
    self.origin = CGPointMake(x, y);
}

- (void)setItems:(NSArray<JCMenuItem *> *)items {
    _items = items;
    CGFloat width = self.width / items.count;
    int i = 0;
    for (JCMenuItem *item in items) {
        JCButton *button = [JCButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(i * width, 0, width, self.height);
        [button setImage:[item.defaultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(itemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor blackColor]];
        [self addSubview:button];
        i++;
    }
}

//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    CAShapeLayer *shapeLayer = [CAShapeLayer new];
//    UIBezierPath *path = [UIBezierPath new];
//    [path moveToPoint:CGPointMake(self.bottom.x - 6, self.bottom.y-10)];
//    [path addLineToPoint:self.bottom];
//    [path addLineToPoint:CGPointMake(self.bottom.x + 6, self.bottom.y)];
//    shapeLayer.path = path.CGPath;
////    shapeLayer.fillColor = self.itemView.backgroundColor.CGColor;
//    [self.layer addSublayer:shapeLayer];
//}

@end

@implementation JCMenuItem

- (instancetype)initWithDefaultImage:(UIImage *)defaultImage selectImage:(UIImage *)selectImage titile:(NSString *)title {
    if (self = [super init]) {
        self.defaultImage = defaultImage;
        self.selectImage = selectImage;
    }
    return self;
}

@end