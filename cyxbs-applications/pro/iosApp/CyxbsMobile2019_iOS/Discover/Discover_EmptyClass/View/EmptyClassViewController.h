//
//  EmptyClassViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/19.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyClassProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class EmptyClassPresenter;
@interface EmptyClassViewController : UIViewController <EmptyClassProtocol>

@property (nonatomic, strong) EmptyClassPresenter *presenter;

@end

NS_ASSUME_NONNULL_END
