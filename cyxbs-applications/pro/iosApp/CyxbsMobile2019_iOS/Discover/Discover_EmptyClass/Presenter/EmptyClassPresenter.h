//
//  EmptyClassPresenter.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/19.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmptyClassProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmptyClassPresenter : NSObject

@property (nonatomic, strong) UIViewController<EmptyClassProtocol> *attatchedView;

- (void)requestEmptyClassRoomDataWithParams:(NSDictionary *)params;

- (void)attatchView:(UIViewController<EmptyClassProtocol> *)attatchedView;
- (void)dettatchView;

@end

NS_ASSUME_NONNULL_END
