//
//  StockViewCell.m
//  HJ
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 HJ. All rights reserved.
//

#import "StockViewCell.h"

@interface StockViewCell()<UIScrollViewDelegate>

@end

@implementation StockViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIScrollView*)rightContentScrollView{
    return nil;
//    if(self.rightContentScrollView != nil){
//        return _rightContentScrollView;
//    }
//    _rightContentScrollView.showsVerticalScrollIndicator = NO;
//    _rightContentScrollView.showsHorizontalScrollIndicator = NO;
//    return _rightContentScrollView;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
