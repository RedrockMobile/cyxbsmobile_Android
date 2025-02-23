//
//  CQUPTMapHotPlaceButton.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapHotPlaceButton.h"
#import "CQUPTMapHotPlaceItem.h"

@interface CQUPTMapHotPlaceButton ()

@property (nonatomic, weak) UIImageView *hotTagImage;

@end


@implementation CQUPTMapHotPlaceButton

- (instancetype)initWithHotPlace:(CQUPTMapHotPlaceItem *)hotPlaceItem
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.hotPlaceItem = hotPlaceItem;
        
        self.buttonWidth = [self calculateTextWidth:hotPlaceItem.title];
        
        if (hotPlaceItem.isHot) {        // 后端返回字段判断为hot时才显示
            UIImageView *hotTagImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Map_HotTag"]];
            [self addSubview:hotTagImage];
            self.hotTagImage = hotTagImage;
        }

        UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [hotButton setTitle:hotPlaceItem.title forState:UIControlStateNormal];
        hotButton.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:15];
        if (@available(iOS 11.0, *)) {
            [hotButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#0E2A53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:1]] forState:UIControlStateNormal];
        } else {
            [hotButton setTitleColor:[UIColor colorWithHexString:@"#0E2A53"] forState:UIControlStateNormal];
        }
        [self addSubview:hotButton];
        self.button = hotButton;        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.button.frame = CGRectMake(14, 0, self.buttonWidth, 54);
    self.hotTagImage.frame = CGRectMake(14 + self.buttonWidth - 11, 3, 22, 12);

}

- (CGFloat)calculateTextWidth:(NSString *)string {
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont fontWithName:PingFangSCSemibold size:15]};

    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 10) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.width;
}

@end
