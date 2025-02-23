//
//  MineUserInfoModel.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/10/28.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MineUserInfoModel.h"
//开启CCLog
#define CCLogEnable 0

//NSUserDefaults的Key，可以取出对应的NSData
#define MineUserInfoModelUserDefaultsKey @"MineUserInfoModelUserDefaultsKey"

@implementation MineUserInfoModel

static MineUserInfoModel *_modelInstance;
static dispatch_once_t _onceToken = 0;

- (void)synchronizeDataToFile {
    [NSUserDefaults.standardUserDefaults setValue:[NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:YES error:nil] forKey:MineUserInfoModelUserDefaultsKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

//MARK: - 实现单例必要的方法：
+ (instancetype)shareModel {
    if (_modelInstance==nil) {
        [self allocWithZone:nil];
        [NSKeyedUnarchiver unarchivedObjectOfClass:MineUserInfoModel.class fromData:[NSUserDefaults.standardUserDefaults valueForKey:MineUserInfoModelUserDefaultsKey] error:nil];
    }
    return _modelInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    //在allocWithZone内部调用任何会产生新实例对象的方法，要避免死递归的发生，
    //因为产生新对象必定会调用allocWithZone：
    dispatch_once(&_onceToken, ^{
        //用其他alloc方法会崩溃，因为循环调用同一个dispatch_once
        _modelInstance = [[super allocWithZone:nil] init];
        if (_modelInstance) {
            [[NSNotificationCenter defaultCenter] addObserver:_modelInstance selector:@selector(userDidLogOut) name:@"UserDidLogOut" object:nil];
        }
    });
    return _modelInstance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _modelInstance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _modelInstance;
}

- (void)userDidLogOut {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:MineUserInfoModelUserDefaultsKey];
    _modelInstance = nil;
    _onceToken = 0;
}

//网络请求获取数据
- (void)updateUserInfoCompletion:(void(^)(MineUserInfoModelUpdateUserInfoState state))callBack {
    dispatch_queue_t que = dispatch_queue_create("MineUserCntDataModel", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    MineUserInfoModel *model = [MineUserInfoModel shareModel];
    
    NSArray *timeKeyArr = @[remarkLastClickTimeKey_NSInteger, praiseLastClickTimeKey_NSInteger];
    NSString *syncKey = @"MineUserInfoModelNetStateSyncKey";
    __block int state = 0;
    for (int i=0; i<2; i++) {
        dispatch_async(que, ^{
            //获取上次点击进入 获赞/评论 页面的时间
            NSInteger t = [NSUserDefaults.standardUserDefaults integerForKey:timeKeyArr[i]];
            if (t==0) {
                //如果取出来的时间是0，那么把时间设置成3天前。
                t = (NSInteger)([NSDate.date timeIntervalSince1970]-259200);
            }
            NSString *timeStr = [NSString stringWithFormat:@"%ld", t];
            
            //type为1，代表点赞页
            //type为2，代表评论页
            NSDictionary *paramDict = @{
                @"time":timeStr,
                @"type":@(i+1),
            };
            
            [HttpTool.shareTool
             request:Mine_GET_getMsgCnt_API
             type:HttpToolRequestTypeGet
             serializer:HttpToolRequestSerializerHTTP
             bodyParameters:paramDict
             progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
                NSDictionary *dataDict = object[@"data"];
                if (dataDict==nil) {
                }else if (i==0) {
                    model.hasNewRemark = [dataDict[@"uncheckedComment"] intValue] > 0;
                    @synchronized (syncKey) {
                        state |= 0b1;
                    }
                }else if (i==1) {
                    @synchronized (syncKey) {
                        state |= 0b10;
                    }
                    model.hasNewPraise = [dataDict[@"uncheckedPraise"] intValue] > 0;
                }
                CCLog(@"%dresp::%@", i, object);
                dispatch_semaphore_signal(sema);
            }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                CCLog(@"error::%@", error);
                dispatch_semaphore_signal(sema);
            }];
//            //用自定义AFHTTPSessionManager，因为这里用了多线程，用HttpClient怕有多线程的问题
//            AFHTTPSessionManager *man = [self getHTTPSessionManager];
//            [man GET:Mine_GET_getMsgCnt_API parameters:paramDict success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSDictionary *dataDict = responseObject[@"data"];
//                if (dataDict==nil) {
//                }else if (i==0) {
//                    model.hasNewRemark = [dataDict[@"uncheckedComment"] intValue] > 0;
//                    @synchronized (syncKey) {
//                        state |= 0b1;
//                    }
//                }else if (i==1) {
//                    @synchronized (syncKey) {
//                        state |= 0b10;
//                    }
//                    model.hasNewPraise = [dataDict[@"uncheckedPraise"] intValue] > 0;
//                }
//                CCLog(@"%dresp::%@", i, responseObject);
//                dispatch_semaphore_signal(sema);
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                CCLog(@"error::%@", error);
//                dispatch_semaphore_signal(sema);
//            }];
            
            dispatch_semaphore_wait(sema, dispatch_time(DISPATCH_TIME_NOW, (int64_t)20*NSEC_PER_SEC));
        });
    }
    
    dispatch_async(que, ^{
        NSString *redidStr = [[UserItem defaultItem] redid];
        if (redidStr==nil) {
            CCLog(@"nil");
            return;
        }
        NSString *url = [CyxbsMobileBaseURL_1 stringByAppendingPathComponent:@"magipoke-loop/user/getUserCount"];
        
        //@"https://be-prod.redrock.cqupt.edu.cn/magipoke-loop/user/getUserCount";
        //@"https://be-dev.redrock.cqupt.edu.cn/magipoke-loop/user/getUserCount";
        
        [HttpTool.shareTool request:url type:HttpToolRequestTypeGet serializer:HttpToolRequestSerializerHTTP bodyParameters:@{@"redid":redidStr} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            [model mj_setKeyValues:object[@"data"]];
            @synchronized (syncKey) {
                state |= 0b100;
            }
            CCLog(@"resp::%@", object);
            dispatch_semaphore_signal(sema);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            CCLog(@"error::%@", error);
            dispatch_semaphore_signal(sema);
        }];
        
//        AFHTTPSessionManager *man = [self getHTTPSessionManager];
//        [man GET:url parameters:@{@"redid":redidStr} success:^(NSURLSessionDataTask *task, id responseObject) {
//            [model mj_setKeyValues:responseObject[@"data"]];
//            @synchronized (syncKey) {
//                state |= 0b100;
//            }
//            CCLog(@"resp::%@", responseObject);
//            dispatch_semaphore_signal(sema);
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            CCLog(@"error::%@", error);
//            dispatch_semaphore_signal(sema);
//        }];
        
        dispatch_semaphore_wait(sema, dispatch_time(DISPATCH_TIME_NOW, (int64_t)20*NSEC_PER_SEC));
    });
    
    
    dispatch_barrier_async(que, ^{
        dispatch_main_async_safe(^{
            [self synchronizeDataToFile];
            if (callBack) {
                callBack(state==0b111);
            }
        })
    });
}

//- (AFHTTPSessionManager*)getHTTPSessionManager {
//    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
//    man.requestSerializer = [AFHTTPRequestSerializer serializer];
//    NSString *token = [UserItem defaultItem].token;
//    if (token) {
//        [man.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token]  forHTTPHeaderField:@"authorization"];
//    }
//    man.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",@"application/x-www-form-urlencoded", nil]];
//    return man;
//}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self mj_keyValues]];
}


+ (BOOL)supportsSecureCoding {
    return YES;
}

//MARK: - MJExtension相关：
//MJ解归档的实现：
MJCodingImplementation

//覆盖原有的mj_decode:方法，具体原因见方法体
- (void)mj_decode:(NSCoder *)decoder
{
    Class clazz = [self class];
    
    NSArray *allowedCodingPropertyNames = [clazz mj_totalAllowedCodingPropertyNames];
    NSArray *ignoredCodingPropertyNames = [clazz mj_totalIgnoredCodingPropertyNames];
    
    [clazz mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
        // 检测是否被忽略
        if (allowedCodingPropertyNames.count && ![allowedCodingPropertyNames containsObject:property.name]) return;
        if ([ignoredCodingPropertyNames containsObject:property.name]) return;
        
        // fixed `-[NSKeyedUnarchiver validateAllowedClass:forKey:] allowed unarchiving safe plist type ''NSNumber'(This will be disallowed in the future.)` warning.
        id value = [decoder decodeObjectOfClasses:[NSSet setWithObjects:NSNumber.class, property.type.typeClass, nil] forKey:property.name];
        //旧版的这个方法里面是这句：id value = [decoder decodeObjectForKey:property.name];
        //会导致控制台打印一大串东西，最新版的MJExtesionDemo已经解决了这个问题，
        //但是 pod 安装最新版本的MJExtesion并没有解决这个问题，所以暂时这么做，
        //等后面的MJExtesion解决这个问题后，可以删除这个代码。
        if (value == nil) { // 兼容以前的MJExtension版本
            value = [decoder decodeObjectForKey:[@"_" stringByAppendingString:property.name]];
        }
        if (value == nil) return;
        [property setValue:value forObject:self];
    }];
}


//+ (NSArray *)mj_ignoredCodingPropertyNames {
//    return @[@"hasInitFromFile"];
//}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"blogCnt":@"dynamic",
        @"remarkCnt":@"comment",
        @"praiseCnt":@"praise",
//        @"nickNameStr":@"nickname",
//        @"mottoStr":@"introduction",
    };
}


@end
