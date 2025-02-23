//
//  GotoButton.h
//  Demo5
//
//  Created by 钟文韬 on 2021/8/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///去完成（兑换）按钮
@interface GotoButton : UIButton

///任务名称，对应 POST Body中的title
@property (nonatomic,copy) NSString *target;

- (instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
