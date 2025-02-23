//
//  SetQuestionView.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SetQuestionViewDeleagte <NSObject>


- (void)backButtonClicked;
- (void)ClickedSureBtn;

@end


@interface SetQuestionView : UIView

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *questionBtn;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabLess;
@property (nonatomic, strong) UILabel *placeholderLabMore;
@property (nonatomic, weak) id<SetQuestionViewDeleagte> delegate;

@end

NS_ASSUME_NONNULL_END

