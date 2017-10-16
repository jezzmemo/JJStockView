//
//  ViewController.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import "ViewController.h"
#import "StockView.h"

@interface ViewController ()<StockViewDataSource,StockViewDelegate>

@property(nonatomic,readwrite,strong)StockView* stockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.stockView];
}

#pragma mark - Stock DataSource

- (NSUInteger)countForStockView:(StockView*)stockView{
    return 20;
}

- (UIView*)titleCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"标题";
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIView*)contentCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row{
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
    for (int i = 0; i < 10; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"内容:%d",i];
        label.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:label];
    }
    return bg;
}

#pragma mark - Stock Delegate

- (CGFloat)heightForCell:(StockView*)stockView atRowPath:(NSUInteger)row{
    return 30.0f;
}

- (StockView*)stockView{
    if(_stockView != nil){
        return _stockView;
    }
    _stockView = [StockView new];
    _stockView.dataSource = self;
    _stockView.delegate = self;
    return _stockView;
}


@end
