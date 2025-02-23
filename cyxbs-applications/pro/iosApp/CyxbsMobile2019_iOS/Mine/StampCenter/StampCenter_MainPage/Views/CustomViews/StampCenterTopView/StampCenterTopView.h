//
//  TopView.h
//  Demo5
//
//  Created by 钟文韬 on 2021/8/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TopViewDelegate <NSObject>

- (void)goPageOne;
- (void)goPageTwo;
- (void)goDetail;

@end

///顶部共用View
@interface StampCenterTopView : UIView

///大数字
@property (nonatomic,strong) UILabel *bigStampCountLbl;

///提醒
@property (nonatomic,strong) UILabel *alertLbl;

///邮票小店
@property (nonatomic,strong) UILabel *stampStoreLbl;

///邮票任务
@property (nonatomic,strong) UILabel *stampTaskLbl;

///任务提示小点
@property (nonatomic,strong) UIImageView *point;

///大图片
@property (nonatomic,strong) UIImageView *bigStampImage;

///banner图片
@property (nonatomic,strong) UIImageView *bannerImage;

///滑动条
@property (nonatomic,strong) UIImageView *switchbar;

///滑动条小圆点
@property (nonatomic,strong) UIImageView *swithPoint;

///页面1按钮
@property (nonatomic,strong) UIButton *page1btn;

///页面2按钮
@property (nonatomic,strong) UIButton *page2btn;

///邮票按钮
@property (nonatomic) UIButton *detailBtn;

///悬停view （邮票小店 和 邮票任务 所在的View）
@property (nonatomic,strong) UIView *holder;

///邮票数量
@property (nonatomic,strong) NSNumber *number;

///我的明细
@property (nonatomic,strong) UILabel *mingxiLbl;

///我的邮票
@property (nonatomic,strong) UILabel *wodeyoupiao;

///跳转代理
@property (nonatomic,weak) id<TopViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
