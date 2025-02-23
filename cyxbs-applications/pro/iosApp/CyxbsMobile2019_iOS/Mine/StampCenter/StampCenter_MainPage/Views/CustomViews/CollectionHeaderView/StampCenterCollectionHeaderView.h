//
//  StampCenterCollectionHeaderView.h
//  Demo5
//
//  Created by 钟文韬 on 2021/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///假的collection头视图 （UIView）
@interface StampCenterCollectionHeaderView : UIView

///主要内容
@property (nonatomic,strong) UILabel *mainLabel;

///次要内容
@property (nonatomic,strong) UILabel *detailLabel;

@end

NS_ASSUME_NONNULL_END
