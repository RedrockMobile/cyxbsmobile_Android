//
//  CQUPTMapHotPlaceButton.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapHotPlaceItem;
@interface CQUPTMapHotPlaceButton : UIView

@property (nonatomic, weak) CQUPTMapHotPlaceItem *hotPlaceItem;

@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, weak) UIButton *button;

- (instancetype)initWithHotPlace:(CQUPTMapHotPlaceItem *)hotPlaceItem;

@end

NS_ASSUME_NONNULL_END
