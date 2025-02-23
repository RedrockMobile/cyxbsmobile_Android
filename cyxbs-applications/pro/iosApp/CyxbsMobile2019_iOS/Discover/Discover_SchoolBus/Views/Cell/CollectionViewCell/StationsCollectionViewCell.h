//
//  StationsCollectionViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/12.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StationsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *stationLabel;
@end

NS_ASSUME_NONNULL_END
