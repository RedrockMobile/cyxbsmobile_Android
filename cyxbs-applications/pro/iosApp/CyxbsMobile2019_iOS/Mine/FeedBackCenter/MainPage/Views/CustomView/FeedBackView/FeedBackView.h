//
//  FeedBackView.h
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/25.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class PlusView;
@interface FeedBackView : UIView <UITextFieldDelegate,UITextViewDelegate>


///标题
@property (nonatomic,strong) UITextField *heading;
///分割线
@property (nonatomic,strong) UIView *splitLine;
///反馈主内容
@property (nonatomic,strong) UITextView *feedBackMain;
///TextView的placeholder
@property (nonatomic,strong) UILabel *placeholder;
///标题计数Lbl
@property (nonatomic,strong) UILabel *headingCountLbl;
///正文计数Lbl
@property (nonatomic,strong) UILabel *textCountLbl;
///分割线2
@property (nonatomic,strong) UIView *splitLine2;
///图片提示Lbl
@property (nonatomic,strong) UILabel *photoLbl;
///图片数量Lbl
@property (nonatomic,strong) UILabel *photoCountLbl;
///1号位图片
@property (nonatomic,strong) UIImageView *imageView1;
///2号位图片
@property (nonatomic,strong) UIImageView *imageView2;
///3号位图片
@property (nonatomic,strong) UIImageView *imageView3;
///加号图片
@property (nonatomic,strong) UIView *plusView;
///选择图片 block
@property (nonatomic, copy) void (^selectPhoto)(void);
///用来删除图片的 Block
@property (nonatomic,copy) void (^deletePhoto)( NSInteger tag);
///1号删除按钮
@property (nonatomic,strong) UIButton *delete1;
///2号删除按钮
@property (nonatomic,strong) UIButton *delete2;
///3号删除按钮
@property (nonatomic,strong) UIButton *delete3;


@end

NS_ASSUME_NONNULL_END
