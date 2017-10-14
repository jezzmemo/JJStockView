//
//  StockView.h
//  HJ
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockView;

@protocol StockViewDelegate <NSObject>

@optional

- (UIView*)headRegularTitle:(StockView*)stockView;

- (UIView*)headTitle:(StockView*)stockView;

- (CGFloat)heightForHeadTitle:(StockView*)stockView;
- (CGFloat)heightForCell:(StockView*)stockView atRowPath:(NSUInteger)row;

- (void)didSelect:(StockView*)stockView atRowPath:(NSUInteger)row;

@end

@protocol StockViewDataSource <NSObject>

@required

- (NSUInteger)countForStockView:(StockView*)stockView;

- (UIView*)titleCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row;

- (UIView*)contentCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row;

@end

@interface StockView : UIView

@property(nonatomic,readwrite,weak)id<StockViewDataSource> dataSource;

@property(nonatomic,readwrite,weak)id<StockViewDelegate> delegate;

- (void)reloadStockView;

- (void)reloadStockViewFromRow:(NSUInteger)row;

@end
