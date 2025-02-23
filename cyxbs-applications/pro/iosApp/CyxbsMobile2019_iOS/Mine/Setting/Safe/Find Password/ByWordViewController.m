//
//  ByWordViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 杨远舟 on 2020/10/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

//通过密保问题找回页面
#import "ByWordViewController.h"
#import "Masonry.h"
#import "ResetPwdViewController.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准

@interface ByWordViewController () <UITextViewDelegate>
@property(nonatomic, weak)UITextView *tf;
@property(nonatomic, weak) UIButton *saveBtn;
@property(nonatomic, weak) UIButton *btn;
@property(nonatomic, weak)UILabel *placeHolder;
@property(nonatomic, strong)UILabel *label3;
@property(nonatomic,strong) NSNumber *questNum;
@property (nonatomic, assign) NSString* code;

@end

@implementation ByWordViewController

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
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"ㄑ找回密码" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    [leftButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:21.0], NSFontAttributeName,
    [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]], NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem =leftButton;
    
    //获取学号
    if(self.idString==nil){
        UserItem *item = [[UserItem alloc] init];
        self.idString= item.stuNum;
    }
    
    [self setLable];
    [self setTextView];
    [self setBtn];
    [self get1];
    
}
-(void) clickLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) setLable{
    //uilable
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(20,20 + TOTAL_TOP_HEIGHT,120,21);
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"你的密保问题是：" attributes:@{NSFontAttributeName: [UIFont fontWithName:PingFangSC size: 15], NSForegroundColorAttributeName: [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0]}];
    label1.attributedText = string;
    label1.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#748AAF" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    label1.alpha = 0.64;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(20,85 + TOTAL_TOP_HEIGHT,120,21);
    label2.numberOfLines = 0;
    [self.view addSubview:label2];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"你的问题答案是：" attributes:@{NSFontAttributeName: [UIFont fontWithName:PingFangSC size: 15], NSForegroundColorAttributeName: [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0]}];
    label2.attributedText = string2;
    label2.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    label2.alpha = 0.64;

    UILabel *label3 = [[UILabel alloc] init];
    self.label3 = label3;
    label3.frame = CGRectMake(20,45 + TOTAL_TOP_HEIGHT,213,22);
    label3.numberOfLines = 0;
    [self.view addSubview:label3];
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@" " attributes:@{NSFontAttributeName: [UIFont fontWithName:PingFangSC size: 16], NSForegroundColorAttributeName: [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0]}];
    label3.attributedText = string3;
    label3.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#14305B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    label3.alpha = 1.0;
}
-(void) dismissKeyBoard{
    [self.tf resignFirstResponder];
}

-(void) setTextView{
    UITextView *tf = [[UITextView alloc]initWithFrame:(CGRectMake(20,218-100 + TOTAL_TOP_HEIGHT,339,100))];
    self.tf = tf;
    tf.layer.cornerRadius = 13;//设置边框圆角
    tf.layer.masksToBounds = YES;
    tf.textContainerInset = UIEdgeInsetsMake(15, 10, 10, 10);//设置边界间距
    tf.backgroundColor = [UIColor colorWithRed:232/255.0 green:240/255.0 blue:252/255.0 alpha:1.0];
    [self.view addSubview:tf];
      
      UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
         [topView setBarStyle:UIBarStyleDefault];
         UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
         UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
         NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];

         [topView setItems:buttonsArray];
         [tf setInputAccessoryView:topView];
      
      UILabel *placeHolderLabel = [[UILabel alloc] init];
      placeHolderLabel.text = @"请输入密保问题的答案 (由2-16位字符组成)";
      placeHolderLabel.textColor = [UIColor colorWithRed:157/255.0 green:168/255.0 blue:188/255.0 alpha:1.0];
      placeHolderLabel.numberOfLines = 0;
      [placeHolderLabel sizeToFit];
      [tf addSubview:placeHolderLabel];
      // same font
      tf.font = [UIFont systemFontOfSize:16.f];
      placeHolderLabel.font = [UIFont systemFontOfSize:16.f];
      [tf setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT * 0.13  + TOTAL_TOP_HEIGHT);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.123);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH*0.904);
        
    }];
}
//在该代理方法中实现实时监听uitextview的输入
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length>16 || textView.text.length<2 ) {
        [NewQAHud showHudWith:@" 请输入正确长度的答案 " AddView:self.view];
        self.btn.enabled = NO;
    }
    else if(textView.text.length>2){
        self.btn.enabled = YES;
    }
}
-(void) setBtn{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
    self.btn = btn;
    btn.frame = CGRectMake(48*kRateX, (407-110)*kRateY, 280*kRateX, 52*kRateY);
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

//跳转下个页面 判断密保答案是否正确
-(void) jumpTOset
{
    if(_tf.text.length>=2)
    {
        
        [HttpTool.shareTool
         request:Mine_POST_checkQuestion_API
         type:HttpToolRequestTypePost
         serializer:HttpToolRequestSerializerHTTP
         bodyParameters:@{@"stu_num":self.idString,@"question_id":self.questNum,@"content":self.tf.text}
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            if ([object[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]])
            {
                self.code = object[@"data"][@"code"];
                ResetPwdViewController *rView = [[ResetPwdViewController alloc]init];
                rView.stuID = self.idString;
                rView.changeCode = self.code;
                [self.navigationController pushViewController:rView animated:YES];
            }
            else
            {
                UILabel *tipsLable = [[UILabel alloc]init];
                tipsLable.text = @"密保答案错误";
                tipsLable.font =[UIFont fontWithName:PingFangSC size:12];
                tipsLable.textColor = [UIColor colorWithRed:11/225.0 green:204/225.0 blue:240/225.0 alpha:1.0];
                [self.view addSubview:tipsLable];
                [tipsLable mas_makeConstraints:^(MASConstraintMaker *make)
                {
                            make.top.mas_equalTo(self.view).mas_offset(SCREEN_HEIGHT * 0.29 + TOTAL_TOP_HEIGHT);
                            make.left.mas_equalTo(self.view).mas_offset(SCREEN_WIDTH * 0.053);
                            make.width.mas_equalTo(SCREEN_WIDTH * 0.31);
                }];
                [NewQAHud showHudWith:@" 密保答案错误 " AddView:self.view];
        }
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
        }];
        
//        [[HttpClient defaultClient]requestWithPath:Mine_POST_checkQuestion_API method:HttpRequestPost parameters:@{@"stu_num":self.idString,@"question_id":self.questNum,@"content":self.tf.text} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
//        {
//            if([responseObject[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]])
//            {
//                self.code = responseObject[@"data"][@"code"];
//                ResetPwdViewController *rView = [[ResetPwdViewController alloc]init];
//                rView.stuID = self.idString;
//                rView.changeCode = self.code;
//                [self.navigationController pushViewController:rView animated:YES];
//            }
//            else
//            {
//                UILabel *tipsLable = [[UILabel alloc]init];
//                tipsLable.text = @"密保答案错误";
//                tipsLable.font =[UIFont fontWithName:nil size:12];
//                tipsLable.textColor = [UIColor colorWithRed:11/225.0 green:204/225.0 blue:240/225.0 alpha:1.0];
//                [self.view addSubview:tipsLable];
//                [tipsLable mas_makeConstraints:^(MASConstraintMaker *make)
//                {
//                            make.top.mas_equalTo(self.view).mas_offset(SCREEN_HEIGHT * 0.29 + TOTAL_TOP_HEIGHT);
//                            make.left.mas_equalTo(self.view).mas_offset(SCREEN_WIDTH * 0.053);
//                            make.width.mas_equalTo(SCREEN_WIDTH * 0.31);
//                }];
//                [NewQAHud showHudWith:@" 密保答案错误 " AddView:self.view];
//        }
//        }
//        failure:^(NSURLSessionDataTask *task, NSError *error){
//            [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
//        }
//            ];
        }
    else
        {
        UILabel *tipsLable = [[UILabel alloc]init];
        tipsLable.text = @"请至少输入两个字符";
        tipsLable.font =[UIFont fontWithName:PingFangSC size:12];
        tipsLable.textColor = [UIColor colorWithRed:11/225.0 green:204/225.0 blue:240/225.0 alpha:1.0];
        [self.view addSubview:tipsLable];
        [tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.view).mas_offset(SCREEN_HEIGHT * 0.27 + TOTAL_TOP_HEIGHT);
                    make.left.mas_equalTo(self.view).mas_offset(SCREEN_WIDTH * 0.053);
                    make.width.mas_equalTo(SCREEN_WIDTH * 0.31);
                    //make.height.mas_equalTo(SCREEN_WIDTH * 0.7467 * 52/280);
        }];
    }
    
}

//获取密保问题
-(void) get1{
    NSString *num = [[NSString alloc] init];
    NSString *stuNum = UserItemTool.defaultItem.stuNum;
    if(self.idString!=nil)
        num = self.idString;
    else
        num = stuNum;
    
    [HttpTool.shareTool
     request:Mine_POST_getQuestion_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:@{@"stu_num":num}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            NSArray *array = object[@"data"];
            NSDictionary *dic = array[0];
            self.questNum = dic[@"id"];
            NSString *str = dic[@"content"];
            self.label3.text = str;
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
    }];
    
    
//    [[HttpClient defaultClient] requestWithPath:Mine_POST_getQuestion_API method:HttpRequestPost  parameters:@{@"stu_num":num} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
////        NSString *questWord = responseObject[@"data"][@"content"];
////        NSString *questWord = responseObject[@"data"][@"content"];
//        NSArray *array = responseObject[@"data"];
//        NSDictionary *dic = array[0];
//        self.questNum = dic[@"id"];
//        NSString *str = dic[@"content"];
//        self.label3.text = str;
//
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [NewQAHud showHudWith:@" 网络请求错误 " AddView:self.view];
//        }];
}
@end
