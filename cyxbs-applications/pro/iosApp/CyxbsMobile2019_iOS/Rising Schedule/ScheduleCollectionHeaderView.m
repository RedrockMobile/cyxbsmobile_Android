//
//  ScheduleCollectionHeaderView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/6.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleCollectionHeaderView.h"

#import "ScheduleSupplementaryCollectionViewCell.h"

NSString * ScheduleCollectionHeaderViewReuseIdentifier = @"ScheduleCollectionHeaderView";

#pragma mark - ScheduleCollectionHeaderView ()

@interface ScheduleCollectionHeaderView () <
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

/// collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// attributes
@property (nonatomic, strong) UICollectionViewLayoutAttributes *attributes;

/// 背景图
@property (nonatomic, strong) UIView *backgroudView;

@end

#pragma mark - ScheduleCollectionHeaderView

@implementation ScheduleCollectionHeaderView {
    CGFloat _itemWidth;
}

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        [self addSubview:self.backgroudView];
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - Method

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    _attributes = layoutAttributes;
    
    self.collectionView.size = CGSizeMake(layoutAttributes.size.width, layoutAttributes.size.height - 10);
    [self.collectionView reloadData];
    
    self.backgroudView.alpha = 0;
}

- (void)setSuperCollectionView:(UICollectionView *)superCollectionView {
    _superCollectionView = superCollectionView;
    [superCollectionView registerClass:ScheduleSupplementaryCollectionViewCell.class forCellWithReuseIdentifier:ScheduleSupplementaryCollectionViewCellReuseIdentifier];
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.SuperFrame collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.userInteractionEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UIView *)backgroudView {
    if (_backgroudView == nil) {
        _backgroudView = [[UIView alloc] init];
        _backgroudView.backgroundColor =
        [UIColor Light:UIColorHexARGB(#80E8F0FC)
                  Dark:UIColorHexARGB(#40000000)];
        _backgroudView.alpha = 0;
    }
    return _backgroudView;
}

- (CGRect)currentFrame {
    return self.backgroudView.frame;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduleSupplementaryCollectionViewCell *cell = [self.superCollectionView dequeueReusableCellWithReuseIdentifier:ScheduleSupplementaryCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    if (self.dataSource) {
        // section is from '_attributes.indexPath.section'
        // item is from 'indexPath.item'
        NSInteger section = _attributes.indexPath.section;
        NSInteger item = indexPath.item;

        NSString *title = [self.dataSource scheduleCollectionHeaderView:self leadingTitleInSection:section];
        BOOL needSource = [self.dataSource scheduleCollectionHeaderView:self needSourceInSection:section];
        NSString *content;
        if (needSource) {
            NSIndexPath *contentIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
            content = [self.dataSource scheduleCollectionHeaderView:self contentDateAtIndexPath:contentIndexPath];
            
            [self.dataSource
             scheduleCollectionHeaderView:self
             isCurrentBlock:^CGRect(BOOL isCurrent) {
                cell.isCurrent = isCurrent;
                
                if (!isCurrent) {
                    return CGRectZero;
                }
                
                self.backgroudView.alpha = 1;
                UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
                self.backgroudView.left = attributes.frame.origin.x;
                self.backgroudView.top = attributes.size.height / 2;
                self.backgroudView.height = attributes.size.height;
                self.backgroudView.width = attributes.size.width;
                
                return attributes.frame;
            }
             atIndexPath:contentIndexPath];
        }

        if (item == 0) {
            cell.title = title;
            cell.isTitleOnly = YES;
        } else {
            static NSArray *weekStrAry;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.locale = NSLocale.CN;
                formatter.timeZone = NSTimeZone.CQ;
                weekStrAry = formatter.shortWeekdaySymbols.copy;
            });
            
            cell.title = weekStrAry[item % 7];
            cell.isTitleOnly = content ? NO : YES;
        }
        
        cell.content = content;
    }
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = collectionView.height;
    
    if (indexPath.item == 0) {
        return CGSizeMake(self.widthForLeadingView, height);
    }
    
    CGFloat itemWidth = (collectionView.width - self.widthForLeadingView) / 7 - self.columnSpacing;
    
    return CGSizeMake(itemWidth, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _columnSpacing;
}

@end
