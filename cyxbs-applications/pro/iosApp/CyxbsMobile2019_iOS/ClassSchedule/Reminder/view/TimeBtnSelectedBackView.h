//
//  TimeBtnSelectedBackView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/20.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TimeBtnSelectedBackViewDeleget <NSObject>
@property(nonatomic,strong)NSMutableArray <NSDictionary*> *timeDictArray;
@end
@interface TimeBtnSelectedBackView : UIScrollView

/// 添加已选时间的按钮
- (void)loadSelectedButtonsWithTimeDict:(NSDictionary*)timeDict;
@property(nonatomic,weak)id<TimeBtnSelectedBackViewDeleget>timeDateDelegate;
/// 加号按钮
@property(nonatomic,strong)UIButton *addBtn;

@property(nonatomic,strong)UIView *backView;
@end

NS_ASSUME_NONNULL_END
