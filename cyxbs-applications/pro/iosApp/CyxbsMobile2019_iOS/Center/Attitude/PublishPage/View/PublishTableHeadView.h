//
//  PublishTableHeadView.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishTableHeadView : UIView
@property (nonatomic, strong) UILabel *headerLabel;
// label底部view
@property (nonatomic, strong) UIView *backView;
- (instancetype)initWithHeaderView;
@end

NS_ASSUME_NONNULL_END
