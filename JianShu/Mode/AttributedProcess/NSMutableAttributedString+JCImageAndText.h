//
//  NSMutableAttributedString+JCImageAndText.h
//  JianShu
//
//  Created by molin on 16/3/24.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (JCImageAndText)

/**
 *  创建NSMutableAttributedString并设置字体
 *
 *  @param text 文本内容 
 *  要想文本里带图片的话，格式要这样：“你好<image name=holle;size={230,220};titel=你好/>吗？”
 *  格式里面的属性可以不带,以<开始，以/>结束，属性以;隔开
 *  
 *  节点:
 *       image:name(必须有),size,titel
 *       link:name(必须有),address(必须有)
 *       font:name,text,size
 *
 *  @return NSMutableAttributedString对象
 */
+ (NSMutableAttributedString *)AttributedStringWithText:(NSString *)text Font:(UIFont *)font;

@end

typedef NS_ENUM(NSInteger, JCTextType){
    JCTextTypeDefault,  // 默认为文本
    JCTextTypeImage,    // 图片
    JCTextTypeLink,      // 链接
    JCTextTypeSetFont    // 设置字体
};

@interface JCTextInfo : NSObject

@property (nonatomic, assign) JCTextType  type;

@property (nonatomic, copy  ) NSString    *text;

// 当type为JCTextTypeImage时，是图片的文件名，当type为JCTextTypeLink时，是在文本显示的字符串
@property (nonatomic, copy  ) NSString    *name;

@property (nonatomic, assign) CGSize      size;// 图片的大小

@property (nonatomic, copy  ) NSString    *titel;

@property (nonatomic, copy  ) NSString    *address;// 链接地址

@property (nonatomic, assign) CGFloat     fontSize;

@property (nonatomic, copy  ) NSString    *fontColor;

@end