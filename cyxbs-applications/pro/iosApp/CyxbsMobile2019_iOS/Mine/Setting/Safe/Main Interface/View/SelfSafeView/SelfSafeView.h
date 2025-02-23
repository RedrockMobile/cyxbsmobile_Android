//
//  SelfSafeView.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SelfSafeViewDelegate <NSObject>

- (void)backButtonClicked;
- (void)selectedChangePassword;
- (void)selectedChangeQuestion;
- (void)selectedChangeEmail;

@end

@interface SelfSafeView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray<UIButton *> *btnsArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<SelfSafeViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
