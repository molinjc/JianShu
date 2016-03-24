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
#import "NSObject+JCJSON.h"

#define ButtonsView_Height   35.0
#define Button_Width         90.0
#define NavigationBar_Height 64.0

@interface JCFindViewController ()<JCFindViewDataDelegate>

@property (nonatomic, strong) NSMutableArray *firstDataArray;

@property (nonatomic, strong) NSMutableArray *secondDataArray;

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
    [images addObject:@"advertisement_1"];
    [images addObject:@"advertisement_2"];
    [images addObject:@"advertisement_3"];
    [images addObject:@"advertisement_4"];
    [images addObject:@"advertisement_5"];
    
    
    JCScrollAndPageControlView *sapv = [[JCScrollAndPageControlView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 380) images:images];
    return sapv;
}

#pragma mark - JCFindViewDataDelegate

- (NSInteger)findView:(JCFindView *)findView numberDataFromTag:(NSInteger)tag {
    
    NSMutableArray *data = nil;
    if (findView.tag == 101) {
        data = self.firstDataArray[tag];
    }else {
        data = self.secondDataArray[tag];
    }
    if (!data) {
        return 0;
    }
    return data.count;
}

- (id)findView:(JCFindView *)findView dataFromTag:(NSInteger)tag item:(NSInteger)index {
    NSMutableArray *data = nil;
    if (findView.tag == 101) {
        data = self.firstDataArray[tag];
    }else {
        data = self.secondDataArray[tag];
    }
    if (!data) {
        return @"";
    }
    return data[index];
}

- (CGFloat)findView:(JCFindView *)findView heightForHeaderTag:(NSInteger)tag {
    if (findView.tag == 101) {
        if (tag == 0) {
            return 0.0;
        }
        return 0.0;
    }else {
        if (tag == 0) {
            return 50.0;
        }
        return 0.0;
    }
}

- (UIView *)findView:(JCFindView *)findView viewForHeaderTag:(NSInteger)tag {
    if (findView.tag == 101) {
        if (tag == 0) {
            return [self creatScrollAndPageControlView];
        }
        return nil;
    }else {
        if (tag == 0) {
            return nil;
        }
        return nil;
    }
}

- (void)findView:(JCFindView *)findView didSelectTag:(NSInteger)tag selectRowAtIndex:(NSInteger)index {
    JCTextController *textController = [[JCTextController alloc]init];
    NSString *ss = @"我看你啥肯定会哭敬爱上课的骄傲\n<font color=red;text=红色的几个字;size=50/>\n和数据库等哈说看见的哈萨克接电话 \n<image name=222;titel=头像/>\n肯德基十分大好时机开发和会计师的回复你心脏病铲门男<link name=链接哦！;address=http://blog.csdn.net/reylen/article/details/18958995/>djfhkshdf按实际的贺卡寄售点卡就爱上的空间哈就收到货就卡上的金卡圣诞节卡刷卡的交换机的收费比你先把草泥马心脏病草泥马我看你啥肯定会哭敬爱上课的骄傲\n<font color=red;text=红色的几个字;size=50/>\n和数据库等哈说看见的哈萨克接电话 \n<image name=222;titel=头像/>\n肯德基十分大好时机开发和会计师的回复你心脏病铲门男<link name=链接哦！;address=http://blog.csdn.net/reylen/article/details/18958995/>djfhkshdf按实际的贺卡寄售点卡就爱上的空间哈就收到货就卡上的金卡圣诞节卡刷卡的交换机的收费比你先把草泥马心脏病草泥马我看你啥肯定会哭敬爱上课的骄傲\n<font color=red;text=红色的几个字;size=50/>\n和数据库等哈说看见的哈萨克接电话 \n<image name=222;titel=头像/>\n肯德基十分大好时机开发和会计师的回复你心脏病铲门男<link name=链接哦！;address=http://blog.csdn.net/reylen/article/details/18958995/>djfhkshdf按实际的贺卡寄售点卡就爱上的空间哈就收到货就卡上的金卡圣诞节卡刷卡的交换机的收费比你先把草泥马心脏病草泥马我看你啥肯定会哭敬爱上课的骄傲\n<font color=red;text=红色的几个字;size=50/>\n和数据库等哈说看见的哈萨克接电话 \n<image name=222;titel=头像/>\n肯德基十分大好时机开发和会计师的回复你心脏病铲门男<link name=链接哦！;address=http://blog.csdn.net/reylen/article/details/18958995/>djfhkshdf按实际的贺卡寄售点卡就爱上的空间哈就收到货就卡上的金卡圣诞节卡刷卡的交换机的收费比你先把草泥马心脏病草泥马我看你啥肯定会哭敬爱上课的骄傲\n<font color=red;text=红色的几个字;size=50/>\n和数据库等哈说看见的哈萨克接电话 \n<image name=222;titel=头像/>\n肯德基十分大好时机开发和会计师的回复你心脏病铲门男<link name=链接哦！;address=http://blog.csdn.net/reylen/article/details/18958995/>djfhkshdf按实际的贺卡寄售点卡就爱上的空间哈就收到货就卡上的金卡圣诞节卡刷卡的交换机的收费比你先把草泥马心脏病草泥马我看你啥肯定会哭敬爱上课的骄傲\n<font color=red;text=红色的几个字;size=50/>\n和数据库等哈说看见的哈萨克接电话 \n<image name=222;titel=头像/>\n肯德基十分大好时机开发和会计师的回复你心脏病铲门男<link name=链接哦！;address=http://blog.csdn.net/reylen/article/details/18958995/>djfhkshdf按实际的贺卡寄售点卡就爱上的空间哈就收到货就卡上的金卡圣诞节卡刷卡的交换机的收费比你先把草泥马心脏病草泥马";
    textController.text = ss;
    [self.navigationController pushViewController:textController animated:YES];
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
        _firstView = [[JCFindView alloc]initWithFrame:CGRectMake(0, NavigationBar_Height, self.view.width, self.view.height - NavigationBar_Height) titles:titles];
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
        _secondView = [[JCFindView alloc]initWithFrame:CGRectMake(self.view.width, NavigationBar_Height, self.view.width, self.view.height - NavigationBar_Height) titles:titles];
        _secondView.dataDelegate = self;
        _secondView.tag = 102;
    }
    return _secondView;
}

- (NSMutableArray *)firstDataArray {
    if (!_firstDataArray) {
        _firstDataArray = [NSMutableArray new];
        for (int i=0; i<9; i++) {
            NSMutableArray *arr = [NSMutableArray new];
            for (int j=0; j<9; j++) {
                [arr addObject:[NSString stringWithFormat:@"%d",j]];
            }
            [_firstDataArray addObject:arr];
        }
    }
    return _firstDataArray;
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
