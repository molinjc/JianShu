//
//  UINavigationController+Replace.m
//  JianShu
//
//  Created by molin on 16/3/2.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "UIViewController+Replace.h"

@implementation UIViewController (Replace)

/**
 *  替换系统的navigationBar
 *
 *  @param navigationBar 自定义的navigationBar
 */
- (void)replaceNavigationBar:(UINavigationBar *)navigationBar {
    if ([NSStringFromClass(self.class) isEqualToString:@"JCFindNavigationController"]) {
        [self setValue:navigationBar forKey:@"navigationBar"];
    }else {
        [self.navigationController setValue:navigationBar forKey:@"navigationBar"];
    }
    
}


@end
