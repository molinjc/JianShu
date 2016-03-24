//
//  UINavigationController+Replace.h
//  JianShu
//
//  Created by molin on 16/3/2.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Replace)

/**
 *  替换系统的navigationBar
 *
 *  @param navigationBar 自定义的navigationBar
 */
- (void)replaceNavigationBar:(UINavigationBar *)navigationBar;

@end
