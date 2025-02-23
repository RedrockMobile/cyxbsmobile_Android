//
//  PeopleListTableViewCell.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/7/30.
//  Copyright © 2020 Redrock. All rights reserved.
//tableView的每一行的cell都是这个类，通过初始化的方法决定这个cell是add型还是delete型

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PeopleListTableViewCellRightBtnType) {
    /**加号型cell*/
    PeopleListTableViewCellRightBtnTypeAdd,
    /**删除型cell*/
    PeopleListTableViewCellRightBtnTypeDelete
};

/**加号型cell的代理协议，点击add按钮后调用代理的方法，
 传入cell对应的数据：@{@"name":@"张树洞",@"stuNum":@"201928738"}*/
@protocol PeopleListTableViewCellDelegateAdd <NSObject>
- (void)PeopleListTableViewCellAddBtnClickInfoDict:(NSDictionary*)infoDict;
@end

/**删除型cell的代理协议，点击delete按钮后调用代理的方法，
传入cell对应的数据：@{@"name":@"张树洞",@"stuNum":@"201928738"}*/
@protocol PeopleListTableViewCellDelegateDelete <NSObject>
- (void)PeopleListTableViewCellDeleteBtnClickInfoDict:(NSDictionary*)infoDict;
@end


@interface PeopleListTableViewCell : UITableViewCell

//只能用这个方法初始化cell
/**infoDict要求格式为：@{@"name":@"张树洞",@"stuNum":@"201928738"}*/
- (instancetype)initWithInfoDict:(NSDictionary*)infoDict andRightBtnType:(PeopleListTableViewCellRightBtnType)type;

/**添加的代理，点击add按钮后调用代理的方法*/
@property (nonatomic,weak)id<PeopleListTableViewCellDelegateAdd>delegateAdd;
/**删除的代理，点击delete按钮后调用代理方法*/
@property (nonatomic,weak)id<PeopleListTableViewCellDelegateDelete>delegateDelete;
@end

NS_ASSUME_NONNULL_END
