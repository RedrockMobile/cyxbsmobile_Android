//
//  EmptyClassTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/22.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EmptyClassItem;
@interface EmptyClassTableViewCell : UITableViewCell

/// 显示楼层的Label
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;

/// 显示教室的CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *roomsCollectionView;

@property (nonatomic, strong) EmptyClassItem *item;

@end

NS_ASSUME_NONNULL_END
