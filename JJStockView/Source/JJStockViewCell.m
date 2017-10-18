//
//  JJStockViewCell.m
//  JJStockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 StockView. All rights reserved.
//

#import "JJStockViewCell.h"
#import "JJStockScrollView.h"

const static NSInteger TITLE_TAG = 1000;
const static NSInteger CONTENT_TAG = 1001;

@interface JJStockViewCell()<UIScrollViewDelegate>{
    @private
    UIScrollView* _rightContentScrollView;
}

@end

@implementation JJStockViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupDefaultSettings];
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIView* contentView = [self viewWithTag:CONTENT_TAG];
    UIView* titleView = [self viewWithTag:TITLE_TAG];
    
    _rightContentScrollView.frame = CGRectMake(CGRectGetWidth(titleView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetWidth(titleView.frame), CGRectGetHeight(contentView.frame));
    _rightContentScrollView.contentSize = CGSizeMake(CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
    
}

- (void)setupDefaultSettings{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setupView{
    [self.contentView addSubview:self.rightContentScrollView];
}

#pragma mark - Public

- (UIScrollView*)rightContentScrollView{
    if (_rightContentScrollView != nil) {
        return _rightContentScrollView;
    }
    _rightContentScrollView = [JJStockScrollView new];
    _rightContentScrollView.canCancelContentTouches = YES;
    _rightContentScrollView.showsVerticalScrollIndicator = NO;
    _rightContentScrollView.showsHorizontalScrollIndicator = NO;
    return _rightContentScrollView;
}

- (void)setTitleView:(UIView*)titleView{
    UIView* view = [self viewWithTag:TITLE_TAG];
    if(view){
        [view removeFromSuperview];
    }
    titleView.tag = TITLE_TAG;
    [self.contentView addSubview:titleView];
    
    [self setNeedsLayout];
}

- (void)setRightContentView:(UIView*)contentView{
    UIView* view = [_rightContentScrollView viewWithTag:CONTENT_TAG];
    if(view){
        [view removeFromSuperview];
    }
    contentView.tag = CONTENT_TAG;
    [_rightContentScrollView addSubview:contentView];
    
    [self setNeedsLayout];
}


@end
