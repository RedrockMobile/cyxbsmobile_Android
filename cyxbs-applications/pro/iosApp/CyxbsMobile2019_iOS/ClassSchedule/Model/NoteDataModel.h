//
//  NoteDataModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/21.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoteDataModel : NSObject
- (instancetype)initWithNoteDataDict:(NSDictionary*)noteDataDict;


/// @[@4,@1,@18]代表第4、1、18周的备忘
@property(nonatomic,strong)NSArray <NSNumber*> *weeksArray;

/// @[
///     @{@"weekNum":@0,  @"lessonNum":@2},
///     @{@"weekNum":@1,  @"lessonNum":@0}
/// ]
///代表某周的周一 第3节大课和周二的第一节大课的备忘
@property(nonatomic,strong)NSArray <NSDictionary*> *timeDictArray;

/// 备忘标题
@property(nonatomic,copy)NSString *noteTitleStr;

/// 备忘详情
@property(nonatomic,copy)NSString *noteDetailStr;

//(
//                {
        //        class = 2; 第几节课
        //        day = 6;
        //        week = (1,2,3 )
    //            }
//);

/// 结构：
/// @[@{}@{}]
@property(nonatomic,strong)NSArray *noteTimeDataArr;

/// @"不提醒"，@“提前5分钟”。。
@property(nonatomic,strong)NSString *notiBeforeTime;
///5、10、20、30、60
@property(nonatomic,assign)int notiBeforeTimeLenth;

///@[@"第一周"，@“第二周”]
@property(nonatomic,strong)NSArray <NSString*> *weeksStrArray;

///@[
///     @{@"weekString":@"周一",  @"lessonString":@"一二节课"}
///     @{@"weekString":@"周日",  @"lessonString":@"十一十二节课"}
///     .........
///     .....
///@]
@property(nonatomic,strong)NSArray <NSDictionary*> *timeStrDictArray;

/// init时传入的字典
@property(nonatomic,strong)NSDictionary *noteDataDict;

/// 备忘ID
@property(nonatomic,copy)NSString *noteID;

/// 点击第x周的空白处进行添加备忘，那么weekNameStr就是@“第x周”
@property(nonatomic,copy)NSString *weekNameStr;

- (NSString*)getNoteID;
@end

NS_ASSUME_NONNULL_END
