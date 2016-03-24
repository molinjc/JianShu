//
//  UIColor+JCString.m
//  JianShu
//
//  Created by molin on 16/3/24.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "UIColor+JCString.h"

@implementation UIColor (JCString)

+ (UIColor *)colorWithString:(NSString *)string {
    NSArray *colors = @[@"black",@"darkGray",
                        @"lightGray",@"white",@"gray",
                        @"red",@"green",@"blue",
                        @"cyan",@"yellow",@"magenta",
                        @"orange",@"purple",@"brown",@"clear"];
    NSInteger index = -1;
    for (int i=0; i <colors.count ; i++) {
        if ([string isEqualToString:colors[i]]) {
            index = i;
            break;
        }
    }
    switch (index) {
        case 0:
            return [UIColor blackColor];
        case 1:
            return [UIColor darkGrayColor];
        case 2:
            return [UIColor lightGrayColor];
        case 3:
            return [UIColor whiteColor];
        case 4:
            return [UIColor grayColor];
        case 5:
            return [UIColor redColor];
        case 6:
            return [UIColor greenColor];
        case 7:
            return [UIColor blueColor];
        case 8:
            return [UIColor cyanColor];
        case 9:
            return [UIColor yellowColor];
        case 10:
            return [UIColor magentaColor];
        case 11:
            return [UIColor orangeColor];
        case 12:
            return [UIColor purpleColor];
        case 13:
            return [UIColor brownColor];
        case 14:
            return [UIColor clearColor];
        default:
            break;
    }
    return nil;
}

@end
