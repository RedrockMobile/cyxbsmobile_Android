//
//  EmptyClassTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/22.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "EmptyClassTableViewCell.h"
#import "EmptyClassItem.h"
#import "EmptyClassCollectionViewCell.h"

@interface EmptyClassTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation EmptyClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (@available(iOS 11.0, *)) {
        self.floorLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]];
    } else {
        self.floorLabel.textColor = [UIColor colorWithRed:17/255.0 green:44/255.0 blue:84/255.0 alpha:1];
    }
    
    [self.roomsCollectionView registerClass:[EmptyClassCollectionViewCell class] forCellWithReuseIdentifier:@"EmptyClassCollectionViewCell"];
    
    self.roomsCollectionView.dataSource = self;
    self.roomsCollectionView.delegate = self;
}

#pragma mark - CollectionView数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.item.roomArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmptyClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmptyClassCollectionViewCell" forIndexPath:indexPath];
    
    cell.roomLabel.text = self.item.roomArray[indexPath.item];
    
    return cell;
}

// 每个cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(35, 15);
}

// 垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

// 水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

@end
