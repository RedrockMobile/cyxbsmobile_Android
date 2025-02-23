//
//  ScheduleCollectionLeadingView.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/6.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleCollectionLeadingView.h"

#import "ScheduleSupplementaryCollectionViewCell.h"

NSString *ScheduleCollectionLeadingViewReuseIdentifier = @"ScheduleCollectionLeadingView";

#pragma mark - ScheduleCollectionLeadingView ()

@interface ScheduleCollectionLeadingView () <
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

/// 布局
@property (nonatomic, strong) UICollectionViewLayoutAttributes *attributes;

/// 视图
@property (nonatomic, strong) UICollectionView *collectionView;

@end

#pragma mark - ScheduleCollectionLeadingView

@implementation ScheduleCollectionLeadingView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    _attributes = layoutAttributes;
    self.collectionView.size = layoutAttributes.size;
    [self.collectionView reloadData];
}

#pragma mark - Setter

- (void)setSuperCollectionView:(UICollectionView *)superCollectionView {
    _superCollectionView = superCollectionView;
    [superCollectionView registerClass:ScheduleSupplementaryCollectionViewCell.class forCellWithReuseIdentifier:ScheduleSupplementaryCollectionViewCellReuseIdentifier];
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.SuperFrame collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduleSupplementaryCollectionViewCell *cell = [self.superCollectionView dequeueReusableCellWithReuseIdentifier:ScheduleSupplementaryCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    cell.isTitleOnly = YES;
    cell.isCurrent = NO;
    cell.title = @(indexPath.item + 1).stringValue;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = _attributes.size.height / 12 - self.lineSpacing;
    
    return CGSizeMake(_attributes.size.width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _lineSpacing;
}

@end
