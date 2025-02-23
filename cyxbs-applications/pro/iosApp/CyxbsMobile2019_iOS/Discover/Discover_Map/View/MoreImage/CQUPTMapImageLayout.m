//
//  CQUPTMapImageLayout.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/18.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapImageLayout.h"

@interface CQUPTMapImageLayout ()

/** 保存所有Item的LayoutAttributes */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributesArray;
/** 保存所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *columnHeights;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) NSUInteger columns;

@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, assign) CGFloat cellWidth;

@end



@implementation CQUPTMapImageLayout

- (CGFloat)margin {
    return 17;
}

- (CGFloat)cellWidth {
    return (MAIN_SCREEN_W - (2 * self.margin) - self.itemSpacing) / 2.0;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columns = 2;
        self.itemSpacing = 10;
        self.attributesArray = [NSMutableArray array];
        self.columnHeights = [NSMutableArray array];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.columnHeights removeAllObjects];
    
    for (int i = 0; i < self.columns; i++) {
        [self.columnHeights addObject:@(0)];
    }
    
    [self.attributesArray removeAllObjects];
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attrs];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat x;
    CGFloat y;
    CGFloat w;
    CGFloat h;
    
    if ([self.columnHeights[0] doubleValue] <= [self.columnHeights[1] doubleValue]) {       // item在左边一列
        x = self.margin;
        y = self.columnHeights[0].doubleValue + self.itemSpacing;
        w = self.cellWidth;
        h = self.cellWidth * 0.67;
        attrs.frame = CGRectMake(x, y, w, h);
    } else {                            // item在右边一列
        x = self.margin + self.cellWidth + self.itemSpacing;
        y = self.columnHeights[1].doubleValue + self.itemSpacing;
        w = self.cellWidth;
        h = self.cellWidth * 1.34;
        attrs.frame = CGRectMake(x, y, w, h);
    }
    
    // 更新列高
    if ([self.columnHeights[0] doubleValue] <= [self.columnHeights[1] doubleValue]) {       // item在左边一列
        self.columnHeights[0] = @(h + y);
    } else {                            // item在右边一列
        self.columnHeights[1] = @(h + y);
    }
    self.contentHeight = self.columnHeights[0].doubleValue > self.columnHeights[1].doubleValue ? self.columnHeights[0].doubleValue : self.columnHeights[1].doubleValue;
    
    return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}



- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + self.margin);
}

@end
