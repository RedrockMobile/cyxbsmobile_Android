//
//  questionAndEmail.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/31.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Netblock)(id info);

@interface questionAndEmail : NSObject

@property (nonatomic, copy) Netblock Block;

- (void)isBindEmailAndQuestion;

@end

NS_ASSUME_NONNULL_END
