//
//  TopView.m
//  Demo5
//
//  Created by 钟文韬 on 2021/8/14.
//

#import "StampCenterTopView.h"
#import "PrefixHeader.pch"

@interface StampCenterTopView ()

@end

@implementation StampCenterTopView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, Bar_H, SCREEN_WIDTH, 180);
        self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        
        [self addSubview:self.holder];
        [self.holder addSubview:self.stampStoreLbl];
        [self.holder addSubview:self.stampTaskLbl];
        [self.holder addSubview:self.switchbar];
        [self.holder addSubview:self.swithPoint];
        [self.holder addSubview:self.page1btn];
        [self.holder addSubview:self.page2btn];
        [self addSubview:self.bannerImage];
        [self.stampTaskLbl addSubview: self.point];
    }
    return self;
}

- (void)setNumber:(NSNumber *)number{
    _number = number;
    self.bigStampCountLbl.text = [NSString stringWithFormat:@"%@",number];
}

- (UIImageView *)bannerImage{
    if (!_bannerImage) {
        _bannerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.042*SCREEN_WIDTH, 18, 0.914*SCREEN_WIDTH, 129)];
        _bannerImage.image = [UIImage imageNamed:@"Banner"];
        _bigStampImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.541*SCREEN_WIDTH, -25, 132, 119)];
        _bigStampImage.image = [UIImage imageNamed:@"BigStamp"];
        _wodeyoupiao = [[UILabel alloc]initWithFrame:CGRectMake(16, 16, 48, 17)];
        _wodeyoupiao.font = [UIFont fontWithName:PingFangSCSemibold size:12];
        _wodeyoupiao.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _wodeyoupiao.text = @"我的邮票";
        _detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(72, 20, 8.9, 8.9)];
        [_detailBtn setImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateNormal];
        _detailBtn.alpha = 0.7;
        
        [HttpTool.shareTool
         request:Mine_GET_stampStoreMainPage_API
         type:HttpToolRequestTypeGet
         serializer:HttpToolRequestSerializerHTTP
         bodyParameters:nil
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            self.number = object[@"data"][@"user_amount"];
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"==========================出错了");
        }];
        
//        HttpClient *client = [HttpClient defaultClient];
//        [client.httpSessionManager GET:Mine_GET_stampStoreMainPage_API parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//            self.number = responseObject[@"data"][@"user_amount"];
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"==========================出错了");
//            }];
        
        _mingxiLbl = [[UILabel alloc]initWithFrame:CGRectMake(83, 18, 23, 13)];
        _mingxiLbl.font = [UIFont fontWithName:PingFangSCRegular size:10];
        _mingxiLbl.text = @"明细";
        _mingxiLbl.alpha = 0.7;
        _mingxiLbl.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _bigStampCountLbl = [[UILabel alloc]initWithFrame:CGRectMake(16,26, 200, 66)];
        _bigStampCountLbl.font = [UIFont fontWithName:@"Bauhaus93" size:45];
        _bigStampCountLbl.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _bigStampCountLbl.text = @"";
        _alertLbl = [[UILabel alloc]initWithFrame:CGRectMake(16, 93, 180, 18)];
        _alertLbl.font = [UIFont fontWithName:@"Bauhaus93" size:12];
        _alertLbl.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.9];
        _alertLbl.text = @"你还有待领取的商品，请尽快领取";
        _alertLbl.hidden = YES;
        [_bannerImage addSubview:_bigStampImage];
        [_bannerImage addSubview:_wodeyoupiao];
        [_bannerImage addSubview:_mingxiLbl];
        [_bannerImage addSubview:_bigStampCountLbl];
        [_bannerImage addSubview:_alertLbl];
        [_bannerImage addSubview:_detailBtn];
    }
    return _bannerImage;
}

- (UILabel *)stampStoreLbl{
    if (!_stampStoreLbl) {
        _stampStoreLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.192*SCREEN_WIDTH, 18, 72, 25)];
        _stampStoreLbl.font = [UIFont fontWithName:PingFangSCMedium size:18];
        _stampStoreLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _stampStoreLbl.text = @"邮票小店";
        _stampStoreLbl.userInteractionEnabled = YES;

    }
    return _stampStoreLbl;
}

- (UILabel *)stampTaskLbl{
    if (!_stampTaskLbl) {
        _stampTaskLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.624*SCREEN_WIDTH,18,72,25)];
        _stampTaskLbl.font = [UIFont fontWithName:PingFangSCMedium size:18];
        _stampTaskLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        _stampTaskLbl.text = @"邮票任务";
        _stampTaskLbl.userInteractionEnabled =YES;
    }
    return _stampTaskLbl;
}

- (UIImageView *)switchbar{
    if (!_switchbar) {
        _switchbar = [[UIImageView alloc]initWithFrame:CGRectMake(_stampStoreLbl.x+3, 46, 62, 3)];
        _switchbar.image = [UIImage imageNamed:@"switchbar"];
        UIImageView *swithimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 3)];
        swithimage1.image = [UIImage imageNamed:@"switchimage1"];
        [_switchbar addSubview:swithimage1];
    }
    return _switchbar;
}

- (UIImageView *)swithPoint{
    if (!_swithPoint) {
        _swithPoint = [[UIImageView alloc]initWithFrame:CGRectMake(_stampStoreLbl.x+66, 46, 3, 3)];
        _swithPoint.image = [UIImage imageNamed:@"swithPoint"];
    }
    return _swithPoint;
}

- (UIButton *)page1btn{
    if (!_page1btn) {
        _page1btn = [[UIButton alloc]initWithFrame:_stampStoreLbl.frame];
        _page1btn.backgroundColor = [UIColor clearColor];
        [_page1btn addTarget:self.delegate action:@selector(goPageOne) forControlEvents:UIControlEventTouchUpInside];
    }
    return _page1btn;
}

- (UIButton *)page2btn{
    if (!_page2btn) {
        _page2btn = [[UIButton alloc]initWithFrame:_stampTaskLbl.frame];
        _page2btn.backgroundColor = [UIColor clearColor];
        [_page2btn addTarget:self.delegate action:@selector(goPageTwo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _page2btn;
}

- (UIImageView *)point{
    if (!_point) {
        _point = [[UIImageView alloc]initWithFrame:CGRectMake(_stampTaskLbl.width, 0, 7, 7)];
        _point.image = [UIImage imageNamed:@"point"];
    }
    return _point;
}

- (UIView *)holder{
    if (!_holder) {
        _holder = [[UIView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 50)];
        _holder.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    }
    return _holder;
}
@end
