//
//  SSRTextCycleCell.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/12.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SSRTextCycleCell.h"

#pragma mark - SSRTextCycleCell

@implementation SSRTextCycleCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:SSRTextCycleCellReuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.ssrTextLab];
    }
    return self;
}

#pragma mark - Getter

- (UILabel *)ssrTextLab {
    if (_ssrTextLab == nil) {
        _ssrTextLab = [[UILabel alloc] init];
    }
    return _ssrTextLab;
}

- (void)drawTextLab {
    self.ssrTextLab.frame = self.contentView.SuperFrame;
}

@end
