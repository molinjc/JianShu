//
//  JCFindView.m
//  JianShu
//
//  Created by molin on 16/2/29.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCFindView.h"
#import "JCSliderButton.h"

#import "JCScrollAndPageControlView.h"

#define SliderButton_Height   40.0

@interface JCFindView ()<JCSliderButtonDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) JCSliderButton *sliderButton;

@property (nonatomic, strong) UIScrollView   *scrollView;

@property (nonatomic, assign) NSInteger      currentShowViewOftag;

@property (nonatomic, strong) NSMutableArray *visiableTables;   // 可见得Table数组

@property (nonatomic, strong) NSMutableArray *reusableTables;   // 可重复使用的Table数组

@end


@implementation JCFindView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.currentShowViewOftag = 0;
        
        [self addSubview:self.sliderButton];
        [self addSubview:self.scrollView];
        self.sliderButton.titles = titles;
        
        [self setScrollViewWithContentSize:titles];
        [self creatTableView:titles];
    }
    return self;
}

- (void)setScrollViewWithContentSize:(NSMutableArray *)titles {
    if (titles.count <= 0) {
        return;
    }
    self.scrollView.contentSize = CGSizeMake(self.width * titles.count, self.scrollView.height);
}

- (void)creatTableView:(NSMutableArray *)titles {
    if (titles.count <= 0) {
        return;
    }
    for (int i=0; i<titles.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.width * i, 0, self.width, self.scrollView.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        [self.scrollView addSubview:tableView];
    }
}

#pragma mark - JCSliderButtonDelegate

- (void)clickSomeButton:(NSInteger)tag {
    if (tag == self.currentShowViewOftag) {
        return;
    }
    NSInteger temporaryTag = 0;
    if (tag > self.currentShowViewOftag) {
        temporaryTag = tag - 1;
    }else {
        temporaryTag = tag + 1;
    }
    UITableView *currentShowView = nil;
    CGRect temporaryRect;
    for (UIView *temporaryView in self.scrollView.subviews) {
        if (![NSStringFromClass(temporaryView.class) isEqualToString:@"UITableView"]) {
            continue;
        }
        if (temporaryView.tag == temporaryTag) {
            temporaryRect = temporaryView.frame;
        }
        if (temporaryView.tag == self.currentShowViewOftag) {
            currentShowView = (UITableView *)temporaryView;
        }
    }
    CGRect originalRect = currentShowView.frame;
    currentShowView.frame = temporaryRect;
    [self.scrollView setContentOffset:temporaryRect.origin animated:NO];
    [self.scrollView setContentOffset:CGPointMake(self.width*tag, 0) animated:YES];
    currentShowView.frame = originalRect;
    self.currentShowViewOftag = tag;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.scrollView == scrollView) {
        UITableView *currentShowView = nil;
        for (UIView *temporaryView in self.scrollView.subviews) {
            if (![NSStringFromClass(temporaryView.class) isEqualToString:@"UITableView"]) {
                continue;
            }
            if (temporaryView.tag == self.currentShowViewOftag) {
                currentShowView = (UITableView *)temporaryView;
            }
        }
        
        NSInteger index = (int)scrollView.contentOffset.x / self.width;
        [self.sliderButton changeButtonTitleColorWithTag:index];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataDelegate findView:self numberDataFromTag:tableView.tag];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [self.dataDelegate findView:self dataFromTag:tableView.tag item:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 380;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [self.dataDelegate findView:self heightForHeaderTag:tableView.tag];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.dataDelegate findView:self viewForHeaderTag:tableView.tag];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataDelegate findView:self didSelectTag:tableView.tag selectRowAtIndex:indexPath.row];
}

#pragma mark - 懒加载

- (JCSliderButton *)sliderButton {
    if (!_sliderButton) {
        _sliderButton = [[JCSliderButton alloc] init];
        _sliderButton.frame = CGRectMake(0, 0, self.width, SliderButton_Height);
        _sliderButton.delegate = self;
    }
    return _sliderButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SliderButton_Height, self.width, self.height - SliderButton_Height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSMutableArray *)visiableTables {
    if (!_visiableTables) {
        _visiableTables = [NSMutableArray new];
    }
    return _visiableTables;
}

- (NSMutableArray *)reusableTables {
    if (_reusableTables) {
        _reusableTables = [NSMutableArray new];
    }
    return _reusableTables;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
