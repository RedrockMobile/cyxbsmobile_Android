//
//  DLTimeSelectedButton.h
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLHistodyButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DLTimeSelectedButtonDelegate <NSObject>

- (void)deleteButtonWithBtn:(UIButton*)btn;

@end

//继承自DLHistoryButton
@interface DLTimeSelectedButton : DLHistodyButton
@property (nonatomic, weak) id<DLTimeSelectedButtonDelegate> delegate;
//-(void)initImageConstrains;
@end

NS_ASSUME_NONNULL_END
