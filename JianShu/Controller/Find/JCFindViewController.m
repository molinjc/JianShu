//
//  JCFindViewController.m
//  JianShu
//
//  Created by molin on 16/2/25.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCFindViewController.h"

#import "JCScrollAndPageControlView.h"

#import "JCTextController.h"
#import "JCOptionItemView.h"

#import "JCCellModel.h"

#define ButtonsView_Height   35.0
#define Button_Width         90.0
#define NavigationBar_Height 64.0
#define JCFINDVIEWFRAME_X(x) CGRectMake(x, NavigationBar_Height, self.view.width, self.view.height - NavigationBar_Height - self.tabBarController.tabBar.height)
#define JCScrollAndPageControlView_Height (self.view.width * 1000 / 2048)

@interface JCFindViewController ()<JCFindViewDataDelegate>

@property (nonatomic, strong) NSMutableArray *firstData;

@property (nonatomic, strong) NSMutableArray *secondDataArray;
@property (nonatomic, strong) UIImage *im;
@property (nonatomic, strong) UIImageView *iv;
@end

@implementation JCFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.secondView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏返回按钮的标题
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}


/**
 *  创建JCScrollAndPageControlView类
 */
- (JCScrollAndPageControlView *)creatScrollAndPageControlView {
    NSMutableArray *images = [NSMutableArray new];
    [images addObject:@"http://a.hiphotos.baidu.com/ting/pic/item/94cad1c8a786c917c49e9e83ce3d70cf3ac757ef.jpg"];
    [images addObject:@"http://a.hiphotos.baidu.com/ting/pic/item/c8177f3e6709c93dc0063c4c983df8dcd0005490.jpg"];
    [images addObject:@"http://b.hiphotos.baidu.com/ting/pic/item/11385343fbf2b2114f9c31f7cd8065380dd78edd.jpg"];
    [images addObject:@"http://c.hiphotos.baidu.com/ting/pic/item/e850352ac65c1038af4da57ab5119313b07e8953.jpg"];
    [images addObject:@"http://a.hiphotos.baidu.com/ting/pic/item/c8177f3e6709c93d04f77840983df8dcd100547b.jpg"];
    
    
    JCScrollAndPageControlView *sapv = [[JCScrollAndPageControlView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, JCScrollAndPageControlView_Height) images:images];
    return sapv;
}

#pragma mark - JCFindViewDataDelegate

- (NSInteger)findView:(JCFindView *)findView numberDataFromTag:(NSInteger)tag {
    
    NSInteger count = 0;
    if (findView.tag == 101) {
        count = self.firstData.count;
        if (tag == 0) {
            count++;
        }
    }else {
        count = self.secondDataArray.count;
    }
    return count;
}

- (JCCellModel *)findView:(JCFindView *)findView dataFromTag:(NSInteger)tag item:(NSInteger)index {
    JCCellModel *cellM = [JCCellModel new];
    if (findView.tag == 101) {
        if (tag == 0 ) {
            
            if ( index == 0) {
                cellM.cellModelType = JCFindCellModelTypeOther;
            }else {
                cellM  = self.firstData[index - 1];
            }
            
        }else {
            cellM  = self.firstData[index];
        }
       
    }else {
      
    }
    return cellM;
}

- (UIView *)findView:(JCFindView *)findView customCellWithDataFromTag:(NSInteger)tag item:(NSInteger)index {
    if (findView.tag == 101 && tag == 0 && index == 0) {
        return [self creatScrollAndPageControlView];
    }
    return nil;
}

- (CGFloat)findView:(JCFindView *)findView heightForRowTag:(NSInteger)tag item:(NSInteger)index {
    if (findView.tag == 101 && tag == 0 && index == 0) {
        return JCScrollAndPageControlView_Height;
    }
    return 120;
}

- (CGFloat)findView:(JCFindView *)findView heightForHeaderTag:(NSInteger)tag {
    return 0.0;
}

- (UIView *)findView:(JCFindView *)findView viewForHeaderTag:(NSInteger)tag {
    return nil;
}

- (void)findView:(JCFindView *)findView didSelectTag:(NSInteger)tag selectRowAtIndex:(NSInteger)index {
     JCTextController *textController = [[JCTextController alloc]init];
    JCCellModel *cellM = nil;
    if (findView.tag == 101 ) {
        if (tag == 0 && index != 0) {
            cellM = self.firstData[index - 1];
        }else {
            cellM = self.firstData[index];
        }
        textController.text = cellM.articles.articleText;
        [self.navigationController pushViewController:textController animated:YES];
    }else {
        
    }
    
   
}

#pragma mark - set/get

- (JCFindView *)firstView {
    if (!_firstView) {
        NSMutableArray *titles = [NSMutableArray new];
        [titles addObject:@"热门"];
        [titles addObject:@"新上榜"];
        [titles addObject:@"连载"];
        [titles addObject:@"生活家"];
        [titles addObject:@"世间事"];
        [titles addObject:@"@IT"];
        [titles addObject:@"市集"];
        [titles addObject:@"七日热门"];
        [titles addObject:@"三十日热门"];
        _firstView = [[JCFindView alloc]initWithFrame:JCFINDVIEWFRAME_X(0) titles:titles];
        _firstView.dataDelegate = self;
        _firstView.tag = 101;
    }
    return _firstView;
}

- (JCFindView *)secondView {
    if (!_secondView) {
        NSMutableArray *titles = [NSMutableArray new];
        [titles addObject:@"热门"];
        [titles addObject:@"推荐"];
        _secondView = [[JCFindView alloc]initWithFrame:JCFINDVIEWFRAME_X(self.view.width) titles:titles];
        _secondView.dataDelegate = self;
        _secondView.tag = 102;
    }
    return _secondView;
}

- (NSMutableArray *)firstData {
    if (!_firstData) {
        JCAllCellModel *allcell = [JCAllCellModel modelWithJSONName:@"FindJSON"];
        _firstData = allcell.allCellModel;
    }
    return _firstData;
}

- (NSMutableArray *)secondDataArray {
    if (!_secondDataArray) {
        _secondDataArray = [NSMutableArray new];
        NSMutableArray *arr = [NSMutableArray new];
        [arr addObject:@"搜索"];
        [arr addObject:@"啊实打实"];
        [arr addObject:@"捱三顶五"];
        [_secondDataArray addObject:arr];
        arr = [NSMutableArray new];
        [arr addObject:@"恩恩"];
        [arr addObject:@"恩爱"];
        [arr addObject:@"ea问问"];
        [_secondDataArray addObject:arr];
    }
    return _secondDataArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
