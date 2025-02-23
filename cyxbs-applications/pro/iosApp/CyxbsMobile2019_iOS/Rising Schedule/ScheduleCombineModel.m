//
//  ScheduleCombineModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleCombineModel.h"

ScheduleCombineType ScheduleCombineSystem = @"system";

ScheduleCombineType ScheduleCombineCustom = @"custom";

#pragma mark - ScheduleCombineModel

@implementation ScheduleCombineModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _courseAry = NSMutableArray.array;
    }
    return self;
}


+ (instancetype)combineWithSno:(NSString *)sno type:(ScheduleCombineType)type {
    BOOL check = ((!sno || sno.length < 2) || (!type));
    if (check) {
        NSAssert(!check, @"\n🔴%s sno : %@, type : %@", __func__, sno, type);
        return nil;
    }
    
    ScheduleCombineModel *model = [[ScheduleCombineModel alloc] init];
    
    model->_sno = sno.copy;
    model->_combineType = type.copy;
    
    return model;
}

- (NSString *)identifier {
    return [NSString stringWithFormat:@"%@%@", _sno, _combineType];
}

@end
