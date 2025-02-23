//
//  popUpInformationVC.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface popUpInformationVC : UIViewController

//标题
@property (nonatomic, copy) NSString *titleText;
//内容
@property (nonatomic, copy) NSString *contentText;
//是否有分割线
@property (nonatomic, assign) BOOL isSplit;

@end

NS_ASSUME_NONNULL_END
