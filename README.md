[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/JJStockView.svg)](https://img.shields.io/cocoapods/v/JJStockView.svg)
[![Platform](https://img.shields.io/cocoapods/p/JJStockView.svg?style=flat)](http://cocoadocs.org/docsets/JJStockView)
[![Pod License](http://img.shields.io/cocoapods/l/JJStockView.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)

![demo gif](https://github.com/jezzmemo/JJStockView/raw/master/demo.gif)

## JJStockView
模仿股票表格和课程表，左右滑动时，标题部分不动，表头和右边内容一起滑动，上下滑动时，表头不动，所有内容一起上下滑动

## 如何安装

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
    pod 'JJStockView'
end
```

```
$ pod install
```

## 如何使用

基本上和TableView类似，首先必须实现以下DataSource
```objc
@protocol StockViewDataSource <NSObject>

@required
//内容的行数
- (NSUInteger)countForStockView:(JJStockView*)stockView;
//内容左边View
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row;
//内容右边可滑动View
- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row;
@end
```

Delegate的所有实现都是可选的:
```objc
@protocol StockViewDelegate <NSObject>

@optional
//左上角的固定不动的View
- (UIView*)headRegularTitle:(JJStockView*)stockView;
//可滑动头部View
- (UIView*)headTitle:(JJStockView*)stockView;
//头部高度
- (CGFloat)heightForHeadTitle:(JJStockView*)stockView;
//内容高度
- (CGFloat)heightForCell:(JJStockView*)stockView atRowPath:(NSUInteger)row;
//点击每行事件
- (void)didSelect:(JJStockView*)stockView atRowPath:(NSUInteger)row;
@end
```

下面我用一张图来表现每个元素对应的方法:

![code demo](https://raw.githubusercontent.com/jezzmemo/JJStockView/master/demo_code.png)

最后给一个Demo的连接，我就不贴代码了:
[https://github.com/jezzmemo/JJStockView/blob/master/JJStockView/DemoViewController.m](https://github.com/jezzmemo/JJStockView/blob/master/JJStockView/DemoViewController.m)


## 实现原理

* 顶部不变的头部用heightForHeaderInSection显示，用标题和内容两部分组成，内容部分是用UIScrollView作为容器
* 内容部分，用头部类似的结构，cellForRowAtIndexPath实现Cell,分成左右两边部分，左边UIView，右边用UIScrollView作为容器
* 基于以上的结构，在任意一个UIScrollView滑动的时候，头部的UIScrollView和Cell的UIScrollView一起来滚动,代码片段如下:
```objc
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
```