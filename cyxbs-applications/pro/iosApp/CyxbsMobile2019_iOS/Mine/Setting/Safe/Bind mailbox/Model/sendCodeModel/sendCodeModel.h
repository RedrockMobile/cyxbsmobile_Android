//
//  sendCodeModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/3.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Netblock)(id info);

@interface sendCodeModel : NSObject

@property (nonatomic, copy) Netblock Block;

- (void)sendCode:(NSString *)code ToEmail:(NSString *)email;

@end

NS_ASSUME_NONNULL_END
