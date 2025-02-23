//
//  sendCodeViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/3.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface sendCodeViewController : UIViewController

@property (nonatomic, strong) NSString *sendCodeToEmialLabel;

- (instancetype)initWithExpireTime:(NSString *)time;

@end

NS_ASSUME_NONNULL_END
