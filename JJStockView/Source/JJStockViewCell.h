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
 UITableViewCell的右边可滑动的ScrollView,设置成ReadOnly的目标就是对外使用，
 但是rightContentScrollView的生命周期由JJStockViewCell控制,可以设置Delegate，
 这样Cell和Controller之间就不用通讯，所有的UIScrollView事件都由JJStockView统一处理。
 */
@property(nonatomic,readonly,strong)UIScrollView* rightContentScrollView;


/**
 右边内容部分的点击事件Block
 */
@property(nonatomic,readwrite,copy)void (^rightContentTapBlock)(JJStockViewCell* cell);


/**
 设置左边的自定义View
 */
@property(nonatomic,readwrite,strong)UIView* titleView;

/**
 设置右边可以滑动自定义View
 */
@property(nonatomic,readwrite,strong)UIView* rightContentView;

@end
