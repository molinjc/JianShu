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
#import "JCTableViewCell.h"

#define SliderButton_Height   40.0

@interface JCFindView ()<JCSliderButtonDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) JCSliderButton *sliderButton;

@property (nonatomic, strong) UIScrollView   *scrollView;

@property (nonatomic, assign) NSInteger      currentShowViewOftag;

@property (nonatomic, strong) NSMutableArray *visiableTables;// 可见得Table数组

@property (nonatomic, strong) NSMutableArray *reusableTables;// 可重复使用的Table数组

@property (nonatomic, assign) BOOL           reusingStarter; // 重用启动器,默认yes

@end


@implementation JCFindView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.currentShowViewOftag = 0;
        
        [self addSubview:self.sliderButton];
        [self addSubview:self.scrollView];
        self.sliderButton.titles = titles;
        self.reusingStarter = YES;
        [self setScrollViewWithContentSize:titles];
        [self creatTableViews:titles.count];
    }
    return self;
}

- (void)setScrollViewWithContentSize:(NSMutableArray *)titles {
    if (titles.count <= 0) {
        return;
    }
    self.scrollView.contentSize = CGSizeMake(self.width * titles.count, self.scrollView.height);
}

- (void)creatTableViews:(NSInteger)count {
    if (count <= 0) {
        return;
    }
    
    if (count <= 3) {
        self.reusingStarter = NO;
    }
    
    if (self.reusingStarter) {
        
        [self.visiableTables removeAllObjects];
        [self.reusableTables removeAllObjects];
        
        // 刚开始时，只创建两个表格视图，第一个加到可见得Table数组里，另一个加到不可见的数组
        for (int i=0; i<3; i++) {
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.width * i, 0, self.width, self.scrollView.height) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = i;
            
            [self.scrollView addSubview:tableView];
            if (i == 0) {
                [self.visiableTables addObject:tableView];
            }else {
                [self.reusableTables addObject:tableView];
            }
            [tableView reloadData];
        }
    }else {
        for (int i=0; i<count; i++) {
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.width * i, 0, self.width, self.scrollView.height) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = i;
            [self.scrollView addSubview:tableView];
             [tableView reloadData];
        }
    }
}


#pragma mark - 重用机制

/**
 *  scrollView向右滑动
 */
- (void)scrollViewTowardsRight {
    
    // 从可见的拿出Table，清空数组，方便存储下一个要显示的Table，这个visiableTables只有一个元素
    UITableView *willHideView = self.visiableTables[0];
    [self.visiableTables removeAllObjects];
    
    // 从不可见的拿出第一个Table，这个是要显示的，还要从这个数组清掉它的记录，将要隐藏的Table存进去
    UITableView *willShowView = self.reusableTables[0];
    [self.visiableTables addObject:willShowView];
    [self.reusableTables removeObjectAtIndex:0];
    [self.reusableTables addObject:willHideView];
    
    // Table个数够用了，提前修改下一次向右滑动要显示的Table
    if (willShowView.tag + 1 != self.sliderButton.titles.count) {
        UITableView *afreshLoadView = self.reusableTables[0];
        afreshLoadView.x = (willShowView.tag + 1) * self.width;
        afreshLoadView.tag = willShowView.tag + 1;
        [afreshLoadView reloadData];
    }

}

/**
 *  scrollView向左滑动
 */
- (void)scrollViewTowardsLeft {
    
    // 同上
    UITableView *willHideView = self.visiableTables[0];
    [self.visiableTables removeAllObjects];
    
    // 从不可见的拿出最后一个Table，处理同上
    UITableView *willShowView = self.reusableTables[1];
    [self.visiableTables addObject:willShowView];
    [self.reusableTables removeObjectAtIndex:1];
    [self.reusableTables insertObject:willHideView atIndex:0];
    
    // 刚创建时，向左滑动，左边是没Table的，是不会调用此方法的，当向右滑动时，
    // reusableTables的个数就会达到2,这里就不在判断，只判断Table的tag
    if (willShowView.tag >= 1) {
        UITableView *afreshLoadView = self.reusableTables[1];
        afreshLoadView.x = (willShowView.tag - 1) * self.width;
        afreshLoadView.tag = willShowView.tag - 1;
        [afreshLoadView reloadData];
    }
}

#pragma mark - JCSliderButtonDelegate

- (void)clickSomeButton:(NSInteger)tag {
    if (tag == self.currentShowViewOftag) {
        return;
    }
    
    if (self.reusingStarter) {
        UITableView *didShowTable = self.visiableTables[0];
        if (tag > self.currentShowViewOftag) {
            didShowTable.x = self.width * (tag - 1);
        }else if (tag < self.currentShowViewOftag) {
            didShowTable.x = self.width * (tag + 1);
        }
        [self.scrollView setContentOffset:didShowTable.origin animated:NO];
        UITableView *willShowTable = self.reusableTables[0];
        willShowTable.x = self.width * tag;
        willShowTable.tag = tag;
        [willShowTable reloadData];
        [self.scrollView setContentOffset:willShowTable.origin animated:YES];
    }else {
        [self.scrollView setContentOffset:CGPointMake(self.width * tag, 0) animated:YES];
        self.currentShowViewOftag = tag;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.scrollView == scrollView) {
        NSInteger index = (int)scrollView.contentOffset.x / self.width;
        if (self.reusingStarter) {
            
            UITableView *currentShowView = self.visiableTables[0];
            if (index > currentShowView.tag) {
                [self scrollViewTowardsRight];
            }else if (index < currentShowView.tag) {
                [self scrollViewTowardsLeft];
            }
        }
        [self.sliderButton changeButtonTitleColorWithTag:index];
    }
}

// 动画结束后会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (!self.reusingStarter) {
        return;
    }
    NSInteger index = (int)scrollView.contentOffset.x / self.width;
    UITableView *didHideTable = self.visiableTables[0];  // 动画结束后，这个Table已经看不到了
    UITableView *didShowTable = self.reusableTables[0];  // 动画结束后，这个Table已经可见了
    UITableView *willAlterTable = self.reusableTables[1];
    
    [self.visiableTables removeAllObjects];
    [self.visiableTables addObject:didShowTable];
    
    [self.reusableTables removeObjectAtIndex:0];
    [self.reusableTables addObject:didHideTable];
    
    NSInteger reusable_0,reusable_1;
    if (index == self.sliderButton.titles.count - 1) {
        reusable_0 = index - 2;
        reusable_1 = index - 1;
    }else if (index == 0) {
        reusable_0 = 1;
        reusable_1 = 2;
    }else {
        reusable_0 = index + 1;
        reusable_1 = index - 1;
    }
    
    willAlterTable.x = self.width * reusable_0;
    willAlterTable.tag = reusable_0;
    [willAlterTable reloadData];
    
    didHideTable.x = self.width * reusable_1;
    didHideTable.tag = reusable_1;
    [didHideTable reloadData];
    
    self.currentShowViewOftag = index;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataDelegate findView:self numberDataFromTag:tableView.tag];
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[JCTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    JCCellModel *cellModel = [self.dataDelegate findView:self dataFromTag:tableView.tag item:indexPath.row];
    if (cellModel.cellModelType == JCFindCellModelTypeOther) {
        [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
         [cell addSubview:[self.dataDelegate findView:self customCellWithDataFromTag:tableView.tag item:indexPath.row]];
    }else {
        [cell setCellModel:cellModel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataDelegate findView:self heightForRowTag:tableView.tag item:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [self.dataDelegate findView:self heightForHeaderTag:tableView.tag];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.dataDelegate findView:self viewForHeaderTag:tableView.tag];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    if (!_reusableTables) {
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
