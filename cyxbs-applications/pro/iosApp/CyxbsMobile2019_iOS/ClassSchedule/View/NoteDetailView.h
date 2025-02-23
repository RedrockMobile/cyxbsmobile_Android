//
//  NoteDetailView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/21.
//  Copyright © 2020 Redrock. All rights reserved.
//显示备忘详情的弹窗view

#import <UIKit/UIKit.h>
#import "NoteDataModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NoteDetailViewDelegate <NSObject>
//点击修改或删除按钮后调用代理方法，让代理隐藏弹窗，代理设置为ClassDetailViewShower
- (void)hideDetail;
@end

@interface NoteDetailView : UIView

/// 备忘数据模型
@property(nonatomic,strong)NoteDataModel *dataModel;

/// 代理，设置为ClassDetailViewShower
@property(nonatomic,weak)id<NoteDetailViewDelegate>hideDetailDelegate;
@end

NS_ASSUME_NONNULL_END
