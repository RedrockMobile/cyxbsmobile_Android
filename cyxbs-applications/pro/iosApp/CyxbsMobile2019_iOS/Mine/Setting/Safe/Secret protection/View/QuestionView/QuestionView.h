//
//  QuestionView.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/28.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *questionTableView;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) UIView *backView;


- (void)popQuestionView:(UIView *)view;
- (void)disMissView;

@end

NS_ASSUME_NONNULL_END

