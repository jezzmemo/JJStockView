//
//  StockView.m
//  HJ
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 HJ. All rights reserved.
//

#import "StockView.h"
#import "StockViewCell.h"

static NSString* const CellID = @"cellID";

@interface StockView()<UITableViewDelegate,UITableViewDataSource>{
    
}

@property(nonatomic,readwrite,strong)UITableView* stockTableView;
@property(nonatomic,readwrite,strong)UIScrollView* headScrollView;

@end

@implementation StockView


#pragma mark - Init/Override

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - Setup

- (void)setupView{
    [self addSubview:self.stockTableView];
}

#pragma mark - Reload

- (void)reloadStockView{
    [self.stockTableView reloadData];
}

- (void)reloadStockViewFromRow:(NSUInteger)row{
    [self.stockTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSParameterAssert(self.dataSource);
    
    StockViewCell* cell = (StockViewCell*)[tableView dequeueReusableCellWithIdentifier:CellID];

    if([self.dataSource respondsToSelector:@selector(titleCellForStockView:atRowPath:)]){
        [cell.contentView addSubview:[self.dataSource titleCellForStockView:self atRowPath:indexPath.row]];
    }
    if([self.dataSource respondsToSelector:@selector(contentCellForStockView:atRowPath:)]){
        [cell.contentView addSubview:[self.dataSource contentCellForStockView:self atRowPath:indexPath.row]];
    }
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSParameterAssert(self.dataSource);
    
    if([self.dataSource respondsToSelector:@selector(countForStockView:)]){
        return [self.dataSource countForStockView:self];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([self.delegate respondsToSelector:@selector(heightForHeadTitle:)]){
        return [self.delegate heightForHeadTitle:self];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat regularWidth = 0.0f;
    CGFloat headHeight = 0.0f;
    
    if([self.delegate respondsToSelector:@selector(headRegularTitle:)]){
        UIView* regularView = [self.delegate headRegularTitle:self];
        [headerView addSubview:regularView];
        
        regularWidth = CGRectGetWidth(regularView.frame);
    }
    
    if([self.delegate respondsToSelector:@selector(heightForHeadTitle:)]){
        headHeight =  [self.delegate heightForHeadTitle:self];
    }
    
    self.headScrollView.frame = CGRectMake(regularWidth,0,CGRectGetWidth(self.frame) - regularWidth,headHeight);
    
    if([self.delegate respondsToSelector:@selector(headTitle:)]){
        UIView* titleView = [self.delegate headTitle:self];
        [self.headScrollView addSubview:titleView];
        
        self.headScrollView.contentSize = CGSizeMake(CGRectGetWidth(titleView.frame), headHeight);
    }
    
    return headerView;
}

- (UITableView*)stockTableView{
    if(_stockTableView != nil){
        return _stockTableView;
    }
    _stockTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    _stockTableView.dataSource = self;
    _stockTableView.delegate = self;
    _stockTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_stockTableView registerClass:[StockViewCell class] forCellReuseIdentifier:CellID];
    return _stockTableView;
}

- (UIScrollView*)headScrollView{
    if(_headScrollView != nil){
        return _headScrollView;
    }
    _headScrollView = [UIScrollView new];
    _headScrollView.showsVerticalScrollIndicator = NO;
    _headScrollView.showsHorizontalScrollIndicator = NO;
    _headScrollView.delegate = self;
    return _headScrollView;
}

@end
