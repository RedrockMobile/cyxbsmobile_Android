//
//  ScheduleModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/2.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleModel.h"

typedef struct _ScheduleCombineEntry {
    ScheduleCombineModel *model;
    BOOL isUsing;
} ScheduleCombineEntry;

#pragma mark - ScheduleModel ()

@interface ScheduleModel ()

/// combine映射表
@property (nonatomic, strong) NSMutableDictionary <NSString *, ScheduleCombineModel *> *map;

/// combine状态
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSNumber *> *status;

@end

#pragma mark - ScheduleModel

@implementation ScheduleModel

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _startDate =
        [NSDate dateWithString:[NSUserDefaults.standardUserDefaults stringForKey:RisingClassSchedule_classBegin_String] format:@"yyyy.M.d"];
        
        self.nowWeek = [NSUserDefaults.standardUserDefaults stringForKey:RisingClassSchedule_nowWeek_Integer].unsignedLongValue;
        
        _courseAry = NSMutableArray.array;
        [_courseAry addObject:NSMutableArray.array]; // For 0 Section
    }
    return self;
}

#pragma mark - Method

- (void)_appendCourse:(ScheduleCourse *)course {
    NSParameterAssert(course);
    
    [course.inSections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * __unused stop) {
        NSUInteger section = obj.unsignedLongValue;
        
        for (NSUInteger i = _courseAry.count; i <= section; i++) {
            [_courseAry addObject:NSMutableArray.array];
        }
        
        [_courseAry[section] addObject:course];
    }];
    
    [_courseAry[0] addObject:course];
}

- (void)_removeCourse:(ScheduleCourse *)course {
    NSParameterAssert(course);
    
    [course.inSections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * __unused stop) {
        NSUInteger section = obj.unsignedLongValue;
        
        [_courseAry[section] removeObject:course];
    }];
    
    [_courseAry[0] removeObject:course];
}

- (void)combineModel:(ScheduleCombineModel *)model {
    NSParameterAssert(model);
    NSAssert(!self.status[model.identifier], @"\n🔴%s status : %d, map : %@", __func__,  [self.status[model.identifier] boolValue], self.map);
    
    self.map[model.identifier] = model;
    self.status[model.identifier] = @YES;
    self.nowWeek = model.nowWeek;
    
    for (ScheduleCourse *course in model.courseAry) {
        [self _appendCourse:course];
    }
    
    return;
}

- (void)recombineWithIdentifier:(NSString *)identifier {
    NSParameterAssert(identifier);
    
    ScheduleCombineModel *model = self.map[identifier];
    NSParameterAssert(model);
    
    if ([self.status[identifier] isEqualToNumber:@YES]) {
        [self separateModel:model];
    }
    
    self.status[model.identifier] = @YES;
    
    for (ScheduleCourse *course in model.courseAry) {
        [self _appendCourse:course];
    }
    
    return;
}

- (void)separateModel:(ScheduleCombineModel *)model {
    NSParameterAssert(model);
    NSAssert(self.map[model.identifier], @"\n🔴%s id : %@, map : %@", __func__, model.identifier, self.map);
    
    self.status[model.identifier] = @NO;
    
    for (ScheduleCourse *course in model.courseAry) {
        [self _removeCourse:course];
    }
    
    return;
}

#pragma mark - Setter

- (void)setNowWeek:(NSUInteger)nowWeek {
    _nowWeek = nowWeek;
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        
        [NSUserDefaults.standardUserDefaults setInteger:_nowWeek forKey:RisingClassSchedule_nowWeek_Integer];
        
        NSDate *date = NSDate.today;
        
        NSTimeInterval beforNow = (_nowWeek - 1) * 7 * 24 * 60 * 60 + (date.weekday - 2) * 24 * 60 * 60;
        _startDate = [NSDate dateWithTimeIntervalSinceNow:-beforNow];
//    });
}

@end
