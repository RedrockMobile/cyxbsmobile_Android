//
//  MineAboutContentView.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/2/4.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MineAboutContentViewDelegate <NSObject>

- (void)backButtonClicked;

- (void)selectedIntroduction;
- (void)selectedProductWebsite;
- (void)selectedUpdateCheck;

@end

@interface MineAboutContentView : UIView

@property (nonatomic, weak) id<MineAboutContentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
