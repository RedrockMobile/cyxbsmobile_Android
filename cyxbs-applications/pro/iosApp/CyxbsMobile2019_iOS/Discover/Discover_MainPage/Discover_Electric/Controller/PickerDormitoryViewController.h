//
//  PickerDormitoryViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/4/12.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^reloadDataBlock)(void);

@interface PickerDormitoryViewController : UIViewController
///当绑定成功后回调重新获取数据
@property (nonatomic, copy) reloadDataBlock block;
@end

NS_ASSUME_NONNULL_END
