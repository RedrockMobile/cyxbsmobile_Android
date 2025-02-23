//
//  ORWInputTextView.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/9/16.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "ORWInputTextView.h"
@interface ORWInputTextView()
@property (strong, nonatomic) UILabel *placeHolderLabel;

@end

@implementation ORWInputTextView


- (void)drawRect:(CGRect)rect {
    // Drawing code
//    self.layer.borderWidth =1;
//    self.layer.borderColor = RGBColor(202, 202, 202, 1).CGColor;
//    self.layer.cornerRadius = 1;
    [self addSubview:self.placeHolderLabel];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //    style.lineSpacing = 10;//增加行高
    style.headIndent = 5;//头部缩进，相当于左padding
    //    style.tailIndent = 10;//相当于右padding
    //    style.lineHeightMultiple = 1.5;//行间距是多少倍
    style.alignment = NSTextAlignmentLeft;//对齐方式
    style.firstLineHeadIndent = 5;//首行头缩进
    style.paragraphSpacing = 10;//段落后面的间距
    //    style.paragraphSpacingBefore = 20;//段落之前的间距
    self.typingAttributes = @{NSParagraphStyleAttributeName:style};
    _placeHolderLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    self.font = [UIFont fontWithName:@"Helvetica" size:14];
//    self.scrollEnabled = NO;//不可滚动
}





- (void)setPlaceHolder:(NSString *)placeHolder{
    [self.placeHolderLabel setText:@""];
    _placeHolderLabel.text = [placeHolder copy];
    _placeHolder = placeHolder;
    CGSize maximumSize = CGSizeMake(self.frame.size.width-16, self.frame.size.height-16);

    CGRect stringRect= [_placeHolder boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]} context:nil];
    CGRect finalFrame = CGRectMake(8, 8,  stringRect.size.width, stringRect.size.height);
    _placeHolderLabel.frame = finalFrame;
}

- (UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        
        _placeHolderLabel= [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.frame.size.width-16, self.frame.size.height-16)];
        
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textAlignment = 0;
        _placeHolderLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        

//        [_placeHolderLabel sizeThatFits:];
//        _placeHolderLabel.backgroundColor = [UIColor blackColor];
        
    }
    return _placeHolderLabel;
}

@end
