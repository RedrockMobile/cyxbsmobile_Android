//
//  StampCenterSecondHeaderView.h
//  Demo5
//
//  Created by 钟文韬 on 2021/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///真的collection头视图 （UICollectionReusableView）
@interface StampCenterSecondHeaderView : UICollectionReusableView

///主要内容
@property (nonatomic,strong) UILabel *mainLabel;

///次要内容
@property (nonatomic,strong) UILabel *detailLabel;

@end

NS_ASSUME_NONNULL_END
