//
//  UIColor+JCString.h
//  JianShu
//
//  Created by molin on 16/3/24.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JCString)

/**
 *  根据字符串创建UIColor
 *
 *  @param string 字符串
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithString:(NSString *)string;

@end
