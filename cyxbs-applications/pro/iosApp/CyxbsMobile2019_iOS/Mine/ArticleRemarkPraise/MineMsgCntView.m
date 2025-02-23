//
//  RedTipBall.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/2/22.
//  Copyright © 2021 Redrock. All rights reserved.
//  小红点

#import "MineMsgCntView.h"
//红点高度、也是消息数为个位数时的红点宽度
#define ballDiameter  (SCREEN_WIDTH*0.0427)

//99+时的红点宽度
#define ballWidth99P  (SCREEN_WIDTH*0.0707)

//消息数为9+时的红点宽度
#define ballWidth9P  (SCREEN_WIDTH*0.057)

@interface MineMsgCntView()
/// 最开始的位置，只初始化一次
@property(nonatomic,assign)CGPoint originCenter;
@property(nonatomic,strong)UILabel *msgLabel;
@end
@implementation MineMsgCntView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 0.5*ballDiameter;
        self.backgroundColor = [UIColor colorWithRed:236/255.0 green:74/255.0 blue:184/255.0 alpha:1];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        
//        UIPanGestureRecognizer *PGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(ballMove:)];
//        [self addGestureRecognizer:PGR];
        [self addMsgLabel];
    }
    return self;
}

- (void)ballMove:(UIPanGestureRecognizer*)PGR {
    CGPoint p = [PGR locationInView: self.superview];
    if(PGR.state==UIGestureRecognizerStateChanged){
        self.center = p;
    }
}

- (void)setMsgCount:(NSString*)msgCount{
    if (![self isPureInt:msgCount]) {
        return;
    }
    
    int msgCountInt = msgCount.intValue;
    
    if (msgCountInt < 0) {
        return;
    }
    
    _msgCount = [msgCount copy];
    self.msgLabel.text = msgCount;
    
    
    //正确的宽度         正确的高度
    int correctWidth, correctHeight;
    
    if (msgCountInt==0) {
        correctWidth = 0;
        correctHeight = 0;
    }else {
        correctHeight = ballDiameter;
        switch ((int)log10(msgCountInt)) {
            case 0://一位数
                correctWidth = ballDiameter;
                break;
            case 1://两位数
                correctWidth = ballWidth9P;
                break;
            default://两位数及以上
                correctWidth = ballWidth99P;
                self.msgLabel.text = @"99+";
                break;
        }
    }
    
    if (self.frame.size.width!=correctWidth) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(correctWidth);
            make.height.mas_equalTo(correctHeight);
        }];
    }
}

- (void)addMsgLabel{
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    self.msgLabel = label;
    
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.whiteColor;
    label.font = [UIFont boldSystemFontOfSize:10];
    
    label.layer.cornerRadius = self.layer.cornerRadius;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

/// 网上扣的一个操作，用来判断NSString内部是不是int，经过检验发现即使传入的是Long，它也是返回YES，负数也是YES
/// @param string 字符串
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];

    int val;

    return [scan scanInt:&val] && [scan isAtEnd];

}
@end
