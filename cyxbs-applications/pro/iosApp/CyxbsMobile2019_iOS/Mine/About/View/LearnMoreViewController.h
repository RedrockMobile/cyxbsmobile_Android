//
//  LearnMoreViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/12/18.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "TopBarBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LMVCTypeServiceAgreement,
    LMVCTypePrivacyClause,
} LMVCType;


@interface LearnMoreViewController : TopBarBasicViewController
- (instancetype)initWithType:(LMVCType)type;
@end

NS_ASSUME_NONNULL_END
