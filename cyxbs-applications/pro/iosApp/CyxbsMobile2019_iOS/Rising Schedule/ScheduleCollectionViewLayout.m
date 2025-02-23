//
//  ScheduleCollectionViewLayout.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/4.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleCollectionViewLayout.h"

// !!!: Inner Class Begin

#pragma mark - ScheduleCollectionViewLayoutInvalidationContext

@interface ScheduleCollectionViewLayoutInvalidationContext : UICollectionViewLayoutInvalidationContext

/// 是否立刻重新布局顶视图
@property (nonatomic) BOOL invalidateHeaderSupplementaryAttributes;

/// 是否立刻重新布局左视图
@property (nonatomic) BOOL invalidateLeadingSupplementaryAttributes;

/// 是否立刻重新布局课表视图
@property (nonatomic) BOOL invalidateAllAttributes;

@end

#pragma mark - ScheduleCollectionViewLayoutInvalidationContext

@implementation ScheduleCollectionViewLayoutInvalidationContext

@end

// !!!: Inner Class End





#pragma mark - ScheduleCollectionViewLayout ()

@interface ScheduleCollectionViewLayout ()

/// 获取section的值
@property (nonatomic) NSInteger sections;

/// 正常视图每一小节课的大小
@property (nonatomic) CGSize itemSize;

/// 正常视图布局
@property (nonatomic, strong) NSMutableDictionary <NSIndexPath *, UICollectionViewLayoutAttributes *> *itemAttributes;

/// 补充视图布局
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableDictionary <NSIndexPath *, UICollectionViewLayoutAttributes *> *> *supplementaryAttributes;

@end

#pragma mark - ScheduleCollectionViewLayout

@implementation ScheduleCollectionViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemAttributes = NSMutableDictionary.dictionary;
        _supplementaryAttributes = @{
            UICollectionElementKindSectionHeader : NSMutableDictionary.dictionary,
            UICollectionElementKindSectionLeading : NSMutableDictionary.dictionary
        }.mutableCopy;
    }
    return self;
}

#pragma mark - Ask LayoutAttributes

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *result = NSMutableArray.array;
    
    for (NSInteger section = 0; section < _sections; section++) {
        // SupplementaryView attributes
        for (NSString *elementKind in _supplementaryAttributes.allKeys) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
            if (CGRectIntersectsRect(attributes.frame, rect)) {
                [result addObject:attributes];
            }
        }
        // Cell attributes
        NSUInteger itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < itemCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            if (CGRectIntersectsRect(attributes.frame, rect)) {
                
                [_itemAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * _Nonnull key, UICollectionViewLayoutAttributes * _Nonnull obj, BOOL * __unused stop) {
                    
                    BOOL I = CGRectIntersectsRect(obj.frame, attributes.frame);
                    if (I && self.dataSource) {
                        NSComparisonResult compare = [self.dataSource collectionView:self.collectionView layout:self compareOriginIndexPath:key conflictWithIndexPath:indexPath relayoutWithBlock:^(NSRange originRange, NSRange comflictRange) {
                            
                            CGRect originFrame = [self _itemSizeForSection:0 week:0 range:originRange];
                            CGRect newOriginFrame = CGRectMake(obj.frame.origin.x, originFrame.origin.y, obj.frame.size.width, originFrame.size.height);
                            obj.frame = newOriginFrame;
                            
                            CGRect comflicFrame = [self _itemSizeForSection:0 week:0 range:comflictRange];
                            CGRect newComflicFrame = CGRectMake(attributes.frame.origin.x, comflicFrame.origin.y, attributes.frame.size.width, comflicFrame.size.height);
                            attributes.frame = newComflicFrame;
                            
                        }];
                        
                        if (compare == NSOrderedAscending) {
                            attributes.zIndex += 1;
                        } else {
                            obj.zIndex += 1;
                        }
                    }
                    
                }];
                
                
                [result addObject:attributes];
            }
        }
    }
    
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath);
    
    UICollectionViewLayoutAttributes *attributes = _itemAttributes[indexPath];
    if (attributes) {
        return attributes;
    }

    attributes = [self.class.layoutAttributesClass layoutAttributesForCellWithIndexPath:indexPath];
    
    if (self.dataSource) {
        NSUInteger section = indexPath.section;
        NSUInteger week = [self.dataSource collectionView:self.collectionView layout:self weekForItemAtIndexPath:indexPath];
        NSRange range = [self.dataSource collectionView:self.collectionView layout:self rangeForItemAtIndexPath:indexPath];
        
        CGRect frame = [self _itemSizeForSection:section week:week range:range];
        
        attributes.frame = frame;
    }
    
    _itemAttributes[indexPath] = attributes;
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath);
    
    UICollectionViewLayoutAttributes *attributes = _supplementaryAttributes[elementKind][indexPath];

    if (attributes) {
        return attributes;
    }
    
    attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    _supplementaryAttributes[elementKind][indexPath] = attributes;
    
    // Header Element
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        CGFloat x = indexPath.section * self.collectionView.width;
        CGFloat y = self.collectionView.contentOffset.y;
        
        CGRect frame = CGRectMake(x, y, self.collectionView.width, self.heightForHeaderSupplementaryView);
        
        attributes.frame = frame;
        attributes.zIndex = CGFLOAT_MAX;
        
        return attributes;
    }
    
    // Leading Element
    if ([elementKind isEqualToString:UICollectionElementKindSectionLeading]) {
        CGFloat x = indexPath.section * self.collectionView.width;
        CGFloat height = (_itemSize.height + self.lineSpacing) * 12;
        
        CGRect frame = CGRectMake(x, self.heightForHeaderSupplementaryView, self.widthForLeadingSupplementaryView, height);
        
        attributes.frame = frame;
        
        return attributes;
    }
    
    return attributes;
}

#pragma mark - Others

- (void)prepareLayout {
    [self _calculateLayoutIfNeeded];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    
    NSInteger itemCount = 12;
    
    CGSize contentSize = CGSizeMake(_sections * self.collectionView.bounds.size.width, self.heightForHeaderSupplementaryView + itemCount * (_itemSize.height + self.lineSpacing));
    
    return contentSize;
}

#pragma mark - (UISubclassingHooks)

+ (Class)invalidationContextClass {
    return ScheduleCollectionViewLayoutInvalidationContext.class;
}

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    
    ScheduleCollectionViewLayoutInvalidationContext *context =
    (ScheduleCollectionViewLayoutInvalidationContext *)[super invalidationContextForBoundsChange:newBounds];
    
    context.invalidateHeaderSupplementaryAttributes = YES;
    
    return context;
}

- (void)invalidateLayoutWithContext:(ScheduleCollectionViewLayoutInvalidationContext *)context {
    
    // invalidate Header Supplementary
    if (context.invalidateHeaderSupplementaryAttributes) {
        
        [_supplementaryAttributes[UICollectionElementKindSectionHeader] enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, UICollectionViewLayoutAttributes * _Nonnull attributes, BOOL * __unused stop) {
            
            CGFloat x = indexPath.section * self.collectionView.width;
            CGFloat y = self.collectionView.contentOffset.y;
            
            CGRect frame = CGRectMake(x, y, self.collectionView.width, self.heightForHeaderSupplementaryView);
            
            attributes.frame = frame;
        }];
    }
    
    // invalidate Leading Supplementary
    if (context.invalidateLeadingSupplementaryAttributes) {
        
        [_supplementaryAttributes[UICollectionElementKindSectionLeading] enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, UICollectionViewLayoutAttributes * _Nonnull attributes, BOOL * __unused stop) {
            
            CGFloat x = indexPath.section * self.collectionView.width;
            CGFloat height = (_itemSize.height + self.lineSpacing) * 12;
            
            CGRect frame = CGRectMake(x, self.heightForHeaderSupplementaryView, self.widthForLeadingSupplementaryView, height);
            
            attributes.frame = frame;
        }];
    }
    
    // invalidate All Attributes
    if (context.invalidateAllAttributes || context.invalidateDataSourceCounts) {
        
        [_itemAttributes removeAllObjects];
        
        [_supplementaryAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * __unused key, NSMutableDictionary<NSIndexPath *,UICollectionViewLayoutAttributes *> * _Nonnull obj, BOOL * __unused stop) {
            
            [obj removeAllObjects];
        }];
    }
    
    [super invalidateLayoutWithContext:context];
}

#pragma mark - Private API

- (void)_calculateLayoutIfNeeded {
    
    NSInteger sections = [self.collectionView.dataSource performSelector:@selector(numberOfSectionsInCollectionView:) withObject:self.collectionView]
    ? [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView]
    : [self.collectionView numberOfSections];
    
    _sections = sections;
    
    CGFloat width = (self.collectionView.bounds.size.width - self.widthForLeadingSupplementaryView) / 7 - self.columnSpacing;
    
    _itemSize = CGSizeMake(width, width / 46 * 50);
}

- (CGRect)_itemSizeForSection:(NSUInteger)section week:(NSUInteger)week range:(NSRange)range {
    
    CGFloat x = section * self.collectionView.bounds.size.width + self.widthForLeadingSupplementaryView + (week - 1) * (_itemSize.width + self.columnSpacing) + self.columnSpacing;
    CGFloat y = self.heightForHeaderSupplementaryView + (range.location - 1) * (_itemSize.height + self.lineSpacing);
    CGFloat height = range.length * _itemSize.height + (range.length - 1) * self.columnSpacing;
        
    return CGRectMake(x, y, _itemSize.width, height);;
}

@end
