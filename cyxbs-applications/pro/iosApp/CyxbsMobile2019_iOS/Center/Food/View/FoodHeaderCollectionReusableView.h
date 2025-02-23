//
//  FoodCollectionReusableView.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/18.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
UIKIT_EXTERN NSString *FoodHeaderCollectionReusableViewCellReuseIdentifier;

@interface FoodHeaderCollectionReusableView : UICollectionReusableView
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *otherText;
@property (nonatomic, strong) UIButton *refreshBtn;
@end

NS_ASSUME_NONNULL_END
