//
//  JCCellModel.h
//  JianShu
//
//  Created by molin on 16/3/21.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+JCJSON.h"

typedef NS_ENUM(NSInteger, JCFindCellModelType){
    JCFindCellModelTypeOther  = 0,
    JCFindCellModelTypedefault,
    JCFindCellModelTypeArticle,
    JCFindCellModelTypeSpecial
};

@class JCArticleCellModel;
@class JCSpecialCellModel;
@class JCDefaultCellModel;

@interface JCCellModel : NSObject

@property (nonatomic, assign) JCFindCellModelType cellModelType;

@property (nonatomic, strong) JCArticleCellModel *articles;

@property (nonatomic, strong) JCSpecialCellModel *specials;

@property (nonatomic, strong) JCDefaultCellModel *defaults;

@end

@interface JCAllCellModel : NSObject

@property (nonatomic, strong) NSMutableArray *allCellModel;

@end

/**
 *  文章
 */
@interface JCArticleCellModel : NSObject

@property (nonatomic, copy) NSString *headPortrait;// 头像

@property (nonatomic, copy) NSString *userName;    // 用户名

@property (nonatomic, copy) NSString *time;        // 发表时间

@property (nonatomic, copy) NSString *article;     // 文章名

@property (nonatomic, copy) NSString *special;     // 专题

@property (nonatomic, copy) NSString *reading;     // 阅读量

@property (nonatomic, copy) NSString *comments;    // 评论量

@property (nonatomic, copy) NSString *likes;       // 喜欢量

@property (nonatomic, copy) NSString *articleImage;// 文章内的图片

@property (nonatomic, copy) NSString *articleText; // 文章内容

@end

/**
 *  专题
 */
@interface JCSpecialCellModel : NSObject

@property (nonatomic, copy) NSString *headPortrait;

@property (nonatomic, copy) NSString *special;

@property (nonatomic, copy) NSString *articles;

@property (nonatomic, copy) NSString *follows;

@property (nonatomic, copy) NSString *introduce;

@end

/**
 *  默认
 */
@interface JCDefaultCellModel : NSObject

@property (nonatomic, copy  ) NSString  *headPortrait;

@property (nonatomic, copy  ) NSString  *title;

@property (nonatomic, copy  ) NSString  *details;

@property (nonatomic, assign) NSInteger number;

@end