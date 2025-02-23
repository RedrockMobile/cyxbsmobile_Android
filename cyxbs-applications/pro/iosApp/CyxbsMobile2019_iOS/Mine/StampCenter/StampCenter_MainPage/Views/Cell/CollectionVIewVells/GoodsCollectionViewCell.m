//
//  MyCollectionViewCell.m
//  Demo5
//
//  Created by 钟文韬 on 2021/8/7.
//

#import "GoodsCollectionViewCell.h"

#define W self.frame.size.width
#define H self.frame.size.height


@implementation GoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self SetupUI];
        [self.contentView addSubview:self.goodsImageView];
        [self.contentView addSubview:self.exchangeBtn];
        [self.contentView addSubview:self.stampRequirementLbl];
        [self.contentView addSubview:self.stampImageView];
        [self.contentView addSubview:self.stockLbl];
        [self.contentView addSubview:self.mainLbl];
        [self.contentView addSubview:self.showBtn];
    }
    return self;
}


#pragma mark - setter
- (void)setData:(StampGoodsData *)data{
    self.mainLbl.text = data.title;
    self.stampRequirementLbl.text = [NSString stringWithFormat:@"%d",data.price];
    self.stockLbl.text = [NSString stringWithFormat:@"库存: %d",data.amount];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:data.url]];
    if (data.amount < 1) {
        self.exchangeBtn.backgroundColor = [UIColor colorWithHexString:@"#CACACA"];
    }
    else{
        self.exchangeBtn.backgroundColor = [UIColor colorWithHexString:@"#4A44E4"];
    }
    self.exchangeBtn.tag = data.id;
    self.showBtn.tag = data.id;
}

#pragma mark -getter
- (UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W, 0.611*H)];
        _goodsImageView.image = [UIImage imageNamed:@"goodsImage"];
        UIBezierPath  *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.goodsImageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(0.047*W, 0.047*W)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame =_goodsImageView.bounds;
        maskLayer.path = maskPath.CGPath;
       _goodsImageView.layer.mask = maskLayer;
    }
    return _goodsImageView;
}

- (UILabel *)mainLbl{
    if (!_mainLbl) {
        _mainLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.071*W, 0.65*H, 0.85*W, 20)];
        _mainLbl.font = [UIFont fontWithName:PingFangSCSemibold size:14];
        _mainLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _mainLbl.text = @"挂件";
    }
    return _mainLbl;
}

- (UILabel *)stockLbl{
    if (!_stockLbl) {
        _stockLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.071*W, 0.74*H, 0.928*W, 15)];
        _stockLbl.font = [UIFont fontWithName:PingFangSCLight size:12];
        _stockLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.7] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.7]];
        _stockLbl.text = @"库存:0";
    }
    return _stockLbl;
}

- (UIImageView *)stampImageView{
    if (!_stampImageView) {
        _stampImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.071*W, 0.848*H, 18, 18)];
        _stampImageView.image = [UIImage imageNamed:@"stamp"];
    }
    return _stampImageView;
}

- (UILabel *)stampRequirementLbl{
    if (!_stampRequirementLbl) {
        _stampRequirementLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.203*W,0.856*H,130, 17)];
        _stampRequirementLbl.font = [UIFont fontWithName:@"DIN-Medium" size:14];
        _stampRequirementLbl.textColor = [UIColor colorWithHexString:@"#5177FF"];
        _stampRequirementLbl.text = @"0";
    }
    return _stampRequirementLbl;
}

- (UIButton *)exchangeBtn{
    if (!_exchangeBtn) {
       _exchangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.64*W, 0.839*H, 0.287*W, 26)];
        _exchangeBtn.backgroundColor = [UIColor colorWithHexString:@"#4A44E4"];
        _exchangeBtn.layer.cornerRadius = 13;
        [_exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];
        _exchangeBtn.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:14];
    }
    return _exchangeBtn;
}
- (UIButton *)showBtn{
    if (!_showBtn) {
        _showBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.goodsImageView.x, self.goodsImageView.y, self.goodsImageView.width, H)];
        self.showBtn.backgroundColor = [UIColor clearColor];
    }
    return _showBtn;
}

- (void)SetupUI{
    self.contentView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
    self.contentView.layer.cornerRadius = 0.047*W;
    self.contentView.layer.shadowColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#B4BBD1" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0]].CGColor;
    self.contentView.layer.shadowOpacity = 0.3;
    self.contentView.layer.shadowRadius = 5;
    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
    self.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
}

@end
