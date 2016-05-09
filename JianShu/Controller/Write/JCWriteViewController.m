//
//  JCWriteViewController.m
//  JianShu
//
//  Created by molin on 16/2/26.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCWriteViewController.h"
#import "JCTextView.h"
#import "JCToolbar.h"
#import "JCMenuView.h"


@interface JCWriteViewController ()<UITextViewDelegate,JCToolbarDelegate,JCMenuViewDelegate>

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *publishButton;

@property (nonatomic, strong) UILabel  *wordsNumberLabel;

@property (nonatomic, strong) JCTextView *titleTextView;

@property (nonatomic, strong) JCTextView *articleTextView;

@property (nonatomic, strong) UIView    *lineView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy) NSString *article;

@property (nonatomic, copy) NSString *titelInterim;

@property (nonatomic, copy) NSString *articleInterim;

@property (nonatomic, strong) JCMenuView *stringStyleMenuView;

@property (nonatomic, strong) JCMenuView *attachmentMenuView;

@end

@implementation JCWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.article = @"";
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.publishButton];
    [self.view addSubview:self.wordsNumberLabel];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleTextView];
    [self.scrollView addSubview:self.lineView];
    [self.scrollView addSubview:self.articleTextView];
    [self.view addSubview:self.stringStyleMenuView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 关闭按钮
    self.closeButton.leftSpacing = 20;
    self.closeButton.topSpacing = 20;
    self.closeButton.toSize(44,44);
    
    // 发布按钮
    self.publishButton.toSize(44,44);
    self.publishButton.rightSpacing = 20;
    self.publishButton.topSpacing = 20;
    
    // 字数Label
    self.wordsNumberLabel.toSize(self.view.width - 128, 44);
    self.wordsNumberLabel.topSpacing = 20;
    self.wordsNumberLabel.centerX = self.view.width * 0.5;
    
    self.scrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height - 64);
    
    // 标题
    self.titleTextView.topSpacing = 0;
    self.titleTextView.leftSpacing = 20;
    self.titleTextView.toSize(self.view.width - 40, 44);
    [self textViewAddToolBar:self.titleTextView];
    [self.titleTextView becomeFirstResponder];
    
    // 横线
    self.lineView.topSpacingByView(self.titleTextView, -8);
    self.lineView.leftSpacingEqulTo(self.titleTextView, 0);
    self.lineView.widthEqulTo(self.titleTextView, 0);
    self.lineView.height = 0.5;
    
    // 文章
    self.articleTextView.topSpacingByView(self.titleTextView,0);
    self.articleTextView.leftSpacing = 20;
    self.articleTextView.toSize(self.view.width - 40, self.scrollView.height - self.titleTextView.height);
    [self textViewAddToolBar:self.articleTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewAddToolBar:(UITextView *)textView {
    
    // 创建UIToolbar
    JCToolbar *toolbar = [[JCToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 44)];
    toolbar.barTintColor = [UIColor whiteColor]; // 设置显示的颜色
    [toolbar setImages:@[[UIImage imageNamed:@"button_write_toolbar_keyboard_down"],
                         [UIImage imageNamed:@"button_write_toolbar_undo"],
                         [UIImage imageNamed:@"button_write_toolbar_redo"],
                         [UIImage imageNamed:@"button_write_toolbar_style"],
                         [UIImage imageNamed:@"button_write_toolbar_add"],
                         [UIImage imageNamed:@"button_write_toolbar_more"]
                         ]];
     toolbar.delegate_JCToolbar = self;
     [textView setInputAccessoryView:toolbar]; // 添加选项
}

- (void)resignKeyboardWithTextView:(UITextView *)textView {
    [textView resignFirstResponder];
}

- (void)stringStyleWithSelectItem:(NSInteger)index state:(BOOL)select {
    switch (index) {
        case 0:
            if (select) {
                self.articleTextView.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            }else {
                self.articleTextView.font = [UIFont systemFontOfSize:16];
            }
            break;
        case 1:
            if (select) {
                self.articleTextView.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16];
            }else {
                self.articleTextView.font = [UIFont systemFontOfSize:16];
            }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 点击事件

- (void)closeAction:(UIButton *)sender {
    [self.titleTextView resignFirstResponder];
    [self.articleTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishAction:(UIButton *)sender {
    JCLog(@"pul");
}

#pragma mark - JCToolbarDelegate

- (void)toolbar:(JCToolbar *)toolbar DidSelectItemAtTag:(NSInteger)tag {
    UITextView *textView = nil;
    BOOL isArticleText = NO;
    if ([toolbar isEqual:self.titleTextView.inputAccessoryView]) {
        textView = self.titleTextView;
    }else {
        textView = self.articleTextView;
        isArticleText = !isArticleText;
    }
    switch (tag) {
        case 0:
            [self resignKeyboardWithTextView:textView];
            break;
        case 1:
            self.stringStyleMenuView.hidden = NO;
            break;
        default:
            break;
    }
}

#pragma mark - JCMenuViewDelegate

- (void)menuView:(JCMenuView *)menuView didSelectItem:(NSInteger)index state:(BOOL)select{
    if ([menuView isEqual:self.stringStyleMenuView]) {
        [self stringStyleWithSelectItem:index state:select];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
//    JCLog(@"1:%@",textView.placeholder);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
//    JCLog(@"2:%@",textView.placeholder);
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView == self.titleTextView) {
        CGSize size = [self.titleTextView.text boundingRectWithSize:CGSizeMake(self.titleTextView.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleTextView.font} context:nil].size;
        if (size.height >= 40) {
            self.titleTextView.height = size.height + 44;
            self.lineView.topSpacingByView(self.titleTextView, - 24);
        }else {
            self.titleTextView.height = 44;
            self.lineView.topSpacingByView(self.titleTextView, - 8);
        }
        self.articleTextView.topSpacingByView(self.titleTextView,0);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.article = [self.article stringByAppendingString:text];
    JCLog(@"self.article:%@",self.article);
    return YES;
}

#pragma mark - set/get

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:JCColor_red_1 forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _publishButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        [_publishButton setTitleColor:JCColor_red_1 forState:UIControlStateNormal];
        [_publishButton addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

- (UILabel *)wordsNumberLabel {
    if (!_wordsNumberLabel) {
        _wordsNumberLabel = [[UILabel alloc] init];
        _wordsNumberLabel.textAlignment = NSTextAlignmentCenter;
        _wordsNumberLabel.textColor = [UIColor grayColor];
        _wordsNumberLabel.font = [UIFont systemFontOfSize:13];
        _wordsNumberLabel.text = @"0字";
    }
    return _wordsNumberLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor greenColor];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (JCTextView *)titleTextView {
    if (!_titleTextView) {
        _titleTextView = [[JCTextView alloc] init];
        _titleTextView.font = [UIFont systemFontOfSize:20];
        _titleTextView.delegate = self;
        _titleTextView.placeholder = @"请输入标题";
    }
    return _titleTextView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

- (JCTextView *)articleTextView {
    if (!_articleTextView) {
        _articleTextView = [[JCTextView alloc] init];
        _articleTextView.font = [UIFont systemFontOfSize:16];
        _articleTextView.delegate = self;
        _articleTextView.placeholder = @"请输入正文";
    }
    return _articleTextView;
}

- (JCMenuView *)stringStyleMenuView {
    if (!_stringStyleMenuView) {
        _stringStyleMenuView = [[JCMenuView alloc] initWithBottom:CGPointMake(self.view.width / 6 * 3 + self.view.width / 6 / 2, self.view.height-300) size:CGSizeMake(320, 44)];
        
        JCMenuItem *item_1 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_b"] selectImage:[UIImage imageNamed:@"button_write_style_b_active"] titile:nil];
        
        JCMenuItem *item_2 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_i"] selectImage:[UIImage imageNamed:@"button_write_style_i_active"] titile:nil];
        
        JCMenuItem *item_3 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_s"] selectImage:[UIImage imageNamed:@"button_write_style_s_active"] titile:nil];
        
        JCMenuItem *item_4 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_quote"] selectImage:[UIImage imageNamed:@"button_write_style_quote_active"] titile:nil];
        
        JCMenuItem *item_5 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_h1"] selectImage:[UIImage imageNamed:@"button_write_style_h1_active"] titile:nil];
        
        JCMenuItem *item_6 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_h2"] selectImage:[UIImage imageNamed:@"button_write_style_h2_active"] titile:nil];
        
        JCMenuItem *item_7 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_h3"] selectImage:[UIImage imageNamed:@"button_write_style_h3_active"] titile:nil];
        
        JCMenuItem *item_8 = [[JCMenuItem alloc] initWithDefaultImage:[UIImage imageNamed:@"button_write_style_h4"] selectImage:[UIImage imageNamed:@"button_write_style_h4_active"] titile:nil];
        
        [_stringStyleMenuView setItems:@[item_1,item_2,item_3,item_4,item_5,item_6,item_7,item_8]];
        _stringStyleMenuView.hidden = YES;
        _stringStyleMenuView.delegate = self;
    }
    return _stringStyleMenuView;
}

@end
