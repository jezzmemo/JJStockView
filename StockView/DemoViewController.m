//
//  ViewController.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import "DemoViewController.h"
#import "StockView.h"

@interface DemoViewController ()<StockViewDataSource,StockViewDelegate>

@property(nonatomic,readwrite,strong)StockView* stockView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"股票表格";
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.stockView];
}

#pragma mark - Stock DataSource

- (NSUInteger)countForStockView:(StockView*)stockView{
    return 30;
}

- (UIView*)titleCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = [NSString stringWithFormat:@"标题:%ld",row];
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIView*)contentCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row{
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
    bg.backgroundColor = row % 2 == 0 ?[UIColor whiteColor] :[UIColor colorWithRed:240.0f/255.0 green:240.0f/255.0 blue:240.0f/255.0 alpha:1.0];
    for (int i = 0; i < 10; i++) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        [button setTitle:[NSString stringWithFormat:@"内容:%d",i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
        [bg addSubview:button];
//        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
//        label.text = [NSString stringWithFormat:@"内容:%d",i];
//        label.textAlignment = NSTextAlignmentCenter;
//        [bg addSubview:label];
    }
    return bg;
}

#pragma mark - Stock Delegate

- (CGFloat)heightForCell:(StockView*)stockView atRowPath:(NSUInteger)row{
    return 30.0f;
}

- (UIView*)headRegularTitle:(StockView*)stockView{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"标题";
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIView*)headTitle:(StockView*)stockView{
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 40)];
    bg.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    for (int i = 0; i < 10; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 40)];
        label.text = [NSString stringWithFormat:@"标题:%d",i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [bg addSubview:label];
    }
    return bg;
}

- (CGFloat)heightForHeadTitle:(StockView*)stockView{
    return 40.0f;
}

- (void)didSelect:(StockView*)stockView atRowPath:(NSUInteger)row{
    NSLog(@"DidSelect Row:%ld",row);
}

#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
    sender.backgroundColor = [UIColor redColor];
}

#pragma mark - Get

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
