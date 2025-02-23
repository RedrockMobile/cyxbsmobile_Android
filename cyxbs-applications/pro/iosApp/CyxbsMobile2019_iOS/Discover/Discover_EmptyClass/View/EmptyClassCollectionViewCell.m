//
//  EmptyClassCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/22.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "EmptyClassCollectionViewCell.h"

@implementation EmptyClassCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *roomLabel = [[UILabel alloc] init];
        roomLabel.font = [UIFont systemFontOfSize:13];
        if (@available(iOS 11.0, *)) {
            roomLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF2" alpha:1]];
        } else {
            roomLabel.textColor = [UIColor colorWithRed:17/255.0 green:44/255.0 blue:84/255.0 alpha:1];
        }
        [self.contentView addSubview:roomLabel];
        self.roomLabel = roomLabel;
        
        [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setRoom:(NSString *)room {
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
}


@end
