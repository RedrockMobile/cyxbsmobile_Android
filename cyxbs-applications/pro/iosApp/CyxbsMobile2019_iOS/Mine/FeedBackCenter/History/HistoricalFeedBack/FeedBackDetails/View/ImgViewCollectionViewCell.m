//
//  ImgViewCollectionViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "ImgViewCollectionViewCell.h"

@implementation ImgViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

- (void)configureView
{
    self.contentView.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    
    [self.contentView addSubview:self.picImgView];
    [self.picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];

}

#pragma mark - Getter

- (UIImageView *)picImgView {
    if (_picImgView == nil) {
        _picImgView = [[UIImageView alloc] init];
        _picImgView.contentMode = UIViewContentModeScaleAspectFill;
        _picImgView.clipsToBounds = YES;
    }
    return _picImgView;
}


@end
