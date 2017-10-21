//
//  JJStockViewCell.m
//  JJStockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 StockView. All rights reserved.
//

#import "JJStockViewCell.h"
#import "JJStockScrollView.h"

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
    
    self.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.titleView.frame), CGRectGetHeight(self.titleView.frame));
    
    id tempDelegate = _rightContentScrollView.delegate;
    _rightContentScrollView.delegate = nil;//Do not send delegate message
    
    _rightContentScrollView.frame = CGRectMake(CGRectGetWidth(self.titleView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetWidth(self.titleView.frame), CGRectGetHeight(self.rightContentView.frame));
    _rightContentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.rightContentView.frame), CGRectGetHeight(self.rightContentView.frame));
    
    _rightContentScrollView.delegate = tempDelegate;//Restore deleagte
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
    if(_titleView){
        [_titleView removeFromSuperview];
    }
    [self.contentView addSubview:titleView];
    
    _titleView = titleView;
        
    [self setNeedsLayout];
}

- (void)setRightContentView:(UIView*)contentView{
    if(_rightContentView){
        [_rightContentView removeFromSuperview];
    }
    [_rightContentScrollView addSubview:contentView];
    
    _rightContentView = contentView;
    
    [self setNeedsLayout];
}


@end
