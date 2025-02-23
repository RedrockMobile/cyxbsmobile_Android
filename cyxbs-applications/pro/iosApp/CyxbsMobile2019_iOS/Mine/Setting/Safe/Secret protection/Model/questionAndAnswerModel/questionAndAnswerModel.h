//
//  questionAndAnswerModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/31.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Netblock)(id info);

@interface questionAndAnswerModel : NSObject

@property (nonatomic, strong) NSNumber *questionId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, copy) Netblock Block;

- (void)sendQuestionAndAnswerWithId:(NSString *) questionid AndContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END

