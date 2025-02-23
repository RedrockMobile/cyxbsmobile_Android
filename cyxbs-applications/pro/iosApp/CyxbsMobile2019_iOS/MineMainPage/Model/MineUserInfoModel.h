//
//  MineUserInfoModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/10/28.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//可以从NSUserdefault中获取 上一次进入点赞页的时间戳，未读消息数那边的接口要使用这个数据
#define praiseLastClickTimeKey_NSInteger @"praiseLastClickTimeKey_NSInteger"
//可以从NSUserdefault中获取 上一次进入评论页的时间戳，未读消息数那边的接口要使用这个数据
#define remarkLastClickTimeKey_NSInteger @"remarkLastClickTimeKey_NSInteger"

typedef enum : NSUInteger {
    //网络请求全部成功
    MineUserInfoModelUpdateUserInfoStateSuccess = YES,
    
    //网络请求可能是部分失败，可能是全部失败
    MineUserInfoModelUpdateUserInfoStateError = NO,
} MineUserInfoModelUpdateUserInfoState;

@interface MineUserInfoModel : NSObject <NSSecureCoding>

/// 昵称
@property (nonatomic, copy) NSString *nickNameStr;

/// 个性签名
@property (nonatomic, copy) NSString *mottoStr;

/// 总动态数
@property (nonatomic, assign) NSInteger blogCnt;

/// 总或评论数
@property (nonatomic, assign) NSInteger remarkCnt;

/// 总获赞数
@property (nonatomic, assign) NSInteger praiseCnt;

/// 意见与反馈的新消息个数
@property (nonatomic, assign) NSInteger msgCenterCnt;

/// 邮票中心的新消息个数
@property (nonatomic, assign) NSInteger stampCenterCnt;

/// 消息中心的新消息个数
@property (nonatomic, assign) NSInteger suggestCenterCnt;

/// 连续签到天数
@property (nonatomic, assign) NSInteger checkInDay;

/// 是否有新的评论
@property (nonatomic, assign)BOOL hasNewRemark;

/// 是否有新的点赞
@property (nonatomic, assign)BOOL hasNewPraise;


+ (instancetype)shareModel;

- (void)updateUserInfoCompletion:(void(^)(MineUserInfoModelUpdateUserInfoState state))callBack;

///把数据同步到本地文件
- (void)synchronizeDataToFile;
@end

NS_ASSUME_NONNULL_END
