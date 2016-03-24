//
//  NSMutableAttributedString+JCImageAndText.m
//  JianShu
//
//  Created by molin on 16/3/24.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "NSMutableAttributedString+JCImageAndText.h"
#import "UIColor+JCString.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#define  NODE_START        @"<"
#define  NODE_END          @"/>"
#define  NODE_COMMON_NAME  @"name"
#define  NODE_COMMON_SIZE  @"size"
#define  NODE_COMMON_TEXT  @"text"

#define  NODE_IMAGE        @"image"
#define  NODE_IMAGE_TITEL  @"titel"

#define  NODE_LINK         @"link"
#define  NODE_LINK_ADDRESS @"address"

#define  NODE_FONT         @"font"
#define  NODE_FONT_COLOR   @"color"


@implementation NSMutableAttributedString (JCImageAndText)

+ (NSMutableAttributedString *)AttributedStringWithText:(NSString *)text Font:(UIFont *)font {
    NSMutableArray *array = [NSMutableArray new];
    [self separateWithText:text storageToArray:array];
    NSMutableAttributedString *attributedString = [self AttributedStringWithJCTextInfo:array font:font];
    return attributedString;
}

/**
 *  根据数组（全部包含JCTextInfo对象）来创建NSMutableAttributedString
 *
 *  @param array 数组（全部包含JCTextInfo对象）
 *
 *  @return NSMutableAttributedString的对象
 */
+ (NSMutableAttributedString *)AttributedStringWithJCTextInfo:(NSMutableArray *)array font:(UIFont *)font {
    NSMutableAttributedString *attributesString = [[NSMutableAttributedString alloc]init];

    // 遍历
    for (JCTextInfo *info in array) {
        // 判断类型
        if (info.type == JCTextTypeDefault) {
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:info.text];
            [attString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, attString.length)];
            [attributesString appendAttributedString:attString];
        }else if (info.type == JCTextTypeImage) {
            
            // 创建一个文本附件
            NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
            attachment.image = [UIImage imageNamed:info.name];
            attachment.bounds = CGRectMake(0, 0, info.size.width, info.size.height);
            NSMutableAttributedString *attImage = [[NSMutableAttributedString alloc]initWithString:@"\n"];
            [attImage appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
            
            // 创建标题，加下划线
            if (info.titel.length) {
                NSMutableAttributedString *attImageTitel = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@\n",info.titel]];
                NSDictionary *dic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineColorAttributeName:[UIColor grayColor],NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-BookIt" size:15]};  // 字体暂没有实现斜体
                [attImageTitel addAttributes:dic range:NSMakeRange(0, attImageTitel.string.length)];
                [attImage appendAttributedString:attImageTitel];
            }
    
            // 文本段落格式 将图片和标题居中
            NSMutableParagraphStyle *paragraphStyleImage = [[NSMutableParagraphStyle alloc]init];
            paragraphStyleImage.alignment = NSTextAlignmentCenter;
            paragraphStyleImage.paragraphSpacingBefore = 5.0; // 首段的间距
            paragraphStyleImage.paragraphSpacing = 3.0;       // 段与段的间距
            [attImage addAttribute:NSParagraphStyleAttributeName value:paragraphStyleImage range:NSMakeRange(0, attImage.string.length)];
            
            [attributesString appendAttributedString:attImage];
            
        }else if (info.type == JCTextTypeLink) {
            NSMutableAttributedString *attLink = [[NSMutableAttributedString alloc]initWithString:info.name];
            
            // NSLinkAttributeName表示链接，value就是链接地址
            [attLink addAttribute:NSLinkAttributeName value:info.address range:NSMakeRange(0, info.name.length)];
            [attributesString appendAttributedString:attLink];
        }else if (info.type == JCTextTypeSetFont) {
            NSMutableAttributedString *attFont = [[NSMutableAttributedString alloc]initWithString:info.text];
            NSMutableDictionary *mDic = [NSMutableDictionary new];
            if (info.name.length) {
                [mDic addEntriesFromDictionary:info.fontSize?@{NSFontAttributeName:[UIFont fontWithName:info.name size:info.fontSize]}:@{NSFontAttributeName:[UIFont systemFontOfSize:info.fontSize]}];
            }else if (info.fontSize) {
                [mDic addEntriesFromDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:info.fontSize]}];
            }
            
            if (info.fontColor.length) {
                [mDic addEntriesFromDictionary:@{NSForegroundColorAttributeName:[UIColor colorWithString:info.fontColor]}];
            }
            [attFont addAttributes:mDic range:NSMakeRange(0, attFont.string.length)];
            [attributesString appendAttributedString:attFont];
        }
    }
    return attributesString;
}

/**
 *  分离出字符和图片等，将这些信息存储到数组
 *
 *  @param text  文本
 *  @param array 数组（存储所有的信息）
 */
+ (void)separateWithText:(NSString *)text storageToArray:(NSMutableArray *)array {
    
    // 查找节点的位置
    NSRange nodeStartRange = [text rangeOfString:NODE_START];
    NSRange nodeEndRange = [text rangeOfString:NODE_END];
    
    // 同时找到节点的开始和结束，才算完成
    if (nodeStartRange.length && nodeEndRange.length) {
        
        // 截取节点开始之前的字符串
        NSString *nodeStartBeforeString = [text substringToIndex:nodeStartRange.location];
        
        if (nodeStartBeforeString.length) {
            
            // 节点开始之前的字符串存储到文本信息类
            JCTextInfo *textInfo = [JCTextInfo new];
            textInfo.type = JCTextTypeDefault;
            textInfo.text = nodeStartBeforeString;
            [array addObject:textInfo];
        }
        
        // 截取节点内的字符串
        NSRange nodeRange = NSMakeRange(nodeStartRange.location + 1, nodeEndRange.location  - nodeStartRange.location - 1);
        NSString *nodeString = [text substringWithRange:nodeRange];
        
        if (nodeString.length) {
            JCTextInfo *textInfo = [JCTextInfo new];
            
            NSRange imageRange = [nodeString rangeOfString:NODE_IMAGE];
            NSRange linkRange = [nodeString rangeOfString:NODE_LINK];
            NSRange fontRange = [nodeString rangeOfString:NODE_FONT];
            
            // 判断是什么节点
            if (imageRange.length) {
                textInfo.type = JCTextTypeImage;
            }else if (linkRange.length) {
                textInfo.type = JCTextTypeLink;
            }else if (fontRange.length) {
                textInfo.type = JCTextTypeSetFont;
            }
            [self separateWithNode:nodeString storageToTextInfo:textInfo];
            [array addObject:textInfo];
        }
        
        // 截取节点之后的字符串
        NSString *imageEndAfterString = [text substringFromIndex:nodeEndRange.location + 2];
        
        // 递归
        [self separateWithText:imageEndAfterString storageToArray:array];
    }else {  // 没有节点，都是字符串
        JCTextInfo *textInfo = [JCTextInfo new];
        textInfo.text = text;
        [array addObject:textInfo];
    }
}

/**
 *  分离字符串中的节点属性
 *
 *  @param node 节点（字符串）
 *  @param info 文本信息
 */
+ (void)separateWithNode:(NSString *)node storageToTextInfo:(JCTextInfo *)info {
    NSArray *attributes = [node componentsSeparatedByString:@";"];
    if (attributes.count) {
        for (NSString *str in attributes) {
            NSRange sizeRange    = [str rangeOfString:NODE_COMMON_SIZE];
            NSRange nameRange    = [str rangeOfString:NODE_COMMON_NAME];
            NSRange titelRange   = [str rangeOfString:NODE_IMAGE_TITEL];
            NSRange addressRange = [str rangeOfString:NODE_LINK_ADDRESS];
            NSRange colorRange   = [str rangeOfString:NODE_FONT_COLOR];
            NSRange textRange    = [str rangeOfString:NODE_COMMON_TEXT];
            NSRange signRange    = [str rangeOfString:@"="];
            
            if (signRange.length && nameRange.length) {
                info.name = [str substringWithRange:NSMakeRange(signRange.location+1, str.length-signRange.location-1)];
            }
            
            if (signRange.length && sizeRange.length) {
                NSString *sizeString = [str substringWithRange:NSMakeRange(signRange.location+1, str.length-signRange.location-1)];
                if (info.type == JCTextTypeSetFont) {
                    info.fontSize = [sizeString floatValue];
                }else {
                    info.size = CGSizeFromString(sizeString);
                }
            }
            
            if (signRange.length && titelRange.length) {
                info.titel = [str substringWithRange:NSMakeRange(signRange.location+1, str.length-signRange.location-1)];
            }
            
            if (signRange.length && addressRange.length) {
                info.address = [str substringWithRange:NSMakeRange(signRange.location+1, str.length-signRange.location-1)];
            }
            
            if (signRange.length && colorRange.length) {
                info.fontColor = [str substringWithRange:NSMakeRange(signRange.location+1, str.length-signRange.location-1)];
            }
            
            if (signRange.length && textRange.length) {
                info.text = [str substringWithRange:NSMakeRange(signRange.location+1, str.length-signRange.location-1)];
            }
        }
    }
}

@end

@implementation JCTextInfo

@end
