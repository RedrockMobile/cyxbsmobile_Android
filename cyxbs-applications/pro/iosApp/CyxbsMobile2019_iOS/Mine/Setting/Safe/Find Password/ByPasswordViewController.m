//
//  ByPasswordViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 杨远舟 on 2020/10/31.
//  Copyright © 2020 Redrock. All rights reserved.
//

//通过邮箱验证码找回页面

#import "ByPasswordViewController.h"
#import "Masonry.h"
#import "ResetPwdViewController.h"
//#import "YYZSendVC.h"
#import "UserDefaultTool.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准

@interface ByPasswordViewController () <UITextViewDelegate> 

@property(nonatomic, weak)UITextView *tf;
@property(nonatomic, weak) UIButton *saveBtn;
@property(nonatomic, weak)UILabel *placeHolder;
@property(nonatomic, weak) UIButton *btn2;
@property(nonatomic, weak) UIButton *btn;
@property(nonatomic, weak) UILabel *lable3;
@property (nonatomic, assign) NSString* code;

@end

@implementation ByPasswordViewController


-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
-(void) viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    
    //设置导航栏
    self.navigationController.navigationBar.hidden = NO;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"ㄑ找回密码" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    [leftButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:21.0], NSFontAttributeName,
    [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =leftButton;
    
    //获取学号
    if(self.idString==nil){
        UserItem *item = [[UserItem alloc] init];
        self.idString= item.stuNum;
    }
    
    [self setLable];
    [self setTextView];
    [self setBtn];
    [self setBtnCode];
    [self getMail];
    
}
-(void) clickLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) setLable{
    //uilable
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(20,25 + TOTAL_TOP_HEIGHT,240,21);
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"你的保密邮箱是, 请点击获取验证码" attributes:@{NSFontAttributeName: [UIFont fontWithName:PingFangSC size: 15], NSForegroundColorAttributeName: [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0]}];
    label1.attributedText = string;
    label1.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#748AAF" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    label1.alpha = 0.64;
    
    UILabel *label3 = [[UILabel alloc] init];
    self.lable3 = label3;
    label3.frame = CGRectMake(20,53 + TOTAL_TOP_HEIGHT,213,22);
    label3.numberOfLines = 0;
    [self.view addSubview:label3];
    label3.text = @" ";
    label3.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(25 + TOTAL_TOP_HEIGHT);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(53 + TOTAL_TOP_HEIGHT);
    }];
}
-(void) dismissKeyBoard{
    [self.tf resignFirstResponder];
}

-(void) setTextView{
    UITextView *tf = [[UITextView alloc]initWithFrame:(CGRectMake(20,107,339,45))];
    tf.layer.cornerRadius = 10;//设置边框圆角
    tf.layer.masksToBounds = YES;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.textContainerInset = UIEdgeInsetsMake(15, 10, 10, 10);//设置边界间距
    tf.backgroundColor = [UIColor colorWithRed:232/255.0 green:240/255.0 blue:252/255.0 alpha:1.0];
    [self.view addSubview:tf];
      self.tf=tf;
    tf.delegate = self;
      
      UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
         [topView setBarStyle:UIBarStyleDefault];
         UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
         UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
         NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];

         [topView setItems:buttonsArray];
         [tf setInputAccessoryView:topView];
      
      UILabel *placeHolderLabel = [[UILabel alloc] init];
      placeHolderLabel.text = @"请输入验证码";
      placeHolderLabel.textColor = [UIColor colorWithRed:157/255.0 green:168/255.0 blue:188/255.0 alpha:1.0];
      placeHolderLabel.numberOfLines = 0;
      [placeHolderLabel sizeToFit];
      [tf addSubview:placeHolderLabel];
      // same font
      tf.font = [UIFont systemFontOfSize:16.f];
      placeHolderLabel.font = [UIFont systemFontOfSize:16.f];
      [tf setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(107 + TOTAL_TOP_HEIGHT);
        make.height.greaterThanOrEqualTo(@45);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH*0.904);
        
    }];
}
- (void)textViewDidChange:(UITextView *)textView {  //在该代理方法中实现实时监听uitextview的输入
    if (textView.text.length>8 || textView.text.length<3 ) {
        [NewQAHud showHudWith:@" 请输入正确长度的验证码 " AddView:self.view];
        self.btn.enabled = NO;
    }
    else if(textView.text.length>2){
        self.btn.enabled = YES;
    }
}

-(void) setBtn{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
    self.btn = btn;
    btn.enabled = NO;
    btn.frame = CGRectMake(48*kRateX, 310*kRateY, 280*kRateX, 52*kRateY);
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:25.0];
    btn.backgroundColor = [UIColor colorWithRed:69/255.0 green:73/255.0 blue:219/255.0 alpha:1.0];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.0];
    [btn addTarget:self action:@selector(jumpTOset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(SCREEN_HEIGHT * 0.3867 + TOTAL_TOP_HEIGHT);
            make.left.mas_equalTo(self.view).mas_offset(SCREEN_WIDTH * 0.128);
            make.width.mas_equalTo(SCREEN_WIDTH * 0.7467);
            make.height.mas_equalTo(SCREEN_WIDTH * 0.7467 * 52/280);
    }];
}
-(void) setBtnCode{
    UIButton *btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2 = btn2;
    
    btn2.frame = CGRectMake(265,118,80,21);
    [btn2 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:75/255.0 green:69/255.0 blue:229/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(getMailCode)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(107 + TOTAL_TOP_HEIGHT);
        make.height.greaterThanOrEqualTo(@45);
        make.right.equalTo(_tf).offset(-SCREEN_WIDTH* 15/339);
    }];
}

//跳转界面，判断验证码是否正确
- (void)jumpTOset{
    NSNumber *codeNum = [NSNumber numberWithString:self.tf.text];
    
    [HttpTool.shareTool
     request:Mine_POST_checkEmailCode_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:@{@"stu_num":self.idString, @"email":self.lable3.text,@"code":codeNum}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if ([object[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]) {
            self.code = object[@"data"][@"code"];
            ResetPwdViewController *rView = [[ResetPwdViewController alloc]init];
            rView.stuID = self.idString;
            rView.changeCode = self.code;
            rView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rView animated:YES];
        }
        else{
            UILabel *tipsLable = [[UILabel alloc]init];
            tipsLable.text = @"验证码有误或过期，请重新获取。 ";
            tipsLable.font =[UIFont fontWithName:PingFangSC size:12];
            tipsLable.textColor = [UIColor colorWithRed:11/225.0 green:204/225.0 blue:240/225.0 alpha:1.0];
            [self.view addSubview:tipsLable];
            [tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(self.tf).offset(53);
                        make.left.mas_equalTo(self.view).mas_offset(SCREEN_WIDTH * 0.053);
                        make.width.mas_equalTo(SCREEN_WIDTH * 0.50);  }];
            [NewQAHud showHudWith:@" 验证码有误或过期 " AddView:self.view];

        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
    }];
    
//    [[HttpClient defaultClient] requestWithPath:Mine_POST_checkEmailCode_API method:HttpRequestPost parameters:@{@"stu_num":self.idString, @"email":self.lable3.text,@"code":codeNum} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        if([responseObject[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]){
//            self.code = responseObject[@"data"][@"code"];
//            ResetPwdViewController *rView = [[ResetPwdViewController alloc]init];
//            rView.stuID = self.idString;
//            rView.changeCode = self.code;
//            rView.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:rView animated:YES];
//        }
//        else{
//            UILabel *tipsLable = [[UILabel alloc]init];
//            tipsLable.text = @"验证码有误或过期，请重新获取。 ";
//            tipsLable.font =[UIFont fontWithName:nil size:12];
//            tipsLable.textColor = [UIColor colorWithRed:11/225.0 green:204/225.0 blue:240/225.0 alpha:1.0];
//            [self.view addSubview:tipsLable];
//            [tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.top.mas_equalTo(self.tf).offset(53);
//                        make.left.mas_equalTo(self.view).mas_offset(SCREEN_WIDTH * 0.053);
//                        make.width.mas_equalTo(SCREEN_WIDTH * 0.50);  }];
//            [NewQAHud showHudWith:@" 验证码有误或过期 " AddView:self.view];
//
//        }
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
//        }];
    
}
// 开启倒计时效果
-(void)openCountdown{
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.btn2 setTitle:@"重新发送" forState:UIControlStateNormal];
                self.btn2.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.btn2 setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                self.btn2.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
//获取邮箱地址
-(void) getMail{
    NSString *num = [[NSString alloc] init];
    NSString *stuNum = [UserDefaultTool getStuNum];

    if(self.idString!=nil)
        num = self.idString;
    else
        num = stuNum;
    
    [HttpTool.shareTool
     request:Mine_POST_getEmailDetail_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:@{@"stu_num":num}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSString *email = object[@"data"][@"email"];
        self.lable3.text = email;
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
    }];
    
//    [[HttpClient defaultClient] requestWithPath:Mine_POST_getEmailDetail_API method:HttpRequestPost parameters:@{@"stu_num":num} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSString *email = responseObject[@"data"][@"email"];
//        self.lable3.text = email;
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
//        }];
}
//发送验证码
- (void)getMailCode{
    [self openCountdown];
    
    [HttpTool.shareTool
     request:Mine_POST_getEmailCode_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:@{@"stu_num":self.idString}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        [NewQAHud showHudWith:@" 验证码已发送，可能会被归为垃圾邮件，请注意查收 " AddView:self.view];
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
    }];
    
//    [[HttpClient defaultClient] requestWithPath:Mine_POST_getEmailCode_API method:HttpRequestPost parameters:@{@"stu_num":self.idString} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
//            [NewQAHud showHudWith:@" 验证码已发送，可能会被归为垃圾邮件，请注意查收 " AddView:self.view];
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
//        }];
}

@end
