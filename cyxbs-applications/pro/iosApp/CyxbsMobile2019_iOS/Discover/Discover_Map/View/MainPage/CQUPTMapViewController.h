//
//  CQUPTMapViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/8.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQUPTMapContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQUPTMapViewController : UIViewController

@property (nonatomic, strong) UIPanGestureRecognizer *presentPanGesture;

@property (nonatomic, weak) CQUPTMapContentView *contentView;

@property (nonatomic, assign) BOOL isPresent;

- (instancetype)initWithInitialPlace:(NSString *)placeID;

@end

NS_ASSUME_NONNULL_END
