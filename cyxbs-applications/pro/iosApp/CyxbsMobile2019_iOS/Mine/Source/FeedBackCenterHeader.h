//
//  FeedBackCenterHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/27.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef FeedBackCenterHeader_h
#define FeedBackCenterHeader_h

// 反馈中心
#pragma mark - API

// 测试环境, 请在正式环境出来的时候
// 历史反馈列表
// 参数 product_id 区分数据来源, 掌邮只填1
#define Mine_GET_feedBackCenterHistoryList_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"feedback-center/feedback/list"]

// 历史反馈页, 点击一个进入详情
// 参数 feedback_id 信息的id
// 参数 product_id 区分数据来源, 掌邮只填1
#define Mine_GET_feedBackCenterHistoryView_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"feedback-center/feedback/view"]

//常见问题
#define Mine_GET_commonQuestion_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"feedback-center/question/list?product_id=1"]

//提交反馈
#define Mine_POST_submit_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"feedback-center/feedback/create?product_id=1"]

#endif /* FeedBackCenterHeader_h */
