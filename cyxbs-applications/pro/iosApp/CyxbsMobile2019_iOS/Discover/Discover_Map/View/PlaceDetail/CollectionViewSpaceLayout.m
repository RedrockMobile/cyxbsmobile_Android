//
//  CQUPTMapDetailTagsCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/17.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CollectionViewSpaceLayout.h"

@interface CollectionViewSpaceLayout ()
{
    //内容大小
    CGSize _contentSize;
}
//保存cell详细信息
@property (nonatomic,strong) NSMutableArray *itemAttributes;

@end

@implementation CollectionViewSpaceLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置默认信息
        _sectionInsets = UIEdgeInsetsZero;
        _interitemSpacing = 10;
        _lineSpacing = 10;
    }
    return self;
}
//1.布局cell的
- (void)prepareLayout
{
    self.delegate = (id<SpaceLayoutDelegate>)self.collectionView.delegate;
    
    _itemAttributes = [NSMutableArray array];
    
    
    //cell的x,y,宽度，高度
    CGFloat xOffset = _sectionInsets.left;
    CGFloat yOffset = _sectionInsets.top;
    
    //获取指定组的cell的个数
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    //collectionView的宽
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    //计算每个cell的位置
    for (int i = 0; i < numberOfItems; i ++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取cell的大小
        CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        
        CGFloat maxX = xOffset + size.width;
        if (maxX  > collectionViewWidth - _sectionInsets.right) {
            xOffset = _sectionInsets.left;
            yOffset += size.height + _lineSpacing;
        }
        //创建一个item的attribute对象
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        //当前cell坐标
        attributes.frame = CGRectMake(xOffset, yOffset, size.width, size.height);
        
        //保存cell信息
        [self.itemAttributes addObject:attributes];
        
        xOffset += size.width + _interitemSpacing;
        
        //内容总高度
        _contentSize.height = yOffset + size.height + _sectionInsets.bottom;
    }
    _contentSize.width = collectionViewWidth;
    
}

//返回指定范围的cell的布局的详细信息
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}
//返回指定cell的详细布局信息
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemAttributes[indexPath.item];
}
//重新计算当前滚动视图的contentSize
- (CGSize)collectionViewContentSize
{
    return _contentSize;
}

@end
