//
//  WYCClassAndRemindDataModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/3/8.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteDataModel.h"

@protocol WYCClassAndRemindDataModelDelegate <NSObject>
//备忘模型加载完毕后调用的两个方法
- (void)ModelDataLoadSuccess;
- (void)ModelDataLoadFailure;
@end


@interface WYCClassAndRemindDataModel : NSObject


@property (nonatomic, weak)id<WYCClassAndRemindDataModelDelegate>delegate;

/// 有序的全部课表，/// orderlySchedulArray[i][j][k]代表（第i周）的（星期j+1）的（第k+1节大课）
/// ,orderlySchedulArray[i][j][k]是一个数组
@property (nonatomic,strong)NSMutableArray *orderlySchedulArray;

/// 备忘模型数组，noteDataModelArray[0]为整学期的备忘模型，noteDataModelArray[1]为第一周
@property (nonatomic, strong)NSMutableArray <NSMutableArray <NoteDataModel*>*> *noteDataModelArray;
- (instancetype)initWithType:(ScheduleType)type;

/// 网络请求获取他人课表，不把课表数据存入本地
/// @param stu_Num 学号
- (void)getClassBookArrayFromNet:(NSString *)stu_Num;

/// 没课约查多人课表用这个方法
/// @param infoDictArray n个人的信息字典组成的数组，信息只用到了@"stuNum"对应的value
- (void)getClassBookArrayFromNetWithInfoDictArr:(NSArray*)infoDictArray;

/// 查个人课表用这个方法,它会先加载本地数据，再调去用getPersonalClassBookArrayFromNet方法来网络请求数据
/// @param stuNum 学号
- (void)getPersonalClassBookArrayWithStuNum:(NSString*)stuNum;

/// 查老师课表要用的方法
/// @param parameters @{
///    @"teaName":@"陈希明",
///    @"tea":@"020101"
/// };
- (void)getTeaClassBookArrayFromNet:(NSDictionary*)parameters;

- (void)addNoteDataWithModel:(NoteDataModel*)model;

- (void)deleteNoteDataWithModel:(NoteDataModel*)model;

@end

//下面三个方法没用上
//- (void)getRemind:(NSString *)stuNum idNum:(NSString *)idNum;
//- (void)getRemindFromNet:(NSString *)stuNum idNum:(NSString *)idNum;
//- (void)deleteRemind:(NSString *)stuNum idNum:(NSString *)idNum remindId:(NSNumber *)remindId;
