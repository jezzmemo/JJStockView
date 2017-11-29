//
//  JJStockView.h
//  JJStockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 JJStockView. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJStockView;

@protocol StockViewDelegate <NSObject>

@optional

/**
 左上角的固定不动的自定义View

 @param stockView JJStockView
 @return 自定义View
 */
- (UIView*)headRegularTitle:(JJStockView*)stockView;

/**
 可滑动头部View

 @param stockView JJStockView
 @return 自定义View
 */
- (UIView*)headTitle:(JJStockView*)stockView;

/**
 头部高度，headRegularTitle，headTitle共用这个高度
 保持头部的高度一致

 @param stockView JJStockView
 @return 返回指定高度
 */
- (CGFloat)heightForHeadTitle:(JJStockView*)stockView;

/**
 内容部分高度，左边和右边共用这个高度

 @param stockView JJStockView
 @param row 当前行的索引值
 @return 返回指定高度
 */
- (CGFloat)heightForCell:(JJStockView*)stockView atRowPath:(NSUInteger)row;

/**
 点击行事件

 @param stockView JJStockView
 @param row 当前行的索引值
 */
- (void)didSelect:(JJStockView*)stockView atRowPath:(NSUInteger)row;

@end

@protocol StockViewDataSource <NSObject>

@required

/**
 控件内容的总行数

 @param stockView JJStockView
 @return 总行数
 */
- (NSUInteger)countForStockView:(JJStockView*)stockView;

/**
 内容左边自定义View

 @param stockView JJStockView
 @param row 当前行的索引值
 @return 返回自定义View
 */
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row;

/**
 内容右边可滑动自定义View

 @param stockView JJStockView
 @param row 当前行的索引值
 @return 返回自定义View
 */
- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row;

@end

@interface JJStockView : UIView

/**
 使用JJStockView必须全部实现，才能正常使用
 */
@property(nonatomic,readwrite,weak)id<StockViewDataSource> dataSource;

/**
 一些可选的方法，头部，点击事件等等
 */
@property(nonatomic,readwrite,weak)id<StockViewDelegate> delegate;


/**
 具体实现的UITableView，只读，千万不能设置他的Delegate和Datasource,
 如果设置了，这个控件将不能正常工作
 */
@property(nonatomic,readonly,weak)UITableView* jjStockTableView;


/**
 刷新当前控件所有元素
 */
- (void)reloadStockView;


/**
 刷新指定的行的样式

 @param row 指定行的索引值
 */
- (void)reloadStockViewFromRow:(NSUInteger)row;

/**
 滚动到指定行，默认的位置是:UITableViewScrollPositionTop
 动画:NO

 @param row 指定行的索引值
 */
- (void)scrollStockViewToRow:(NSUInteger)row;

@end
