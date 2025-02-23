//
//  CQUPTDetailView.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/15.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapPlaceItem, CQUPTMapPlaceDetailItem;
@interface CQUPTMapDetailView : UIView

- (instancetype)initWithPlaceItem:(CQUPTMapPlaceItem *)placeItem;

- (void)loadDataWithPlaceDetailItem:(CQUPTMapPlaceDetailItem *)detailItem;

@end

NS_ASSUME_NONNULL_END
