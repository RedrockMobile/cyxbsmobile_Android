//
//  CQUPTMapContentView.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/8.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CQUPTMapContentViewDelegate <NSObject>

- (void)backButtonClicked;

- (void)requestStarData;

- (void)searchPlaceWithString:(NSString *_Nullable)string;

- (void)requestPlaceDataWithPlaceID:(NSString *_Nonnull)placeID;

- (void)vrButtonTapped;

@end

NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapDataItem, CQUPTMapHotPlaceItem, CQUPTMapStarPlaceItem, CQUPTMapSearchItem, CQUPTMapPlaceDetailItem, CQUPTMapPlaceItem;
@interface CQUPTMapContentView : UIView

@property (nonatomic, weak) id<CQUPTMapContentViewDelegate> delegate;

@property (nonatomic, weak) UITextField *searchBar;
@property (nonatomic, weak) UIScrollView *mapScrollView;
@property (nonatomic, weak) UIImageView *mapView;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *pinsArray;


- (instancetype)initWithFrame:(CGRect)frame andMapData:(CQUPTMapDataItem *)mapDataItem andHotPlaceItemArray:(NSArray<CQUPTMapHotPlaceItem *> *)hotPlaceItemArray;

- (void)cancelSearch;

- (void)selectedAPlace:(CQUPTMapPlaceItem *)placeItem;

- (void)starPlaceListRequestSuccess:(CQUPTMapStarPlaceItem *)starPlaceArray;

- (void)searchPlaceSuccess:(NSArray<CQUPTMapSearchItem *> *)placeIDArray;

- (void)placeDetailDataRequestSuccess:(CQUPTMapPlaceDetailItem *)placeDetailItem;

@end

NS_ASSUME_NONNULL_END
