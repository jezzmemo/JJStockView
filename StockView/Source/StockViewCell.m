//
//  StockViewCell.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 StockView. All rights reserved.
//

#import "StockViewCell.h"

const static NSInteger TITLE_TAG = 1000;
const static NSInteger CONTENT_TAG = 1001;

@interface StockViewCell()<UIScrollViewDelegate>{
    @private
    UIScrollView* _rightContentScrollView;
}

@end

@implementation StockViewCell

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
    [_rightContentScrollView addSubview:contentView];
    
}

- (void)setupDefaultSettings{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setupView{
    _rightContentScrollView = [UIScrollView new];
    _rightContentScrollView.showsVerticalScrollIndicator = NO;
    _rightContentScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_rightContentScrollView];
}

- (UIScrollView*)rightContentScrollView{
    return _rightContentScrollView;
}

- (void)setTitleView:(UIView*)titleView{
    UIView* view = [self viewWithTag:TITLE_TAG];
    if(view){
        [view removeFromSuperview];
    }
    titleView.tag = TITLE_TAG;
    [self.contentView addSubview:titleView];
    
    UIView* contentView = [self viewWithTag:CONTENT_TAG];
    _rightContentScrollView.frame = CGRectMake(CGRectGetWidth(titleView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetWidth(titleView.frame), CGRectGetHeight(contentView.frame));
}

- (void)setRightContentView:(UIView*)contentView{
    UIView* view = [self viewWithTag:CONTENT_TAG];
    if(view){
        [view removeFromSuperview];
    }
    contentView.tag = CONTENT_TAG;
    UIView* titleView = [self viewWithTag:TITLE_TAG];
    
    _rightContentScrollView.frame = CGRectMake(CGRectGetWidth(titleView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetWidth(titleView.frame), CGRectGetHeight(contentView.frame));
    _rightContentScrollView.contentSize = CGSizeMake(CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame));
    [_rightContentScrollView addSubview:contentView];
    
}

@end
