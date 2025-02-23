//
//  PointAndDottedLineView.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "PointAndDottedLineView.h"

@interface PointAndDottedLineView()
@property (nonatomic, assign) int pointCount;
@property (nonatomic) CGFloat spacing;
@property (nonatomic) CGFloat smallCircleRadius;
@property (nonatomic, strong)NSMutableArray<UIView*> *bigCircleArray;
@property (nonatomic, strong)NSMutableArray<UIView*> *smallCircleArray;
@end
@implementation PointAndDottedLineView
- (instancetype)initWithPointCount:(int)pointCount Spacing:(CGFloat)spacing {
    if(self = [super init]) {
        self.isNoExam = NO;
        self.backgroundColor = UIColor.clearColor;
        self.pointCount = pointCount;
        self.spacing = spacing;
        [self addCircle];
        if(self.bigCircleArray.count == 0 || !self.bigCircleArray) {
            self.isNoExam = YES;
        }
        
    }
    return self;
}
- (void)addCircle {
    //初始化装着所有大圆的数组
    NSMutableArray<UIView*> *bigCircleArray = [NSMutableArray array];
    self.bigCircleArray = bigCircleArray;
    
    //大圆
    for(int i = 0 ; i < self.pointCount; i++) {
        UIView *bigCircle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
        self.bigCircle = bigCircle;
        bigCircle.backgroundColor = [UIColor colorWithRed:41/255.0 green:33/255.0 blue:209/255.0 alpha:1];
        bigCircle.layer.cornerRadius = bigCircle.size.width/2.0;
        [self addSubview:bigCircle];
        [self.bigCircleArray addObject:bigCircle];
        if(i != 0) {
            [bigCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.centerX.equalTo(self.bigCircleArray[0]);
                make.top.equalTo(self.bigCircleArray[i-1].mas_bottom).offset(self.spacing - bigCircle.width);
            }];
        }
    }
    //初始化装着所有小圆的数组
    NSMutableArray<UIView*> *smallCircleArray = [NSMutableArray array];
    self.smallCircleArray = smallCircleArray;
    //添加小圆
    for(int i = 0 ; i < self.pointCount; i++) {
        UIView *smallCircle = [[UIView alloc]init];
        self.smallCircle = smallCircle;
        smallCircle.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F2F3F8" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        smallCircle.layer.cornerRadius = 2.5;
        [self addSubview:smallCircle];
        [self.smallCircleArray addObject:smallCircle];
            [smallCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.bigCircleArray[i]);
                make.width.height.equalTo(@5);
            }];
    }
}
//画虚线
- (void)drawRect:(CGRect)rect {
    CGContextRef context =UIGraphicsGetCurrentContext();
    // 设置线条的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:41/255.0 green:33/255.0 blue:209/255.0 alpha:0.7].CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    if(self.bigCircleArray.count == 0 || !self.bigCircleArray) {
        return;
    }
    // 设置虚线绘制起点
    CGPoint startPoint = CGPointMake(self.bigCircleArray[0].origin.x + self.bigCircleArray[0].size.width/2.0, self.bigCircleArray[0].origin.y + self.bigCircleArray[0].size.width);
    CGPoint endPoint = CGPointMake(self.bigCircleArray.lastObject.origin.x + self.bigCircleArray.lastObject.size.width/2.0, self.bigCircleArray.lastObject.origin.y);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
    CGFloat lengths[] = {10,10};
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    // 绘制
    CGContextStrokePath(context);
    // 关闭图像
    CGContextClosePath(context);
}
- (void)layoutSubviews {
//    [self.smallCircle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.bigCircle);
//        make.width.height.equalTo(@(self.smallCircleRadius));
//    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
