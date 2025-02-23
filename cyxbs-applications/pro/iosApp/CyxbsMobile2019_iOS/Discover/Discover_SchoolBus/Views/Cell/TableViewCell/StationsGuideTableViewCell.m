//
//  StationsGuideTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/12.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "StationsGuideTableViewCell.h"

@interface StationsGuideTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, copy) NSArray *stationArray;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation StationsGuideTableViewCell

- (instancetype)initWithStationsData:(StationData *)data {
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.stationArray = data.stations;
        [self addSubview: self.titleLabel];
        _titleLabel.text = data.line_name;
        [self addSubview: self.collectionView];

        _collectionView.dataSource = self;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _stationArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StationsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.backImageView.image = [UIImage imageNamed:@"originstation"];
    }else if (indexPath.row == _stationArray.count - 1) {
        cell.backImageView.image = [UIImage imageNamed:@"terminalstation"];
    }else{
        cell.backImageView.image = [UIImage imageNamed:@"busline"];
    }
    cell.stationLabel.text = _stationArray[indexPath.row][@"name"];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize  = CGSizeMake(46, 163);
         // 横向滚动
         layout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
         // cell间的间距
         layout.minimumLineSpacing  = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 163) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor cyanColor];
        [_collectionView registerClass: [StationsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.scrollEnabled = YES;
    }
    return _collectionView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, 58, 31)];
        _titleLabel.left = self.left + 68;
        _titleLabel.top = self.top + 27;
    }
    return _titleLabel;
}

@end
