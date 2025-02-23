//
//  questionModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "questionItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^Netblock)(id info);

@interface questionModel : NSObject

@property (nonatomic, copy) Netblock Block;

- (void)loadQuestionList;

@end

NS_ASSUME_NONNULL_END

