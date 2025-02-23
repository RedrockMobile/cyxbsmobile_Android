//
//  SchoolBusBottomView.h
//  CyxbsMobile2019_iOS
//
//  Created by Clutch Powers on 2022/4/7.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@class SchoolBusBottomView;

@protocol SchoolBusBottomViewDelegate <NSObject>

@required

- (void)schoolBusView:(SchoolBusBottomView *)view didSelectedBtnWithIndex:(NSUInteger) index AndisSelected:(BOOL) isSelected;


@end

@interface SchoolBusBottomView : UIView

@property (nonatomic, weak) id <SchoolBusBottomViewDelegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLabel;
/// 按钮互斥 输入button tag 
/// @param tag 输入的button tag
- (void)busButtonControllerWithBtnTag:(NSUInteger )tag;

@end

NS_ASSUME_NONNULL_END
