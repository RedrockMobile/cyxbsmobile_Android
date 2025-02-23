//
//  CQUPTMapDetailTagsCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/17.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpaceLayoutDelegate <NSObject>

@required
//返回cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CollectionViewSpaceLayout : UICollectionViewLayout

@property (nonatomic,weak) id<SpaceLayoutDelegate> delegate;

//距离上下左右的距离
@property (nonatomic,assign) UIEdgeInsets sectionInsets;

//上下两个item的距离
@property (nonatomic,assign) CGFloat lineSpacing;

//左右两个item的距离
@property (nonatomic,assign) CGFloat interitemSpacing;

@end
