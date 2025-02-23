//
//  NewQAHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/26.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef NewQAHeader_h
#define NewQAHeader_h

#pragma mark - “邮问”接口
#pragma mark - API

/*
 问题部分
 */

// 全部问题列表。未使用
#define QA_GET_allQuestions_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Question/getQuestionList"]

// 添加新问题。未使用
#define QA_GET_addQuestion_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Question/add"]

// 问题图片上传。未使用
#define QA_GET_uploadPic_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Question/uploadPicture"]

// 取消提问。未使用
#define QA_GET_cancelQuestion_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Question/cancelQuestion"]

// 问题详情。未使用
#define QA_GET_questionDetail_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Question/getDetailedInfo"]

// 阅读量统计。未使用
#define QA_GET_browseNumber_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Question/addView"]

// 问题回答列表。未使用
#define QA_GET_questionAnswerList_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/getAnswerlist"]

// 忽略问题。未使用
#define QA_GET_ignoreQuestion_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Question/ignore"]


/*
 回答部分
 */

// 回答问题。未使用
#define QA_GET_answerQuestion_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/add"]

// 上传答案图片。未使用
#define QA_GET_answerAnswerImageUpload [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/uploadPicture"]

// 某个问题下的回答列表。未使用
#define QA_GET_questionAnswerLIST_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/add"]

// 采纳答案。未使用
#define QA_GET_adoptAnswer_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/adopt"]

// 赞接口。未使用
#define QA_GET_addLike_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/praise"]

// 取消赞接口。未使用
#define QA_GET_cancelLike_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/cancelPraise"]

// 某个回答下的评论列表。未使用
#define QA_GET_questionDiscuss_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/getRemarkList"]

// 在回答下添加评论。未使用
#define QA_GET_addDiscuss_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Answer/remark"]

/*
举报部分。未使用
*/
#define QA_GET_addReport_API [CyxbsMobileBaseURL_2 stringByAppendingString:@"QA/Feedback/addReport"]

/*
 草稿箱
 */
// 添加到草稿箱。未使用
#define QA_GET_addDraft_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-draft/User/addItemInDraft"]

// 更新草稿箱内容。未使用
#define QA_GET_updateDraft_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-draft/User/updateItemInDraft"]

#pragma mark - “新版邮问”接口
#pragma mark - API
/*
 搜索部分
 */
// 热词搜索列表（非搜索框内）
#define NewQA_GET_hotWords_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/search/getSearchHotWord"]

// 搜索结果：
    // 相关动态
#define NewQA_GET_searchDynamic_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/search/searchPost"]
    // 重邮知识库
#define NewQA_GET_searchKnowledge_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/search/searchKnowledge"]

/*
 发布动态页
 */
// 发布动态
#define NewQA_POST_releaseDynamicRelease_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/post/releaseDynamic"]

// 推荐帖子
#define NewQA_GET_QAPost_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/post/getMainPage"]

// 关注的人帖子
#define NewQA_GET_QAFocusList_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/post/dynamic/focus"]

// 举报
#define NewQA_POST_QAReport_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/comment/report"]

// 热词搜索
#define NewQA_GET_hotWord_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/search/getSearchHotWord"]

// 我的关注
#define NewQA_GET_QAFollowGroup_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ground/getFollowedTopic"]

// 点赞帖子
#define NewQA_POST_QAStar_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/comment/praise"]

// 屏蔽
#define NewQA_POST_QAShield_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ignore/addIgnoreUid"]

// 查看未读消息
#define NewQA_GET_QAQueryNewCount_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ground/getUnreadCount"]

// 删除
#define NewQA_POST_QADeletePost_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/comment/deleteId"]

// 关注圈子
#define NewQA_POST_QAStarGroup_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ground/followTopicGround"]
/**
 圈子广场
 圈子详情页
 */

// 圈子页帖子内容
#define NewQA_GET_QATopicContent_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/post/getLoopPage"]
// 圈子广场
#define NewQA_POST_QATopicGroup_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ground/getTopicGround"]
// 关注和取消圈子
#define NewQA_POST_followTopic_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ground/followTopicGround"]
/**
 动态详情页
 */
// 根据帖子id获取帖子的具体信息
#define NewQA_GET_QADynamicDetail_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/post/getPostInfo"]

// 根据id获取评论/回复
#define NewQA_GET_QACommentReply_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/comment"]

// 回复评论
#define NewQA_POST_QACommentRelease_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/comment/releaseComment"]
/*
 删除帖子或评论（POST）     说明：
 参数：
 id                 动态的id
 model              0为动态，1为评论
 */
#define NewQA_POST_QADynamicOrCommentDeleted_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/comment/deleteId"]


//举报
#define NewQA_POST_report_API @"http://localhost:8080/new/report"



#endif /* NewQAHeader_h */
