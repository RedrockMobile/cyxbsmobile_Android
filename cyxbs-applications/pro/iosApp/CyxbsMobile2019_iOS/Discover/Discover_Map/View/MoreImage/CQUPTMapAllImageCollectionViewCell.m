//
//  CQUPTMapAllImageCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/18.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapAllImageCollectionViewCell.h"

@implementation CQUPTMapAllImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor colorWithHexString:@"#E1EDFB"];
        imageView.layer.cornerRadius = 9;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
