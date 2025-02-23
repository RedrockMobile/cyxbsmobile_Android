//
//  ResetPwdViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResetPwdView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResetPwdViewController : UIViewController

@property (nonatomic, strong) ResetPwdView *resetView;

@property (nonatomic, assign) NSString *stuID;

@property (nonatomic, assign) NSString *changeCode;
@end

NS_ASSUME_NONNULL_END
