![demo gif](https://github.com/jezzmemo/StockView/raw/master/demo.gif)

## 如何安装

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
    pod 'StockView'
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
- (NSUInteger)countForStockView:(StockView*)stockView;
//内容左边的标题View
- (UIView*)titleCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row;
//内容右边可滑动View
- (UIView*)contentCellForStockView:(StockView*)stockView atRowPath:(NSUInteger)row;

@end
```

Delegate的所有实现都是可选的:
```objc
@protocol StockViewDelegate <NSObject>

@optional
//左上角的固定不动的View
- (UIView*)headRegularTitle:(StockView*)stockView;
//可滑动头部View
- (UIView*)headTitle:(StockView*)stockView;
//头部高度
- (CGFloat)heightForHeadTitle:(StockView*)stockView;
//内容高度
- (CGFloat)heightForCell:(StockView*)stockView atRowPath:(NSUInteger)row;
//点击每行事件
- (void)didSelect:(StockView*)stockView atRowPath:(NSUInteger)row;

@end
```

下面我用一张图来表现每个元素对应的方法:

![code demo](https://raw.githubusercontent.com/jezzmemo/StockView/master/demo_code.png)

最后给一个Demo的连接，我就不贴代码了:
[https://github.com/jezzmemo/StockView/blob/master/StockView/DemoViewController.m](https://github.com/jezzmemo/StockView/blob/master/StockView/DemoViewController.m)


## 实现原理

* 顶部不变的头部用heightForHeaderInSection显示，用标题和内容两部分组成，内容部分是用UIScrollView作为容器
* 内容部分，用头部类似的结构，cellForRowAtIndexPath实现Cell,分成左右两边部分，左边Label，右边用UIScrollView作为容器
* 基于以上的结构，在任意一个UIScrollView滑动的时候，头部的UIScrollView和Cell的UIScrollView一起来滚动,代码片段如下:
```objc
- (void)linkAgeScrollView:(UIScrollView*)sender{
    NSArray* visibleCells = [self.stockTableView visibleCells];
    for (StockViewCell* cell in visibleCells) {
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