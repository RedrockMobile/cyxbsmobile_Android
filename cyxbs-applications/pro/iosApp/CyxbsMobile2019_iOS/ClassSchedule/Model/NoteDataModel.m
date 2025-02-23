//
//  NoteDataModel.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/21.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "NoteDataModel.h"

@implementation NoteDataModel
- (instancetype)initWithNoteDataDict:(NSDictionary*)noteDataDict{
    self = [super init];
    if(self){
        //init时传入的字典
        self.noteDataDict = noteDataDict;
        
        //备忘标题
        self.noteTitleStr = noteDataDict[@"noteTitleStr"];
        
        //备忘详情
        self.noteDetailStr = noteDataDict[@"noteDetailStr"];
        
        //"不提醒"，@“提前5分钟”...
        self.notiBeforeTime = noteDataDict[@"notiBeforeTime"];
        
        //@["第一周"，@“第二周”]...
        self.weeksStrArray = noteDataDict[@"weeksStrArray"];
        
        ///@[
        ///     @{@"weekString":@"周一",  @"lessonString":@"一二节课"}
        ///     @{@"weekString":@"周日",  @"lessonString":@"十一十二节课"}
        ///     .........
        ///     .....
        ///@]
        self.timeStrDictArray = noteDataDict[@"timeStrDictArray"];
        
        self.weekNameStr = noteDataDict[@"weekNameStr"];
        
        self.weeksArray = [self transferWSAWithArray:self.weeksStrArray];
        
        self.timeDictArray = [self transferTSDAWithArray:self.timeStrDictArray];
        
        self.noteID = [self getNoteID];
        NSDictionary *transfer = @{
            @"不提醒":@0,
            @"提前五分钟":@5,
            @"提前十分钟":@10,
            @"提前二十分钟":@20,
            @"提前三十分钟":@30,
            @"提前一小时":@60
        };
        self.notiBeforeTimeLenth = [transfer[self.notiBeforeTime] intValue];
    }
    return self;
}

/// @[@4,@1,@18]代表第4、1、18周的备忘，0代表整学期
- (NSArray*)transferWSAWithArray:(NSArray*)weeksStrArray{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *standStrArray = @[@"整学期", @"第一周", @"第二周", @"第三周", @"第四周", @"第五周", @"第六周", @"第七周", @"第八周", @"第九周", @"第十周", @"第十一周", @"第十二周", @"第十三周", @"第十四周", @"第十五周", @"第十六周", @"第十七周", @"第十八周", @"第十九周", @"第二十周", @"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"];
    
    NSDictionary *transfer = [self getTransferWithStrArray:standStrArray];
    
    for (NSString *str in weeksStrArray) {
        [array addObject:transfer[str]];
    }
    
    return array;
}

/// @[
///     @{@"weekNum":@0,  @"lessonNum":@2},
///     @{@"weekNum":@1,  @"lessonNum":@0}
/// ]
///代表某周的周一 第3节大课和周二的第一节大课的备忘
- (NSArray*)transferTSDAWithArray:(NSArray*)timeStrDictArray{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *standLessonStrArr = @[@"一二节课",@"三四节课",@"五六节课",@"七八节课",@"九十节课",@"十一十二节课"];
    NSArray *standWeekStrArr =
    @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSDictionary *lessonTransfer = [self getTransferWithStrArray:standLessonStrArr];
    NSDictionary *weekTransfer = [self getTransferWithStrArray:standWeekStrArr];
    
    for (NSDictionary *timeStrDict in timeStrDictArray) {
        [array addObject:@{
            @"weekNum":weekTransfer[timeStrDict[@"weekString"]],
            @"lessonNum":lessonTransfer[timeStrDict[@"lessonString"]],
        }];
    }
    
    return array;
}

- (NSDictionary*)getTransferWithStrArray:(NSArray*)strArray{
    NSMutableDictionary *transfer = [NSMutableDictionary dictionary];
    int count = (int)strArray.count,i;
    
    for (i=0; i<count; i++) {
        [transfer setValue:[NSNumber numberWithInt:i] forKey:strArray[i]];
    }
    
    return transfer;
}
//@{@"weekString":@"",  @"lessonString":@""}

/// 依据添加备忘时的时间来得到一个唯一的noteID，
- (NSString*)getNoteID{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-M-d";
    
    NSDate *date2020_01_01 = [formate dateFromString:@"2020-01-01"];

    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *compsday = [calender components:NSCalendarUnitDay fromDate:date2020_01_01 toDate:now options:0];

    //得到2020和今日隔了几天
    long interval = [compsday day];

    formate.dateFormat = @"MMddHHmmss";
    return [NSString stringWithFormat:@"%ld%@",interval,[formate stringFromDate:now]];
}
@end
