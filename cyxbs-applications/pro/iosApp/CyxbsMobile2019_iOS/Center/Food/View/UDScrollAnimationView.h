//
//  UDScrollAnimationView.h
//  UDScrollAnimation
//
//  Created by 潘申冰 on 2023/2/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UDScrollAnimationView : UIView
/// 内容相关
@property (nonatomic, copy) NSArray<NSString *> *textArr;       //滚动数组
@property (nonatomic, copy) NSString *finalText;                //最终文字
/// 样式相关
@property (nonatomic, strong) UIColor *textColor;               //字体颜色
@property (nonatomic, strong) UIFont *font;                     //字体
/// 动画相关
@property (nonatomic, assign) NSTimeInterval duration;          // 动画总持续时间
@property (nonatomic, assign) BOOL isUp;                        // 滚动方向，默认为NO，向下

- (void)startAnimation;                                         //开始滚动
- (void)stopAnimation;                                          //终止滚动

//禁用其他
- (instancetype)init NS_UNAVAILABLE;
//- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
//只能使用这一种
- (instancetype)initWithFrame:(CGRect)frame TextArry:(NSArray *)textArr FinalText:(NSString *)finalText;
@end

NS_ASSUME_NONNULL_END
