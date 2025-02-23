//
//  DLTimeSelectView.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DLTimeSelectViewDelegate <NSObject>
/// 点击周选择view的加号后调用代理方法
/// @param dataDict picker所选择的数据，结构：@{@"weekString":@"",  @"lessonString":@""}
- (void)pickerDidSelectedWithDataDict:(NSDictionary*)dataDict;
@property(nonatomic,strong)NSMutableArray <NSDictionary*> *timeDictArray;
@end

@interface DLTimeSelectView : UIView

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIPickerView *weekPicker;
@property (nonatomic, strong) UIPickerView *lessonPicker;
@property (nonatomic, weak)id<DLTimeSelectViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
