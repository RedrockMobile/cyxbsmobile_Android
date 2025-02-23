//
//  TableHeaderView.h
//  Demo5
//
//  Created by 钟文韬 on 2021/8/11.
//

#import <UIKit/UIKit.h>
#import "GotoButton.h"

NS_ASSUME_NONNULL_BEGIN

//table头视图
@interface TableHeaderView : UIView

///去完成按钮
@property (nonatomic,strong) GotoButton *button;
///主要内容
@property (nonatomic,strong) UILabel *mainLabel;
///次要内容
@property (nonatomic,strong) UILabel *detailLabel;


@end

NS_ASSUME_NONNULL_END
