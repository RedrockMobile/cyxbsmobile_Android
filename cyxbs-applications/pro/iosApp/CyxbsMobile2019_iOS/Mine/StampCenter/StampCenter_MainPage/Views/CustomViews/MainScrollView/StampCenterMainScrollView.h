//
//  StampCenterMainScrollView.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/18.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StampCenterCollectionHeaderView.h"
#import "TableHeaderView.h"


NS_ASSUME_NONNULL_BEGIN
///主左右划view
@interface StampCenterMainScrollView : UIScrollView 

///collectionView
@property (nonatomic,strong) UICollectionView *collectionView;

///collection头视图
@property (nonatomic,strong) StampCenterCollectionHeaderView *collectionHeaderView;

///tableView
@property (nonatomic,strong) UITableView *tableView;


@end

NS_ASSUME_NONNULL_END
