//
//  StationsGuideTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/12.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationsCollectionViewCell.h"
#import "StationData.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationsGuideTableViewCell : UITableViewCell

@property(nonatomic,strong) UICollectionView *collectionView;

- (instancetype)initWithStationsData:(StationData *)data;

@end

NS_ASSUME_NONNULL_END
