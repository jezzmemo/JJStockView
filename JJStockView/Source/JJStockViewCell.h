//
//  JJStockViewCell.h
//  JJStockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 StockView. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJStockViewCell : UITableViewCell


/**
 UITableViewCell的右边可滑动的ScrollView
 */
@property(nonatomic,readonly,strong)UIScrollView* rightContentScrollView;


/**
 设置左边的自定义View

 @param titleView 自定义View
 */
- (void)setTitleView:(UIView*)titleView;

/**
 设置右边可以滑动自定义View
 
 @param contentView 自定义View
 */
- (void)setRightContentView:(UIView*)contentView;

@end
