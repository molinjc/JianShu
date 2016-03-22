//
//  JCButtonItemView.m
//  JianShu
//
//  Created by molin on 16/3/16.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCOptionItemView.h"
#import "AppDelegate.h"


#define SCREEN_BOUNDS [UIScreen mainScreen].bounds  // 屏幕的大小
#define ITEMHEIGHT   50.0                          // 按钮的高
#define ITEMWIDTH    180.0                         // 按钮的宽

@interface JCOptionItemView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *itemView;

@property (nonatomic, assign) CGPoint vertex;

@property (nonatomic,strong)  NSArray *items;

@end

@implementation JCOptionItemView

- (instancetype)initWithPoint:(CGPoint)point items:(NSArray *)items {
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        self.backgroundColor = [UIColor colorWithWhite:0.669 alpha:0.500];
        self.optionItemTitleColor = [UIColor blackColor];
        [self addSubview:self.itemView];
        self.items = items;
        [self.itemView reloadData];
        
        [self setItemViewFrameWith:point count:items.count];
        
        self.vertex = point;
        [self setNeedsDisplay];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame vertex:(CGPoint)vertex items:(NSArray *)items {
    if (self = [self initWithPoint:vertex items:items]) {
        self.itemView.frame = frame;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(self.vertex.x - 6, self.itemView.frame.origin.y)];
    [path addLineToPoint:self.vertex];
    [path addLineToPoint:CGPointMake(self.vertex.x + 6, self.itemView.frame.origin.y)];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = self.itemView.backgroundColor.CGColor;
    [self.layer addSublayer:shapeLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self removeFromSuperview];
}

#pragma mark - 自定义方法

- (void)setItemViewFrameWith:(CGPoint)point count:(NSInteger)count{
    CGFloat xRatio = point.x / self.width;
    self.itemView.frame = CGRectMake((self.width - ITEMWIDTH) * xRatio, 74, ITEMWIDTH, ITEMHEIGHT * count);
    JCLog(@"%f",self.itemView.x);
}

- (void)show {
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.window addSubview:self];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.items) {
        return 0;
    }
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.items) {
        return nil;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = self.optionItemTitleColor;
    }
    NSDictionary *dic = self.items[indexPath.row];
    cell.textLabel.text = dic[kOptionItemViewTitle];
    NSString *imageName = dic[kOptionItemViewImage];
    if (imageName.length != 0) {
        cell.imageView.image = [UIImage imageNamed:imageName];
    }else {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ITEMHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.optionItemViewDeleagate optionItemView:self item:indexPath.row];
    [self removeFromSuperview];
}

#pragma mark - set/get

- (UITableView *)itemView {
    if (!_itemView) {
        _itemView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _itemView.backgroundColor = [UIColor whiteColor];
        _itemView.layer.cornerRadius = 8;
        _itemView.bounces = NO;
        _itemView.delegate = self;
        _itemView.dataSource = self;
    }
    return _itemView;
}

- (void)setOptionSeparatorStyle:(BOOL)optionSeparatorStyle {
    self.itemView.separatorStyle = optionSeparatorStyle;
    _optionSeparatorStyle = optionSeparatorStyle;
}

- (void)setOptionItemBackgroundColor:(UIColor *)optionItemBackgroundColor {
    self.itemView.backgroundColor = optionItemBackgroundColor;
    _optionItemBackgroundColor = optionItemBackgroundColor;
}

- (void)setOptionItemTitleColor:(UIColor *)optionItemTitleColor {
    _optionItemTitleColor = optionItemTitleColor;
    [self.itemView reloadData];
}

@end
