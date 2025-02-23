//
//  UserPublishModel.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/5/10.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**用户发布模型
 * 使用文档已出
 * 只做模型，什么都不做
 * 因为此类多为继承，不放入pch
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 用户发布模型
@interface UserPublishModel <OtherType> : NSObject

/// 作者，也是用户
@property (nonatomic, copy, nullable) NSString *author;

/// 作者学号，也可是其他用于标识此人的String
@property (nonatomic, copy, nullable) NSString *identify;

/// 头像的URL
@property (nonatomic, copy, nullable) NSString *headURL;

/// 发布的日期
@property (nonatomic, copy, nullable) NSString *uploadDate;

/// 发布的标题
@property (nonatomic, copy, nullable) NSString *title;

/// 副标题（一般没需求就不用使用了）
@property (nonatomic, copy, nullable) NSString *subTitle;

/// 内容简介
@property (nonatomic, copy, nullable) NSString *content;

/// 文章地址（用于如果是加载h5时）
@property (nonatomic, copy, nullable) NSString *articleURL;

/// 用于存其他奇奇怪怪的东西
@property (nonatomic, copy, nullable) OtherType otherThings;

@end

NS_ASSUME_NONNULL_END
