//
//  FeedBackView.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/25.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackView.h"

@implementation FeedBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
        
        [self addSubview:self.feedBackMain];
        [self addSubview:self.splitLine];
        [self addSubview:self.heading];
        [self addSubview:self.textCountLbl];
        [self addSubview:self.headingCountLbl];
        [self addSubview:self.splitLine2];
        [self addSubview:self.photoLbl];
        [self addSubview:self.photoCountLbl];
        [self addSubview:self.imageView1];
        [self addSubview:self.imageView2];
        [self addSubview:self.imageView3];
        [self addSubview:self.plusView];
        [self addSubview:self.delete1];
        [self addSubview:self.delete2];
        [self addSubview:self.delete3];
    }
    return self;
}

#pragma mark - getter
- (UITextField *)heading{
    if (!_heading) {
        _heading = [[UITextField alloc]initWithFrame:CGRectMake(18, 20, self.width - 75, 25)];
        _heading.placeholder = @"添加标题";
        _heading.font = [UIFont fontWithName:PingFangSCSemibold size:18];
        _heading.delegate = self;
        [_heading addTarget:self action:@selector(getlength:) forControlEvents:UIControlEventEditingChanged];
        [_heading setTextColor:[UIColor colorWithHexString:@"#15315B"]];
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(self.heading, ivar);
        placeholderLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#A0ADBC" alpha:1] darkColor:[UIColor colorWithHexString:@"#7A7A7C" alpha:1]];
    }
    return _heading;
}

- (UIView *)splitLine{
    if (!_splitLine) {
        _splitLine = [[UIView alloc]initWithFrame:CGRectMake(16, 55, self.width - 32, 1)];
        _splitLine.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E4E4E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#414141" alpha:1]];
    }
    return _splitLine;
}

- (UITextView *)feedBackMain{
    if (!_feedBackMain) {
        _feedBackMain = [[UITextView alloc]initWithFrame:CGRectMake(14, 65, self.width - 36, 140)];
        _feedBackMain.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
        _feedBackMain.delegate = self;
        [_feedBackMain setTextColor:[UIColor colorWithHexString:@"#15315B"]];
        _feedBackMain.font = [UIFont fontWithName:PingFangSCMedium size:15];
        [_feedBackMain addSubview:self.placeholder];
    }
    return _feedBackMain;
}

- (UILabel *)placeholder{
    if (!_placeholder) {
        _placeholder = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 200, 30)];
        _placeholder.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#A0ADBC" alpha:1] darkColor:[UIColor colorWithHexString:@"#7A7A7C" alpha:1]];
        _placeholder.text = @"添加问题描述";
        _placeholder.font = [UIFont fontWithName:PingFangSCMedium size:15];
        
    }
    return _placeholder;
}

- (UILabel *)headingCountLbl{
    if (!_headingCountLbl) {
        _headingCountLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.84*SCREEN_WIDTH, 25, 15, 17)];
        _headingCountLbl.font = [UIFont fontWithName:PingFangSCMedium size:13];
        _headingCountLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#6A82A8" alpha:1] darkColor:[UIColor colorWithHexString:@"#A8A9AB" alpha:1]];
        _headingCountLbl.text = @"12";
    }
    return _headingCountLbl;
}

- (UILabel *)textCountLbl{
    if (!_textCountLbl) {
        _textCountLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.773*SCREEN_WIDTH, 177, 50, 17)];
        _textCountLbl.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _textCountLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#6A82A8" alpha:1] darkColor:[UIColor colorWithHexString:@"#A8A9AB" alpha:1]];
        _textCountLbl.text = @"0/200";
    }
    return _textCountLbl;
}
- (UIView *)splitLine2{
    if (!_splitLine2) {
        _splitLine2 = [[UIView alloc]initWithFrame:CGRectMake(16, 204, self.width - 32, 1)];
        _splitLine2.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E4E4E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#414141" alpha:1]];
    }
    return _splitLine2;
}

- (UILabel *)photoLbl{
    if (!_photoLbl) {
        _photoLbl = [[UILabel alloc]initWithFrame:CGRectMake(18, 221, 150, 21)];
        _photoLbl.text = @"相关问题的截图或图片";
        _photoLbl.font = [UIFont fontWithName:PingFangSCMedium size:15];
        _photoLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#73829D" alpha:1] darkColor:[UIColor colorWithHexString:@"#97979A" alpha:1]];
    }
    return _photoLbl;
}

- (UILabel *)photoCountLbl{
    if (!_photoCountLbl) {
        _photoCountLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.81*SCREEN_WIDTH, 223, 21, 17)];
        _photoCountLbl.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _photoCountLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#6A82A8" alpha:1] darkColor:[UIColor colorWithHexString:@"#A8A9AB" alpha:1]];
        _photoCountLbl.text = @"0/3";
    }
    return _photoCountLbl;
}

- (UIImageView *)imageView1{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(18, 249, 95, 95)];
        _imageView1.layer.cornerRadius = 4;
        _imageView1.layer.masksToBounds = YES;
        _imageView1.hidden = YES;
    }
    return _imageView1;
}
- (UIImageView *)imageView2{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(123, 249, 95, 95)];
        _imageView2.layer.cornerRadius = 4;
        _imageView2.layer.masksToBounds = YES;
        _imageView2.hidden = YES;
    }
    return _imageView2;
}
- (UIImageView *)imageView3{
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(227, 249, 95, 95)];
        _imageView3.layer.cornerRadius = 4;
        _imageView3.layer.masksToBounds = YES;
        _imageView3.hidden = YES;
    }
    return _imageView3;
}

- (UIView *)plusView{
    if (!_plusView) {
        _plusView = [[UIView alloc]initWithFrame:CGRectMake(18, 249, 98, 98)];
        UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 98)];
        iv2.image = [UIImage imageNamed:@"plusBG"];
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(34, 32.5, 30, 30)];
        iv.image = [UIImage imageNamed:@"myplus"];
        [_plusView addSubview:iv2];
        [_plusView addSubview:iv];
        _plusView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(block)];
        [_plusView addGestureRecognizer:tap];
    }
    return _plusView;
}


- (UIButton *)delete1{
    if (!_delete1) {
        _delete1 = [[UIButton alloc]initWithFrame:CGRectMake( 101, 247, 15, 15)];
        _delete1.tag = 0;
        [_delete1 setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_delete1 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        _delete1.hidden = YES;
    }
    return _delete1;
}
- (UIButton *)delete2{
    if (!_delete2) {
        _delete2 = [[UIButton alloc]initWithFrame:CGRectMake( 206, 247, 15, 15)];
        _delete2.tag = 1;
        [_delete2 setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_delete2 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        _delete2.hidden = YES;
    }
    return _delete2;
}

- (UIButton *)delete3{
    if (!_delete3) {
        _delete3 = [[UIButton alloc]initWithFrame:CGRectMake( 310, 247, 15, 15)];
        _delete3.tag = 2;
        [_delete3 setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_delete3 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        _delete3.hidden = YES;
    }
    return _delete3;
}



#pragma mark - 其他方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)getlength:(UITextField *)sender{
    self.headingCountLbl.text = [NSString stringWithFormat:@"%lu",12 - (unsigned long)sender.text.length];
}

#pragma mark - textView代理
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length != 0) {
        self.placeholder.hidden = YES;
        self.textCountLbl.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)textView.text.length];
    }
    else{
        self.placeholder.hidden = NO;
        self.textCountLbl.text = @"0/200";
    }
    if (textView.text.length > 199) {
        textView.text = [textView.text substringToIndex:199];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        if (string.length == 0) return YES;

        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 12){
            return NO;
        }


    return YES;
}

- (void)block{
    self.selectPhoto();
}

- (void)deleteImage:(UIButton *)sender{
    self.deletePhoto(sender.tag);
}
@end
