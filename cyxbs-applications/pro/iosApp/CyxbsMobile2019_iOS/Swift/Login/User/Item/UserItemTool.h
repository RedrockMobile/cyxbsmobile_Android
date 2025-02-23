//
//  UserItemTool.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/10/24.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserItem.h"

NS_ASSUME_NONNULL_BEGIN

//DEPRECATED_MSG_ATTRIBUTE("\n不要使用UserItemTool来获取你需要的信息，使用UserDefaultTool");
@interface UserItemTool : NSObject <NSSecureCoding>

/// 获取UserItem单例对象
+ (UserItem *)defaultItem;

/// 获取缓存路径
+ (NSString *)userItemPath;

/// 退出登录
+ (void)logout;

@end

NS_ASSUME_NONNULL_END
