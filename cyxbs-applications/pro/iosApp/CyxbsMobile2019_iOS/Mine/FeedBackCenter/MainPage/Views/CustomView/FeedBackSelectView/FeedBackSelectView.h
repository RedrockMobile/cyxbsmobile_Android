//
//  FeedBackSelectView.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/3/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**FeedBackSelectView
 * 反馈的信息选择
 */

#import "QuestionSelectView.h"

#import "FeedBackQuestionButton.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - FeedBackSelectView

@interface FeedBackSelectView : QuestionSelectView <
    QuestionSelectViewDelegate,
    QuestionSelectViewDataSource
>

@end

NS_ASSUME_NONNULL_END
