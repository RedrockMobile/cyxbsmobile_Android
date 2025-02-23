//
//  FeedBackReplyTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackReplyTableViewCell.h"
// view
#import "ImgViewCollectionViewCell.h"
// pod
#import <YBImageBrowser.h>

@interface FeedBackReplyTableViewCell ()
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;

/// 背景蒙版
@property (nonatomic, strong) UIView * maskView;

@end

@implementation FeedBackReplyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.maskView];
    [self.maskView addSubview:self.titleLabel];
    [self.maskView addSubview:self.picturesCollectionView];
    // config self
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    // timelabel
    CGRect f6 = bounds;
    f6.size = [self.timeLabel sizeThatFits:CGSizeZero];
    f6.origin = CGPointMake((bounds.size.width - f6.size.width) / 2, 12);
    self.timeLabel.frame = f6;
    
    bounds.size.width -= 16 * 2;
    
    // titleLabel
    CGRect f1 = bounds;
    f1.origin = CGPointMake(18, 18);
    f1.size = [self.titleLabel sizeThatFits:CGSizeMake(bounds.size.width - 18 * 2, 0)];
    self.titleLabel.frame = f1;
    
    // picturesCollectionView
    CGRect f2 = bounds;
    f2.origin = CGPointMake(f1.origin.x, CGRectGetMaxY(f1) + 10);
    CGFloat spaceWidth = 7.f;
    self.flowLayout.minimumLineSpacing = spaceWidth;
    self.flowLayout.minimumInteritemSpacing = spaceWidth;
    CGFloat cellWidth = (bounds.size.width - f2.origin.x * 2 - spaceWidth * 2) / 3;
    self.flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth);
    if (self.cellModel.urls.count == 0) {
        CGFloat collectionWidth = 0;
        f2.size = CGSizeMake(collectionWidth, 0);
    } else {
        CGFloat collectionWidth = cellWidth * self.cellModel.urls.count + spaceWidth * (self.cellModel.urls.count - 1);
        f2.size = CGSizeMake(collectionWidth, cellWidth);
    }
    self.picturesCollectionView.frame = f2;
    
    // maskeView
    CGRect flast = bounds;
    flast.origin = CGPointMake(16, CGRectGetMaxY(f6) + 12);
    flast.size = CGSizeMake(bounds.size.width, CGRectGetMaxY(self.picturesCollectionView.frame) + 18);
    self.maskView.frame = flast;
}

#pragma mark - private

- (CGFloat)height {
    return CGRectGetMaxY(self.maskView.frame) + 8;
}

#pragma mark - setter

- (void)setCellModel:(FeedBackReplyModel *)cellModel {
    _cellModel = cellModel;
    self.titleLabel.text = [@"回复：" stringByAppendingString:cellModel.content];
    self.timeLabel.text = getTimeStrWithDateFormat(cellModel.CreatedAt, @"yyyy-MM-dd'T'HH:mm:ss'+08:00'", @"yyyy/HH/dd HH:mm");
    [self layoutSubviews];
    [self.picturesCollectionView reloadData];
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:15];
        _titleLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UICollectionView *)picturesCollectionView {
    if (_picturesCollectionView == nil) {
        _picturesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _picturesCollectionView.delegate = self;
        _picturesCollectionView.dataSource = self;
        _picturesCollectionView.scrollEnabled = NO;
        _picturesCollectionView.backgroundColor = [UIColor clearColor];
        [_picturesCollectionView registerClass:[ImgViewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier(ImgViewCollectionViewCell)];
    }
    return _picturesCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        _maskView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
        _maskView.layer.cornerRadius = 8;
    }
    return _maskView;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont fontWithName:PingFangSCMedium size:15];
        _timeLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    return _timeLabel;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cellModel.urls.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier(ImgViewCollectionViewCell) forIndexPath:indexPath];
    
    [cell.picImgView sd_setImageWithURL:[NSURL URLWithString:self.cellModel.urls[indexPath.item]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cellModel.urls) {
        NSMutableArray *photos = [NSMutableArray array];
        for (int i = 0;i < self.cellModel.urls.count; i++) {
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:self.cellModel.urls[i]];
            [photos addObject:data];
        }
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSourceArray = photos;
        browser.currentPage = indexPath.row;
        // 只有一个保存操作的时候，可以直接右上角显示保存按钮
        browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
        [browser show];
    }
}

@end
