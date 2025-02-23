//
//  MainPageModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/3/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    //没有更多数据
    MainPageModelStateNoMoreDate,
    //停止刷新(加载成功)
    MainPageModelStateEndRefresh,
    //加载失败
    MainPageModelStateFailure,
} MainPageModelDataState;

@protocol MainPageModelDelegate <NSObject>
- (void)mainPageModelLoadDataFinishWithState:(MainPageModelDataState) state;
@end


/// 作为屏蔽的人，以及动态页网络请求model的父类，子类需要自己实现loadMoreData方法
@interface MainPageModel : NSObject
@property(nonatomic,strong)NSMutableArray <NSDictionary*> *dataArr;
@property(nonatomic,assign)long page;
- (void)loadMoreData;
@end

NS_ASSUME_NONNULL_END
