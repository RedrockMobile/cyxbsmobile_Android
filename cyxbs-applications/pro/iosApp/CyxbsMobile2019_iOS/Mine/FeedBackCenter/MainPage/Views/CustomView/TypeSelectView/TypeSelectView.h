//
//  TypeSelectView.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/25.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeButton.h"


NS_ASSUME_NONNULL_BEGIN

@interface TypeSelectView : UIView <TypeButtonDelegate>

///意见反馈
@property (nonatomic,strong) TypeButton *recommendBtn;
///系统问题
@property (nonatomic,strong) TypeButton *systemProblemBtn;
///账号问题
@property (nonatomic,strong) TypeButton *profileProblemBtn;
///其他
@property (nonatomic,strong) TypeButton *otherBtn;

///问题选择block
@property (nonatomic,copy) void(^select)(TypeButton *sender);

@end

NS_ASSUME_NONNULL_END
