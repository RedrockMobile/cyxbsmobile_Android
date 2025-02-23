//
//  DLReminderView.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLNextButton.h"
#import "DLTextFiled.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HistoryButtonDelegate <NSObject>

- (void)didTapButtonWithTitle:(NSString *)str;

@end

/// 三个页面的背景都有这个类
@interface DLReminderView : UIView
@property (nonatomic, strong) UILabel *notoiceLab; //大的提醒文字上面哪个小字
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIImageView *addImage;
@property (nonatomic, strong) DLNextButton *nextBtn;
@property (nonatomic, strong) DLTextFiled *textFiled;

@property (nonatomic, strong) NSArray *historyBtnTitleArray;

@property (nonatomic, weak) id<HistoryButtonDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
