//
//  StockScrollView.m
//  StockView
//
//  Created by Jezz on 2017/10/17.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import "JJStockScrollView.h"

@implementation JJStockScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
