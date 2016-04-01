//
//  JCCellModel.m
//  JianShu
//
//  Created by molin on 16/3/21.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCCellModel.h"

@implementation JCCellModel

- (void)setArticles:(JCArticleCellModel *)articles {
    if ([articles isKindOfClass:[NSDictionary class]]) {
        _articles = [JCArticleCellModel modelWithJSON:articles];
    }else {
        _articles = articles;
    }
}

- (void)setSpecials:(JCSpecialCellModel *)specials {
    if ([specials isKindOfClass:[NSDictionary class]]) {
        _specials = [JCSpecialCellModel modelWithJSON:specials];
    }else {
        _specials = specials;
    }
}

- (void)setDefaults:(JCDefaultCellModel *)defaults {
    if ([defaults isKindOfClass:[NSDictionary class]]) {
        _defaults = [JCDefaultCellModel modelWithJSON:defaults];
    }else {
        _defaults = defaults;
    }
}

@end

@implementation JCAllCellModel

- (void)setAllCellModel:(NSMutableArray *)allCellModel {
    if (allCellModel.count == 0) {
        return;
    }
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in allCellModel) {
        [array addObject:[JCCellModel modelWithJSON:dic]];
    }
    _allCellModel = array;
}

@end

@implementation JCArticleCellModel

@end

@implementation JCSpecialCellModel

@end

@implementation JCDefaultCellModel

@end