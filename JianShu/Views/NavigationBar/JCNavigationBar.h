//
//  JCNavigationBar.h
//  JianShu
//
//  Created by molin on 16/2/26.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCNavigationBarDelegate <NSObject>

/**
 *  切换视图
 *
 *  @param sview YES 为第一个; NO 为第二个。 
 */
- (void)switchView:(BOOL)sview;

@end

@interface JCNavigationBar : UINavigationBar

@property (nonatomic, weak) id<JCNavigationBarDelegate> navigationBarDelegate;

@end
