//
//  ScheduleServiceDelegate.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/10.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ScheduleRequestType.h"

#import "ScheduleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleServiceDelegate : NSObject <
    UICollectionViewDelegate
>

+ (instancetype)new NS_UNAVAILABLE;

/// <#description#>
@property (nonatomic, strong) ScheduleRequestDictionary *parameterIfNeeded;

/// <#description#>
@property (nonatomic, readonly, nonnull) ScheduleModel *model;

/// <#description#>
@property (nonatomic, strong, null_resettable) UICollectionView *collectionView;

- (void)requestAndReloadData;

- (void)scrollToSection:(NSUInteger)page;

@end

NS_ASSUME_NONNULL_END
