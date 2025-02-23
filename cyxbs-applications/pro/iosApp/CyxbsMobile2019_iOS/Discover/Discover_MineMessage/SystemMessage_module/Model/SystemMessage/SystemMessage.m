//
//  SystemMessage.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SystemMessage.h"

#pragma mark - SystemMessage

@implementation SystemMessage

#pragma mark - Life cycle

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.otherThings = [dic[@"id"] stringValue];
        self.articleURL = Discover_HTML_md_API(self.otherThings);
        self.identify = dic[@"stu_num"];
        self.title = dic[@"title"];
        self.uploadDate = [[NSDate dateString:[dic[@"date"] substringToIndex:10] fromFormatter:NSDateFormatter.defaultFormatter withDateFormat:@"yyyy-MM-dd"] stringFromFormatter:NSDateFormatter.defaultFormatter withDateFormat:@"yyyy-M-d"];
        self.author = dic[@"user_name"];
        self.headURL = dic[@"user_head_url"];
        self.content = dic[@"content"];
        self.hadRead = [dic[@"has_read"] boolValue];
    }
    return self;
}

@end
