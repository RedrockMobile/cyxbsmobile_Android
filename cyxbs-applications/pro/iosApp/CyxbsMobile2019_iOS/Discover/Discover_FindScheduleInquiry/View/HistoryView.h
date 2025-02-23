//
//  HistoryView.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/20.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HistoryViewDelegate <NSObject>
//点击某个历史记录后调用代理方法，代理是ScheduleViewController
- (void)touchHistoryButton:(UIButton *)sender;
@end

/// 该View接受一个数组，将数组中的所有数据以一个一个Item的形式展示出来，自动换行
@interface HistoryView : UIView
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong)NSMutableArray <UIButton*>*buttonArray;//每一个button
@property (nonatomic, weak)id <HistoryViewDelegate>btnClickedDelegate;
@property (nonatomic, copy)NSString *UserDefaultKey;
- (void)addHistoryBtnWithString:(NSString*)string reLayout:(BOOL)is;
- (instancetype)initWithUserDefaultKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
