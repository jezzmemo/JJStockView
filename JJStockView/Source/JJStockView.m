//
//  JJStockView.m
//  JJStockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 JJStockView. All rights reserved.
//

#import "JJStockView.h"
#import "JJStockViewCell.h"

static NSString* const CellID = @"cellID";

@interface JJStockView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    CGFloat _lastScrollX;//Save scroll x position
}

@property(nonatomic,readwrite,strong)UITableView* stockTableView;
@property(nonatomic,readwrite,strong)UIScrollView* headScrollView;

@end

@implementation JJStockView


#pragma mark - Init/Override

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _lastScrollX = 0;
        [self setupView];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    self.stockTableView.backgroundColor = backgroundColor;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _stockTableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

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
    
    JJStockViewCell* cell = (JJStockViewCell*)[tableView dequeueReusableCellWithIdentifier:CellID];
    
    cell.rightContentScrollView.delegate = self;

    if([self.dataSource respondsToSelector:@selector(titleCellForStockView:atRowPath:)]){
        [cell setTitleView:[self.dataSource titleCellForStockView:self atRowPath:indexPath.row]];
    }
    if([self.dataSource respondsToSelector:@selector(contentCellForStockView:atRowPath:)]){
        [cell setRightContentView:[self.dataSource contentCellForStockView:self atRowPath:indexPath.row]];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [cell.rightContentScrollView addGestureRecognizer:tapGesture];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.delegate respondsToSelector:@selector(heightForCell:atRowPath:)]){
        return [self.delegate heightForCell:self atRowPath:indexPath.row];
    }
    return 0;
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
    
    [headerView addSubview:self.headScrollView];
    
    self.headScrollView.frame = CGRectMake(regularWidth,0,CGRectGetWidth(self.frame) - regularWidth,headHeight);
    
    if([self.delegate respondsToSelector:@selector(headTitle:)]){
        UIView* titleView = [self.delegate headTitle:self];
        [self.headScrollView addSubview:titleView];
        
        self.headScrollView.contentSize = CGSizeMake(CGRectGetWidth(titleView.frame), headHeight);
    }
    
    return headerView;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.stockTableView) {
        [self scrollToLastScrollX];
    }else if(scrollView == self.headScrollView){
        [self linkAgeScrollView:scrollView];
    }else{
        [self linkAgeScrollView:scrollView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.stockTableView) {
        [self scrollToLastScrollX];
    }else if(scrollView == self.headScrollView){
        [self linkAgeScrollView:scrollView];
    }else{
        [self linkAgeScrollView:scrollView];
    }
}

#pragma mark - Control Scroll

- (void)linkAgeScrollView:(UIScrollView*)sender{
    NSArray* visibleCells = [self.stockTableView visibleCells];
    for (JJStockViewCell* cell in visibleCells) {
        if (cell.rightContentScrollView != sender) {
            cell.rightContentScrollView.delegate = nil;//disable send scrollViewDidScroll message
            [cell.rightContentScrollView setContentOffset:CGPointMake(sender.contentOffset.x, 0) animated:NO];
            cell.rightContentScrollView.delegate = self;//enable send scrollViewDidScroll message
        }
    }
    if (sender != self.headScrollView) {
        self.headScrollView.delegate = nil;//disable send scrollViewDidScroll message
        [self.headScrollView setContentOffset:CGPointMake(sender.contentOffset.x, 0) animated:NO];
        self.headScrollView.delegate = self;//enable send scrollViewDidScroll message
    }
    
    _lastScrollX = sender.contentOffset.x;
}

- (void)scrollToLastScrollX{
    NSArray* visibleCells = [self.stockTableView visibleCells];
    for (JJStockViewCell* cell in visibleCells) {
            cell.rightContentScrollView.delegate = nil;//disable send scrollViewDidScroll message
            [cell.rightContentScrollView setContentOffset:CGPointMake(_lastScrollX, 0) animated:NO];
            cell.rightContentScrollView.delegate = self;//enable send scrollViewDidScroll message
    }
    
    self.headScrollView.delegate = nil;//disable send scrollViewDidScroll message
    [self.headScrollView setContentOffset:CGPointMake(_lastScrollX, 0) animated:NO];
    self.headScrollView.delegate = self;//enable send scrollViewDidScroll message
}

#pragma mark - Tap Click

- (void)tapAction:(UITapGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:self.stockTableView];
    NSIndexPath* indexPath = [self.stockTableView indexPathForRowAtPoint:point];
    if (indexPath && [self.delegate respondsToSelector:@selector(didSelect:atRowPath:)]) {
        [self.delegate didSelect:self atRowPath:indexPath.row];
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
    [_stockTableView registerClass:[JJStockViewCell class] forCellReuseIdentifier:CellID];
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
