//
//  DLReminderSetTimeVC.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//最终编辑备忘时间的页面

#import <UIKit/UIKit.h>
#import "NoteDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLReminderSetTimeVC : UIViewController
///为你的行程添加标题时选择的标题
@property (nonatomic, strong) NSString *noticeString;

/// //为你的行程添加具体内容时输入的文字
@property (nonatomic, strong) NSString *detailString;


///时间选择view、显示已选时间的view、self三者需要共享已选时间的数据，如果三者各自持有一份数据会导致
///在数据同步上面花过多代码，故这里决定通过代理实现三者共用一份数据，但是对于数据的的修改操作都放在
///self.backViewOfTimeSelectedBt里面，调用loadSelectedButtonsWithTimeDict可添加已选周的数据。
///如果没完全了解结构，不要在self里修改self.timeDictArray来增删数据，否则可能会出错
/// 选择时间的DLTimeSelectView和显示已选择时间的TimeSelectedBtnsView的代理属性，里面是已经选择的时间字典
/// ,代码把这个timeDictArray的alloc init放DLReminderSetTimeVC，
/// 对数组内部元素的增删操作都放在TimeSelectedBtnsView，
/// 结构：@{@"weekString":@"周一",  @"lessonString":@"十一十二节课"}，
@property(nonatomic,strong)NSMutableArray <NSDictionary*> *timeDictArray;

/// 空课信息字典，init后由DLReminderSetDetailVC赋值,结构：@{
///    @"hash_day":0,
///   @"hash_lesson":2,
///    @"period":2,
///    @"week":第week周的空课，week代表整学期
/// };
@property (nonatomic, copy)NSDictionary *remind;

/// 点击备忘详情弹窗的修改按钮后会调用这个方法，来配置一些已选择的数据参数，
/// @param model 是备忘信息字典
- (void)initDataForEditNoteWithMode:(NoteDataModel*)model;
@end

NS_ASSUME_NONNULL_END
