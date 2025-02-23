//
//  CQUPTMapBeforeSearch.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/12.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CQUPTMapSearchItem;
@interface CQUPTMapSearchView : UIView

@property (nonatomic, weak) UITableView *historyTableView;
@property (nonatomic, weak) UITableView *resultTableView;

- (void)searchPlaceSuccess:(NSArray<CQUPTMapSearchItem *> *)placeIDArray;

@end

NS_ASSUME_NONNULL_END
