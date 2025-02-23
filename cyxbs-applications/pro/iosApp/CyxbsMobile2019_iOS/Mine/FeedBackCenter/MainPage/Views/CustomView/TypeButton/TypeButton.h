//
//  TypeButton.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/24.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TypeButton;
NS_ASSUME_NONNULL_BEGIN

///选中效果协议
@protocol TypeButtonDelegate  <NSObject>

- (void)selected:(TypeButton *)sender;

@end

@interface TypeButton : UIButton

///代理
@property (nonatomic,weak) id<TypeButtonDelegate> delegate;

///初始化
- (instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
