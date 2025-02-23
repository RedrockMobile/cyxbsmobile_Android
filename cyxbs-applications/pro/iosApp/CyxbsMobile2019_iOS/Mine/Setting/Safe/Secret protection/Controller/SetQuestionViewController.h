//
//  SetQuestionViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetQuestionView.h"
#import "QuestionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetQuestionViewController : UIViewController

@property (nonatomic, strong) SetQuestionView *setquestionView;
@property (nonatomic, strong) QuestionView *questionView;
@property (nonatomic, strong) UIView *TapView;

@end

NS_ASSUME_NONNULL_END
