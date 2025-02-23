//
//  changePassword.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/2.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Netblock)(id info);

@interface changePassword : NSObject

@property (nonatomic, copy) Netblock Block;

- (void)changePasswordWithNewPassword:(NSString *)password :(NSString *)stuId :(NSString *) code;

@end

NS_ASSUME_NONNULL_END
