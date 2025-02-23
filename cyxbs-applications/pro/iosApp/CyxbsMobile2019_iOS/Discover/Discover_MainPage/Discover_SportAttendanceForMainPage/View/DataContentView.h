//
//  DataContentView.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/9.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataContentView : UIView

+ (instancetype)loadViewWithData:(NSString *)data
                            unit:(NSString *)unit
                            detail:(NSString *)detail;

@end

NS_ASSUME_NONNULL_END
