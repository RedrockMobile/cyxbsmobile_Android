//
//  sendEmailModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Netblock)(id info);

@interface sendEmailModel : NSObject

@property (nonatomic, copy) Netblock Block;

- (void)sendEmail:(NSString *)email;


@end

NS_ASSUME_NONNULL_END
