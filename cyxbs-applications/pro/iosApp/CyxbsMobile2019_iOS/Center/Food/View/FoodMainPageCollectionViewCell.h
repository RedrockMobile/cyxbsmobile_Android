//
//  BTCollectionViewCell.h
//  food
//
//  Created by 潘申冰 on 2023/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
UIKIT_EXTERN NSString *FoodMainPageCollectionViewCellReuseIdentifier;

@interface FoodMainPageCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *lab;

@end

NS_ASSUME_NONNULL_END
