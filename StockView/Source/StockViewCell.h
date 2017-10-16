//
//  StockViewCell.h
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 StockView. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *tapCellScrollNotification = @"tapCellScrollNotification";

@interface StockViewCell : UITableViewCell

@property(nonatomic,readonly,strong)UIScrollView* rightContentScrollView;

- (void)setTitleView:(UIView*)titleView;

- (void)setRightContentView:(UIView*)contentView;

@property (nonatomic, assign) BOOL isNotification;

@end
