//
//  popFoodResultVC.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface popFoodResultVC : UIViewController

//标题
@property (nonatomic, copy) NSString *foodNameText;
//内容
@property (nonatomic, copy) NSString *contentText;
//美食图片
@property (nonatomic, copy) NSString *ImgURL;
//点赞数量
@property (nonatomic, assign) NSInteger praiseNum;
//是否已经点赞
@property (nonatomic, assign) BOOL isPraise;

@property void (^ praiseBlock) (NSInteger praiseNum, BOOL isPraise);

@end

NS_ASSUME_NONNULL_END
