//
//  DetailsgoodsTableViewCell.m
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import "DetailsGoodsTableViewCell.h"

@interface DetailsGoodsTableViewCell ()

@end

@implementation DetailsGoodsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureView];
    }
    return self;
}

- (void)configureView {
    self.titleImgView.image = [UIImage imageNamed:@"details_isReceived"];
    self.rightTitleLabel.textColor = [UIColor colorWithHexString:@"#4B66F0"];
    self.separatorLineHidden = YES;
}

#pragma mark - setter

- (void)setCellModel:(DetailsGoodsModel *)cellModel {
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.goods_name;
    self.subtitleLabel.text = getTimeFromTimestampWithDateFormat(cellModel.date, @"YYYY.MM.dd");
    self.rightTitleLabel.text = [NSString stringWithFormat:@"-%zd", cellModel.goods_price];
    
    // 在代理方法中给 cell 赋值, 需要先将图片设置为隐藏, 否则动画的延后性会导致图片来不及隐藏
    self.titleImgHidden = YES;
    // 等待一下再执行动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.titleImgHidden = cellModel.is_received;
        [self titleImgAnimation];
    });
}

/// 淡入淡出的动画
- (void)titleImgAnimation {
    if (self.titleImgHidden == YES) {
        return;
    }
    // 淡入淡出的动画
    CABasicAnimation * animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation1.fromValue = @0;
    animation1.toValue = @1;
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation2.fromValue = @(CGPointMake(self.titleImgView.layer.position.x + 50, self.titleImgView.layer.position.y));
    animation2.toValue = @(self.titleImgView.layer.position);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 0.3; // 动画组的持续时间
    groupAnimation.beginTime = CACurrentMediaTime(); // 开始时间
    [self.titleImgView.layer addAnimation:groupAnimation forKey:@"淡入淡出"];
}

@end
