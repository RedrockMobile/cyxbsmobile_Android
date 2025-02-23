//
//  TaskTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2024/2/28.
//  Copyright © 2024 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GotoButton.h"
#import "StampTaskData.h"
NS_ASSUME_NONNULL_BEGIN

///不带有进度条的Cell
@interface TaskTableViewCell : UITableViewCell

///主要内容
@property (nonatomic,strong) UILabel *mainLabel;

///次要内容
@property (nonatomic,strong) UILabel *detailLabel;

///进度条
@property (nonatomic,strong) UIView *progressBar;

///已完成的部分
@property (nonatomic,strong) UIView *progressBarHaveDone;

///已完成的比例
@property (nonatomic,strong) UILabel *progressNumberLabel;

///去完成按钮
@property (nonatomic,strong) GotoButton *gotoButton;

///数据
@property (nonatomic,strong) StampTaskData *data;

///当前的行数
@property (nonatomic,assign) NSInteger row;


@end

NS_ASSUME_NONNULL_END
