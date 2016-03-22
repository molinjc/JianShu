//
//  JCOptionNavigationBar.h
//  JianShu
//
//  Created by molin on 16/3/3.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCOptionNavigationBarDelegate <NSObject>

- (void)selectedAction;

@end

@interface JCOptionNavigationBar : UINavigationBar

@property (nonatomic, weak) id<JCOptionNavigationBarDelegate> optionDelegate;

@property (nonatomic, copy) NSString *optionTitle;

@end
