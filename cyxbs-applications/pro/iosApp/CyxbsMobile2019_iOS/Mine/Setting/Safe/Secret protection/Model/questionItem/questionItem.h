//
//  questionItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/31.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface questionItem : NSObject

@property (nonatomic ,strong) NSString *questionId;
@property (nonatomic ,strong) NSString *questionContent;

- (instancetype) initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

