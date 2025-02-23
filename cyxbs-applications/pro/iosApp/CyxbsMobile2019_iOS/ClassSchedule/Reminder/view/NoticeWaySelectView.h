//
//  NoticeWaySelectView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/21.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol NoticeWaySelectViewDelegate <NSObject>
- (void)notiPickerDidSelectedWithString:(NSString*)notiStr;
@end

@interface NoticeWaySelectView : UIView
@property (nonatomic,weak)id<NoticeWaySelectViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
