//
//  WYCClassAndRemindDataModel.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/3/8.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import "WYCClassAndRemindDataModel.h"

//[responseObject objectForKey:@"data"]
@interface WYCClassAndRemindDataModel()
/// 未解析的课表数据
@property (nonatomic, strong)NSArray *rowDataArray;
/// 数组内放着 初始化备忘模型时传入的字典
@property (nonatomic, strong)NSMutableArray *noteDateDictArr;
@end

@implementation WYCClassAndRemindDataModel

- (instancetype)initWithType:(ScheduleType)type {
    self = [super init];
    if (self) {
        if (type==ScheduleTypePersonal) {
            self.rowDataArray = [NSArray arrayWithContentsOfFile:rowDataArrPath];
            self.noteDateDictArr = [[NSMutableArray alloc] init];
            //清除旧的课表数据，等过几版后，去掉这个代码
            [self clear];
        }
    }
    return self;
}

//@"Documents/lesson.plist"
//@"Documents/remind.plist"
//清除旧的课表数据，等过几版后，去掉这个代码
- (void)clear{
//    NSLog(@"%@",[[NSFileManager defaultManager] subpathsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]]);
    NSFileManager *man = [NSFileManager defaultManager];
    
    //删除课表数据
    [man removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/lesson.plist"] error:nil];
    
    //移动备忘数据
    [man moveItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/remind.plist"] toPath:remDataArrPath error:nil];
    
//    NSLog(@"%@",[[NSFileManager defaultManager] subpathsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]]);
}

/// 查个人课表用这个方法,它会先加载本地数据，再调去用getPersonalClassBookArrayFromNet方法来网络请求数据
/// @param stuNum 学号
- (void)getPersonalClassBookArrayWithStuNum:(NSString*)stuNum{
    //先取出本地的课表数据
    if (AllowCaching) {
        [self getLocalPersonalClassBookArray];
    }
    
    //再通过网络请求获取课表数据，如果请求的数据和本地不一样且请求数据非空那么通知代理数据加载成功
    [self getPersonalClassBookArrayFromNet:stuNum];
}

- (void)getLocalPersonalClassBookArray{
    self.orderlySchedulArray = [NSMutableArray arrayWithContentsOfFile:parsedDataArrPath];
    //如果本地存储的课表数据非空，那么通知代理数据加载成功
    if(self.orderlySchedulArray!=nil){
        [self.delegate ModelDataLoadSuccess];
    }
}

/// 通过网络请求获取个人课表数据用这个方法，如果请求的数据和本地不一样且请求数据非空那么刷新课表
/// @param stuNum 学号
- (void)getPersonalClassBookArrayFromNet:(NSString *)stuNum{
    NSDictionary *paramDict = @{@"stu_num":stuNum};
    
    [HttpTool.shareTool
     request:RisingSchedule_POST_stuSchedule_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:paramDict
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        //拿到课表数据
        NSArray *rowLessonDataArr = object[@"data"];
        if (rowLessonDataArr == nil) {
            rowLessonDataArr = @[];
        }
        //储存当前周数，计算开学日期
        [self storeDate:[NSString stringWithFormat:@"%@", object[@"nowWeek"]]];
        
        if (AllowCaching) {
            //如果没有数据，或者数据和本地数据一样，那么return
            if (rowLessonDataArr == nil || [rowLessonDataArr isEqualToArray:self.rowDataArray]) {
                return;
            }
        }
        
        //保存未解析的课表数据
        [rowLessonDataArr writeToFile:rowDataArrPath atomically:YES];
        
        //解析课表数据
        [self parseClassBookData:rowLessonDataArr];
        
        //保存已解析的课表数据到文件
        [self.orderlySchedulArray writeToFile:parsedDataArrPath atomically:YES];
        
        //通知代理数据加载完毕
        [self.delegate ModelDataLoadSuccess];
        
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //通知代理数据加载失败
        [self.delegate ModelDataLoadFailure];
    }];

//    [self.afhttpSeMan POST:ClassSchedule_POST_keBiao_API parameters:paramDict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        //拿到课表数据
//        NSArray *rowLessonDataArr = responseObject[@"data"];
//        if (rowLessonDataArr==nil) {
//            rowLessonDataArr = @[];
//        }
//        //储存当前周数，计算开学日期
//        [self storeDate:[NSString stringWithFormat:@"%@",responseObject[@"nowWeek"]]];
//
//        //如果没有数据，或者数据和本地数据一样，那么return
//        if (rowLessonDataArr==nil||[rowLessonDataArr isEqualToArray:self.rowDataArray]) {
//            return;
//        }
//
//        //保存未解析的课表数据
//        [rowLessonDataArr writeToFile:rowDataArrPath atomically:YES];
//
//        //解析课表数据
//        [self parseClassBookData:rowLessonDataArr];
//
//        //保存已解析的课表数据到文件
//        [self.orderlySchedulArray writeToFile:parsedDataArrPath atomically:YES];
//
//        //通知代理数据加载完毕
//        [self.delegate ModelDataLoadSuccess];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //通知代理数据加载失败
//        [self.delegate ModelDataLoadFailure];
//    }];
}

/// 查同学课表用这个方法来网络请求
/// @param stu_Num 学号
- (void)getClassBookArrayFromNet:(NSString *)stu_Num{
    NSDictionary *parameters = @{@"stu_num":stu_Num};
    
    [HttpTool.shareTool
     request:RisingSchedule_POST_stuSchedule_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:parameters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        //拿到课表数据
        NSArray *lessonArray = [object objectForKey:@"data"];
        if (lessonArray == nil) {
            lessonArray = @[];
        }
        //解析课表数据
        [self parseClassBookData:lessonArray];
        
        //通知代理数据加载成功
        [self.delegate ModelDataLoadSuccess];
        
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //通知代理数据加载失败
        [self.delegate ModelDataLoadFailure];
    }];
    
//    [self.afhttpSeMan POST:ClassSchedule_POST_keBiao_API parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//
//        //拿到课表数据
//        NSArray *lessonArray = [responseObject objectForKey:@"data"];
//        if (lessonArray==nil) {
//            lessonArray = @[];
//        }
//        //解析课表数据
//        [self parseClassBookData:lessonArray];
//
//        //通知代理数据加载成功
//        [self.delegate ModelDataLoadSuccess];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        //通知代理数据加载失败
//        [self.delegate ModelDataLoadFailure];
//    }];
}


/// 查老师课表用这个方法来网络请求
/// @param parameters 参数结构： @{ @"teaName": name, @"tea": teaNum }
- (void)getTeaClassBookArrayFromNet:(NSDictionary*)parameters{

    [HttpTool.shareTool
     request:RisingSchedule_POST_teaSchedule_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:parameters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        
        //拿到课表数据
        NSArray *lessonArray = [object objectForKey:@"data"];
        
        if (lessonArray==nil) {
            lessonArray = @[];
        }
        //解析课表数据
        [self parseClassBookData:lessonArray];
        
        //通知代理数据加载成功
        [self.delegate ModelDataLoadSuccess];
        
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //通知代理数据加载失败
        [self.delegate ModelDataLoadFailure];
        
    }];
    
//    [self.afhttpSeMan POST:ClassSchedule_POST_teaKeBiao_API parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//
//        //拿到课表数据
//        NSArray *lessonArray = [responseObject objectForKey:@"data"];
//        if (lessonArray==nil) {
//            lessonArray = @[];
//        }
//        //解析课表数据
//        [self parseClassBookData:lessonArray];
//
//        //通知代理数据加载成功
//        [self.delegate ModelDataLoadSuccess];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        //通知代理数据加载失败
//        [self.delegate ModelDataLoadFailure];
//    }];
}

/// 没课约查多人课表用底下的这个方法
/// @param infoDictArray n个人的信息字典组成的数组，信息只用到了@"stuNum"对应的value
//信号量+栅栏函数
- (void)getClassBookArrayFromNetWithInfoDictArr:(NSArray*)infoDictArray{
    
    //用来存储多人课表数组的数组
    __block NSMutableArray *lessonOfAllPeople = [infoDictArray mutableCopy];
    
    //创建一个并行队列
    dispatch_queue_t que = dispatch_queue_create("weDate2", DISPATCH_QUEUE_CONCURRENT);
    
    //创建一个信号量，这里把信号量的创建放在这里和放在dispatch_group_async里面是等价的，
    //因为wait和signal是一一对应的，在其他地方有可能会不等价，
    //因为第x层循环的wait收到的信号有可能是第y层循环发出的
    //验证方法：在wait后面加上代码：NSLog(@"%@",lessonOfAllPeople[i]);
    //会发现有时候打印出来的并不是课表数据
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    //infoDict是infoDictArray的数组元素
    NSDictionary *infoDict;
    
    __block BOOL isAllSuccess = YES;
    
    int i,count = (int)infoDictArray.count;
    for (i = 0; i<count; i++) {
        infoDict = infoDictArray[i];
        dispatch_async(que, ^{
            
            [HttpTool.shareTool
             request:RisingSchedule_POST_stuSchedule_API
             type:HttpToolRequestTypePost
             serializer:HttpToolRequestSerializerHTTP
             bodyParameters:@{@"stuNum":infoDict[@"stuNum"]}
             progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
                
                NSArray *lessonArray = [object objectForKey:@"data"];
                //查很久以前的重邮学生时，lessonArray会是空的，所以如果不加判断，就会导致崩溃
                if (lessonArray == nil) {
                    lessonOfAllPeople[i] = @[];
                }else {
                    lessonOfAllPeople[i] = lessonArray;
                }
                dispatch_semaphore_signal(semaphore);
                
            }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                isAllSuccess = NO;
                dispatch_semaphore_signal(semaphore);
            }];
//            [self.afhttpSeMan POST:ClassSchedule_POST_keBiao_API parameters:@{@"stuNum":infoDict[@"stuNum"]} headers:nil progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//                NSArray* lessonArray = [responseObject objectForKey:@"data"];
//                //查很久以前的重邮学生时，lessonArray会是空的，所以如果不加判断，就会导致崩溃
//                if (lessonArray==nil) {
//                    lessonOfAllPeople[i] = @[];
//                }else {
//                    lessonOfAllPeople[i] = lessonArray;
//                }
//                dispatch_semaphore_signal(semaphore);
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                isAllSuccess = NO;
//                dispatch_semaphore_signal(semaphore);
//            }];
            dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC));
        });
    }
    
    dispatch_barrier_async(que, ^{
        if(isAllSuccess==YES){
            NSMutableArray *tmp = [[NSMutableArray alloc] init];
            for (NSArray *arr in lessonOfAllPeople) {
                [tmp addObjectsFromArray:arr];
            }
            [self parseClassBookData:tmp];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate ModelDataLoadSuccess];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate ModelDataLoadFailure];
            });
        }
    });
}

///添加备忘模型
- (void)addNoteDataWithModel:(NoteDataModel*)model{
    [self.noteDateDictArr addObject:model.noteDataDict];
    for (NSNumber *weekNum in model.weeksArray) {
        if (weekNum.intValue==0) {
            //整学期
            for (int i=0; i<=weekCnt; i++) {
                [self.noteDataModelArray[i] addObject:model];
            }
        }else {
            [self.noteDataModelArray[weekNum.intValue] addObject:model];
        }
    }
    [self.noteDateDictArr writeToFile:remDataArrPath atomically:YES];
}

///删除备忘模型
- (void)deleteNoteDataWithModel:(NoteDataModel*)model{
    [self.noteDateDictArr removeObject:model.noteDataDict];
    for (NSNumber *weekNum in model.weeksArray) {
        if (weekNum.intValue==0) {
            //整学期
            for (int i=0; i<=weekCnt; i++) {
                [self.noteDataModelArray[i] removeObject:model];
            }
        }else {
            [self.noteDataModelArray[weekNum.intValue] removeObject:model];
        }
    }
    [self.noteDateDictArr writeToFile:remDataArrPath atomically:YES];
}

/// 备忘模型数组的懒加载
- (NSMutableArray *)noteDataModelArray{
    if(_noteDataModelArray==nil){
        NSMutableArray *modelArray = [NSMutableArray array];
        for (int i=0; i<=weekCnt; i++) {
            [modelArray addObject:[NSMutableArray array]];
        }
        
        NSArray *rowData = [NSMutableArray arrayWithContentsOfFile:remDataArrPath];
        for (NSDictionary *noteDataDict in rowData) {
            NoteDataModel *model = [[NoteDataModel alloc]initWithNoteDataDict:noteDataDict];
            for (NSNumber *weekNum in model.weeksArray) {
                if (weekNum.intValue==0) {
                    //整学期
                    [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [obj addObject:model];
                    }];
                }else {
                    [modelArray[weekNum.intValue] addObject:model];
                }
            }
        }
        
        _noteDataModelArray = modelArray;
        
        if(_noteDataModelArray==nil){
            _noteDataModelArray = [@[] mutableCopy];
        }
    }
    return _noteDataModelArray;
}


//MARK:-数据解析&处理
/// 解析未经处理的课表数据
/// @param array 结构同[responseObject objectForKey:@"data"]
- (void)parseClassBookData:(NSArray *)array{
    //初始化orderlySchedulArray
    [self initOrderlySchedulArray];
    NSNumber *hash_day,*hash_lesson;
    NSArray *weeks;
    for (NSDictionary *couseDataDict in array) {
        weeks = couseDataDict[@"week"];
        hash_day = couseDataDict[@"hash_day"];
        hash_lesson = couseDataDict[@"hash_lesson"];
        //为整学期页的设置数据
        if (hash_day.intValue >= 0 && hash_lesson.intValue >= 0) {
            [self.orderlySchedulArray[0][hash_day.intValue][hash_lesson.intValue] addObject:couseDataDict];
        }
        //为后面有课的周设置数据
        if ([weeks isKindOfClass:NSArray.class]) {
            for (NSNumber *weekNum in weeks) {
                if (hash_day.intValue >= 0 && hash_lesson.intValue >= 0) {
                    [self.orderlySchedulArray[weekNum.intValue][hash_day.intValue][hash_lesson.intValue] addObject:couseDataDict];
                }
            }
        }
    }
}

//初始化orderlySchedulArray
- (void)initOrderlySchedulArray{
    //如果非空，那么清空
    if(self.orderlySchedulArray!=nil){
        for (NSMutableArray *week in self.orderlySchedulArray) {
            for (NSMutableArray *day in week) {
                for (NSMutableArray *lesson in day) {
                    [lesson removeAllObjects];
                }
            }
        }
    }else{
        //如果为空那么创建
        //整学期
        self.orderlySchedulArray = [NSMutableArray array];
        for (int i=0; i<26; i++) {
            //某一周
            NSMutableArray *week = [NSMutableArray array];
            for (int j=0; j<7; j++) {
                //某一周的某一天
                NSMutableArray *day = [NSMutableArray array];
                for (int k=0; k<6; k++) {
                    //某一周的某一天的某一节课，它是数组
                    NSMutableArray *aLesson = [NSMutableArray array];
                    [day addObject:aLesson];
                }
                [week addObject:day];
            }
            [self.orderlySchedulArray addObject:week];
        }
    }
}

//储存当前周数，计算开学日期
- (void)storeDate:(NSString*)week {
    NSDate *now = [NSDate date];
    
    NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:now];
//    unit
    NSInteger weekday = nowComponents.weekday;
    
    NSInteger todaySecond = (((nowComponents.hour*60)+nowComponents.minute)*60)+nowComponents.second;
    
    NSInteger ortherDaySecond = ((week.integerValue-1)*7+(weekday+5)%7)*86400;
    //startDate指向开学日期那天的凌晨1秒
//    NSDate *startDate = [now dateByAddingSeconds:1-(todaySecond+ortherDatSecond)];
        NSDate *startDate = [[NSDate alloc] initWithTimeInterval:1-(todaySecond+ortherDaySecond) sinceDate:now];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:startDate];
    
    [NSUserDefaults.standardUserDefaults setValue:[NSString stringWithFormat:@"%ld-%02ld-%02ld",components.year,components.month,components.day] forKey:DateStartKey_NSString];
    
    [NSUserDefaults.standardUserDefaults setValue:week forKey:nowWeekKey_NSString];
}

@end

//    {
//    "begin_lesson" = 1;
//    classroom = 3212;
//    course = "\U5927\U5b66\U751f\U804c\U4e1a\U53d1\U5c55\U4e0e\U5c31\U4e1a\U6307\U5bfc1";
//    "course_num" = B1220060;
//    day = "\U661f\U671f\U4e00";
//    "hash_day" = 0;
//    "hash_lesson" = 0;
//    lesson = "\U4e00\U4e8c\U8282";
//    period = 2;
//    rawWeek = "1-8\U5468";
//    teacher = "\U9648\U65ed";
//    type = "\U5fc5\U4fee";
//    week =                 (
//    1,
//    2,
//    3,
//    4,
//    5,
//    6,
//    7,
//    8
//    );
//    weekBegin = 1;
//    weekEnd = 8;
//    weekModel = all;
//    }
