//
//  StockView.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 StockView. All rights reserved.
//

#import "StockView.h"
#import "StockViewCell.h"

static NSString* const CellID = @"cellID";

@interface StockView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    
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
    _stockTableView.frame = self.frame;

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
    
    cell.rightContentScrollView.delegate = self;

    if([self.dataSource respondsToSelector:@selector(titleCellForStockView:atRowPath:)]){
        [cell setTitleView:[self.dataSource titleCellForStockView:self atRowPath:indexPath.row]];
    }
    if([self.dataSource respondsToSelector:@selector(contentCellForStockView:atRowPath:)]){
        [cell setRightContentView:[self.dataSource contentCellForStockView:self atRowPath:indexPath.row]];
    }
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.delegate respondsToSelector:@selector(heightForCell:atRowPath:)]){
        return [self.delegate heightForCell:self atRowPath:indexPath.row];
    }
    return 0;
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

#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    if (scrollView == self.stockTableView) {
        NSLog(@"stockTableView");
    }else if(scrollView == self.headScrollView){
        NSLog(@"headScrollView");
    }else{
        [self scrollRightScrollView:scrollView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll");
    if (scrollView == self.stockTableView) {
        NSLog(@"stockTableView");
    }else if(scrollView == self.headScrollView){
        NSLog(@"headScrollView");
    }else{
        [self scrollRightScrollView:scrollView];
    }
}

#pragma mark - Control Scroll

- (void)scrollRightScrollView:(UIScrollView*)sender{
    NSArray* visibleCells = [self.stockTableView visibleCells];
    for (StockViewCell* cell in visibleCells) {
        if (cell.rightContentScrollView != sender) {
            cell.rightContentScrollView.delegate = nil;//disable send scrollViewDidScroll message
            [cell.rightContentScrollView setContentOffset:CGPointMake(sender.contentOffset.x, 0) animated:NO];
            cell.rightContentScrollView.delegate = self;//enable send scrollViewDidScroll message
        }
    }
}

#pragma mark - Property Get

- (UITableView*)stockTableView{
    if(_stockTableView != nil){
        return _stockTableView;
    }
    _stockTableView = [UITableView new];
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
