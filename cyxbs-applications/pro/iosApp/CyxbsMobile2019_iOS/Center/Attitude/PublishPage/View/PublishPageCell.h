//
//  PublishPageCell.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PublishPageCell;

@protocol PublishPageCellDelegate <NSObject>

@optional

- (void)tableViewCellPressDeleteCell:(PublishPageCell *)cell;

@end

@interface PublishPageCell : UITableViewCell
// 选项label，需添加点击手势修改label内容
@property (nonatomic, strong) UILabel *tagLabel;
// 删除cell的按钮
@property (nonatomic, strong) UIButton *deleteBtn;
// label底部view
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, weak) id<PublishPageCellDelegate> delegate;

//@property (nonatomic, copy) void (^pressDeleteCell)(UITableViewCell *currentCell);
@end

NS_ASSUME_NONNULL_END
