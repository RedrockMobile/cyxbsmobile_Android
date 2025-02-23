//
//  PopupView.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///弹窗View
@interface PopupView : UIView

///灰弹窗
@property (nonatomic, strong) UIView *grayView;
///白弹窗
@property (nonatomic, strong) UIView *whiteView;
///取消按钮
@property (nonatomic, strong) UIButton *cancleBtn;
///确认按钮
@property (nonatomic, strong) UIButton *comfirmBtn;
///文字框
@property (nonatomic, strong) UILabel *textLabel;
///商品ID
@property (nonatomic,copy) NSString *goodsID;
///库存不够确认按钮
@property (nonatomic, strong) UIButton *noamountComfirmBtn;

@property (nonatomic, assign) int is;

- (instancetype)initWithGoodsName:(NSString *)name AndCount:(NSString *)count AndAmount:(int )amount AndID:(NSString *)ID;

- (void)refresh1;
- (void)refresh2;
- (void)refresh3;

@end

NS_ASSUME_NONNULL_END
