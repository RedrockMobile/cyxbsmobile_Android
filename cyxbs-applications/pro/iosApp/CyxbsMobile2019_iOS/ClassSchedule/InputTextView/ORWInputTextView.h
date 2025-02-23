//
//  ORWInputTextView.h
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/16.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORWInputTextView : UITextView

@property (copy, nonatomic) NSString *placeHolder;

- (void)setPlaceHolder:(NSString *)placeHolder;
@end
