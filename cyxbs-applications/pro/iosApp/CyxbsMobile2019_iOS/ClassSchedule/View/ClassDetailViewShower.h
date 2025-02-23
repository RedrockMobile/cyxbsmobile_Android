//
//  ClassDetailViewShower.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/18.
//  Copyright © 2020 Redrock. All rights reserved.
//完成显示备忘弹窗、某课详情弹窗操作的类

#import <UIKit/UIKit.h>
#import "LessonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassDetailViewShower : UIView<LessonViewDelegate>
/// 某几节课的信息字典组成的数组
@property (nonatomic,strong)NSArray <NSDictionary*>*courseDataDictArray;
/// 某几个备忘模型组成的数组
@property (nonatomic,strong)NSArray <NoteDataModel*>*noteDataModelArray;
@end

NS_ASSUME_NONNULL_END

//用法：

//1.设置数据
//self.delegate.courseDataDictArray = self.courseDataDictArray;
//self.delegate.noteDataModelArray = self.noteDataModelArray;

//2.调用showDetail方法
//[self.delegate showDetail];
