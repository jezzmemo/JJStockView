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
//左上角的固定不动的View
- (UIView*)headRegularTitle:(JJStockView*)stockView;
//可滑动头部View
- (UIView*)headTitle:(JJStockView*)stockView;
//头部高度
- (CGFloat)heightForHeadTitle:(JJStockView*)stockView;
//内容高度
- (CGFloat)heightForCell:(JJStockView*)stockView atRowPath:(NSUInteger)row;
//点击每行事件
- (void)didSelect:(JJStockView*)stockView atRowPath:(NSUInteger)row;

@end

@protocol StockViewDataSource <NSObject>

@required
//内容的行数
- (NSUInteger)countForStockView:(JJStockView*)stockView;
//内容左边View
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row;
//内容右边可滑动View
- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row;

@end

@interface JJStockView : UIView

@property(nonatomic,readwrite,weak)id<StockViewDataSource> dataSource;

@property(nonatomic,readwrite,weak)id<StockViewDelegate> delegate;

- (void)reloadStockView;

- (void)reloadStockViewFromRow:(NSUInteger)row;

@end
