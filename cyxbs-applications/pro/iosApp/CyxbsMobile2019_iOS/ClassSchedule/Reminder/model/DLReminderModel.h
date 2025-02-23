//
//  DLReminderModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLReminderModel : NSObject
@property (nonatomic, strong) NSNumber *idNum;
@property (nonatomic, strong) NSNumber *day;
@property (nonatomic, strong) NSNumber *classNum;
@property (nonatomic, copy) NSArray *week;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithRemindDict:(NSDictionary *)remind;
//+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
