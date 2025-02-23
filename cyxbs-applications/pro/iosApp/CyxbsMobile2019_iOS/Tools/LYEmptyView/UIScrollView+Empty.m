//
//  UIScrollView+Empty.m
//  LYEmptyViewDemo
//
//  Created by 李阳 on 2017/5/26.
//  Copyright © 2017年 liyang. All rights reserved.
//

#import "UIScrollView+Empty.h"
#import <objc/runtime.h>
#import "LYEmptyView.h"

@implementation NSObject (MJRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

@end

@implementation UIScrollView (Empty)

#pragma mark - Setter/Getter

static char kEmptyViewKey;
- (void)setLy_emptyView:(LYEmptyView *)ly_emptyView{
    if (ly_emptyView != self.ly_emptyView) {
        
        objc_setAssociatedObject(self, &kEmptyViewKey, ly_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[LYEmptyView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.ly_emptyView];
    }
}
- (LYEmptyView *)ly_emptyView{
    return  objc_getAssociatedObject(self, &kEmptyViewKey);
}

#pragma mark - Private Method
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet{
    //没有设置emptyView的，直接返回
    if (!self.ly_emptyView) {
        return;
    }
    
    if ([self totalDataCount] == 0) {
        [self show];
    }else{
        [self hide];
    }
}

- (void)show{
    
    //当不自动显隐时，内部自动调用show方法时也不要去显示，要显示的话只有手动去调用 ly_showEmptyView
    if (!self.ly_emptyView.autoShowEmptyView) {
        self.ly_emptyView.hidden = YES;
        return;
    }
    
    [self ly_showEmptyView];
}
- (void)hide{
    
    if (!self.ly_emptyView.autoShowEmptyView) {
        self.ly_emptyView.hidden = YES;
        return;
    }
    
    [self ly_hideEmptyView];
}

#pragma mark - Public Method
- (void)ly_showEmptyView{
    
    [self.ly_emptyView.superview layoutSubviews];
    
    self.ly_emptyView.hidden = NO;
    //让 emptyBGView 始终保持在最上层
    [self bringSubviewToFront:self.ly_emptyView];
}
- (void)ly_hideEmptyView{
    self.ly_emptyView.hidden = YES;
}

- (void)ly_startLoading{
    self.ly_emptyView.hidden = YES;
}
- (void)ly_endLoading{
    if ([self totalDataCount] == 0) {
        self.ly_emptyView.hidden = NO;
    }else{
        self.ly_emptyView.hidden = YES;
    }
}

- (void)showNoDataStatusWithOffset:(CGFloat)offset {
    
    self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"ft_img_wsj" titleStr:@"暂无数据" detailStr:@""];
    self.ly_emptyView.contentViewOffset = offset;
    [self ly_showEmptyView];
    
}
- (void)showNoDataStatusWithString:(NSString *)str  withOfffset:(CGFloat)offset{
    
    self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"ft_img_wsj" titleStr:str detailStr:@""];
    self.ly_emptyView.contentViewOffset = offset;
    [self ly_showEmptyView];
    
}
- (void)showNoDataStatusWithString:(NSString *)str imageName:(NSString *)imageName  withOfffset:(CGFloat)offset {
    self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:imageName titleStr:str detailStr:@""];
    self.ly_emptyView.contentViewOffset = offset;
    [self ly_showEmptyView];
}
- (void)showNoDataStatusWithDetailString:(NSString *)str detail:(NSString*)detailStr imageName:(NSString *)imageName  withOfffset:(CGFloat)offset{
    
    self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:imageName titleStr:str detailStr:detailStr];
    self.ly_emptyView.contentViewOffset = offset;
    self.ly_emptyView.titleLabFont = [UIFont fontWithName:PingFangSCMedium size: 13];
    
    self.ly_emptyView.titleLabTextColor =
    [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#556C89" alpha:1]
                          darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    
    [self ly_showEmptyView];
}
- (void)hideNoDataStatus {
    
    [self ly_hideEmptyView];
    
}

- (void)showEmptyStatusWithImageStr:(NSString *)imageStr title:(NSString *)title btnTitle:(NSString *)btnTitle Action:(void((^)(void)))action {
    
    
    LYEmptyView *view = [LYEmptyView emptyActionViewWithImageStr:imageStr titleStr:title detailStr:@"" btnTitleStr:btnTitle btnClickBlock:^{
        
        if(action){action();}
        
    }];
    view.subViewMargin = 30;
    view.imageSize = CGSizeMake(130, 130);
    view.titleLabFont = [UIFont systemFontOfSize:18];
    view.titleLabTextColor = KUIColorFromRGB(0x333333);
    view.actionBtnBackGroundColor = KUIColorFromRGB(0xffffff);
    view.actionBtnTitleColor = KUIColorFromRGB(0xfefefe);
    view.actionBtnFont = [UIFont systemFontOfSize:16];
    view.actionBtnCornerRadius = 5;
    view.contentViewOffset = -80;
    view.actionBtnWidth = kScreenWidth-64;
    self.ly_emptyView = view;
    
}

@end

@implementation UITableView (Empty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ly_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(ly_insertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(ly_deleteSections:withRowAnimation:)];
    
    ///row
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(ly_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(ly_deleteRowsAtIndexPaths:withRowAnimation:)];
}
- (void)ly_reloadData{
    [self ly_reloadData];
    [self getDataAndSet];
}
///section
- (void)ly_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_deleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

///row
- (void)ly_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}


@end

@implementation UICollectionView (Empty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ly_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(ly_insertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(ly_deleteSections:)];
    
    ///item
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(ly_insertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(ly_deleteItemsAtIndexPaths:)];
    
}
- (void)ly_reloadData{
    [self ly_reloadData];
    [self getDataAndSet];
}
///section
- (void)ly_insertSections:(NSIndexSet *)sections{
    [self ly_insertSections:sections];
    [self getDataAndSet];
}
- (void)ly_deleteSections:(NSIndexSet *)sections{
    [self ly_deleteSections:sections];
    [self getDataAndSet];
}
///item
- (void)ly_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ly_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)ly_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ly_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

@end
