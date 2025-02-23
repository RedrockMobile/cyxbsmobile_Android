//
//  CoverView.h
//  Demo
//
//  Created by 李展 on 2016/12/10.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverView : UIView
typedef void(^passTap)(NSSet<UITouch *> *touches, UIEvent *event);

@property (nonatomic, copy) passTap passTap;
@end
