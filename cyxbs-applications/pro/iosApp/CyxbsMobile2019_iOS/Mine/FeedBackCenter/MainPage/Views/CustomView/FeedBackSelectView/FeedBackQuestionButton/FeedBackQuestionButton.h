//
//  FeedBackQuestionButton.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/3/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "QuestionButton.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - FeedBackQuestionButton

@interface FeedBackQuestionButton : QuestionButton

/// 普通状态
- (void)setNormalStyle;

/// 高亮状态
- (void)setHighLightStyle;

@end

NS_ASSUME_NONNULL_END
