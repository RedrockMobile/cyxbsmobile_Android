//
//  FTEmptyView.m
//  FinTest
//
//  Created by 郭蕴尧 on 2018/3/7.
//  Copyright © 2018年 Pactera. All rights reserved.
//

#import "FTEmptyView.h"

@implementation FTEmptyView

+ (instancetype)diyEmptyView {
    
    return [FTEmptyView emptyViewWithImageStr:@"my_icon_qyz" titleStr:@"暂无数据" detailStr:@"231"];
    
}

+ (instancetype)diyEmptyActionViewWithTarget:(id)target action:(SEL)action {
    return [FTEmptyView emptyActionViewWithImageStr:@"" titleStr:@"无网络连接" detailStr:@"请检查你的网络连接是否正确" btnTitleStr:@"重新加载" target:target action:action];
}

- (void)prepare {
    [super prepare];
    
    self.autoShowEmptyView = NO;
}

@end
