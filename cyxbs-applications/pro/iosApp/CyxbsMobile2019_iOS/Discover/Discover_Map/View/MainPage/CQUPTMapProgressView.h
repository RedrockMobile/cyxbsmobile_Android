//
//  CQUPTMapProgressView.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQUPTMapProgressView : UIView

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *describeLabel;
@property (nonatomic, weak) UIProgressView *progresView;
@property (nonatomic, weak) UILabel *percentLabel;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title describe:(NSString *)describe;

@end

NS_ASSUME_NONNULL_END
