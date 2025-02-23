//
//  StampCenterMainScrollView.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/18.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "StampCenterMainScrollView.h"
#import "GoodsCollectionViewCell.h"
#import "StampCenterSecondHeaderView.h"
@implementation StampCenterMainScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetupUI];
        [self addSubview:self.collectionView];
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0.024*SCREEN_WIDTH;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 1);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Bar_H) collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FBFCFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
        [_collectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[StampCenterSecondHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        _collectionHeaderView = [[StampCenterCollectionHeaderView alloc]initWithFrame:CGRectMake(0, 215, SCREEN_WIDTH, 54)];
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 215+54)];
        v.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        [v addSubview:_collectionHeaderView];
        [_collectionView addSubview: v];
    }
    return _collectionView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Bar_H) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)SetupUI{
    self.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.tag = 123;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}
@end
