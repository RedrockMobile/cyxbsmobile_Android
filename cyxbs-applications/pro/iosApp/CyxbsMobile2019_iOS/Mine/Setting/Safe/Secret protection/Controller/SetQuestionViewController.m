//
//  SetQuestionViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "SetQuestionViewController.h"
#import "questionAndAnswerModel.h"
#import <MBProgressHUD.h>
#import <Masonry.h>

@interface SetQuestionViewController ()<SetQuestionViewDeleagte,UITextViewDelegate>
@property (nonatomic, strong) MBProgressHUD *successfulHud;

@end

@implementation SetQuestionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SetQuestionView *setquestionView = [[SetQuestionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    setquestionView.delegate = self;
    setquestionView.textView.delegate = self;
    setquestionView.placeholderLabMore.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NoNetWorkToGetQuestionList) name:@"NoNetWorkToGetQuestionList" object:nil];
    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doClick:)];
    [setquestionView.questionLabel addGestureRecognizer:tapRecognizer];
    [self.view addSubview:setquestionView];
    _setquestionView = setquestionView;
    
    ///问题列表
    QuestionView *questionView = [[QuestionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _questionView = questionView;
    UITapGestureRecognizer *dismissRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissClick:)];
    [_questionView.backView addGestureRecognizer:dismissRecognizer];
    
    ///实时更新Label里的问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUpload) name:@"changeTitle" object:nil];
    
}

#pragma mark - setquestionView的代理
///点击返回按钮
- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

///点击确定
- (void)ClickedSureBtn {
    ///将设置好的数据传到后端去
    [self questionAndAnswer];
}

#pragma mark -textView的代理
- (void)textViewDidChange:(UITextView *)textView
{
    ///监听按钮
    _setquestionView.sureBtn.enabled = (_setquestionView.textView.text.length >= 2 && _setquestionView.textView.text.length <= 16) && ![_setquestionView.questionLabel.text isEqualToString: @"请选择一个密保问题"] ? YES : NO;
    ///按钮的背景颜色
    _setquestionView.sureBtn.backgroundColor = _setquestionView.sureBtn.enabled == YES ?[UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1.0] : [UIColor colorWithRed:194/255.0 green:203/255.0 blue:254/255.0 alpha:1.0];
    ///提示文字的出现
    _setquestionView.placeholderLabLess.hidden = _setquestionView.textView.text.length >= 2 == YES ? YES : NO;
    _setquestionView.placeholderLabMore.hidden = _setquestionView.textView.text.length <= 16 ? YES : NO;
        
}

///点击问题后弹出列表
- (void)doClick:(UITapGestureRecognizer *)sender{
    [_questionView popQuestionView:self.view];
}

- (void)dismissClick:(UITapGestureRecognizer *)sender{
    [_questionView removeFromSuperview];
}


///更新问题文字
- (void)showUpload {
    _setquestionView.questionLabel.text = _questionView.question;
 }

///弹窗：提示设置成功
- (void)setQuestionSuccessful {
    self.successfulHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.successfulHud.mode = MBProgressHUDModeText;
    self.successfulHud.labelText = @"恭喜你 设置成功";
    [self.successfulHud hide:YES afterDelay:1.2];
    [self.successfulHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [self.successfulHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

///弹窗：提示密保格式有问题
- (void)setQuestionError {
    MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    errorHud.mode = MBProgressHUDModeText;
    errorHud.labelText = @"密保内容格式有问题 请重新设置吧~";
    [errorHud hide:YES afterDelay:1.2];
    [errorHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [errorHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

///弹窗：提示没有网络，无法更改密码
- (void)NoNetWorkToGetQuestionList {
    MBProgressHUD *noNetHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    noNetHud.mode = MBProgressHUDModeText;
    noNetHud.labelText = @"没有网络，请检查网络连接";
    [noNetHud hide:YES afterDelay:1.2];
    [noNetHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [noNetHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}

///将密保问题传回后端
- (void)questionAndAnswer {
    questionAndAnswerModel *model = [[questionAndAnswerModel alloc] init];
    [model sendQuestionAndAnswerWithId:_questionView.questionId AndContent:_setquestionView.textView.text];
    [model setBlock:^(id  _Nonnull info) {
        if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10000]]) {
            [self setQuestionSuccessful];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else if ([info[@"status"] isEqualToNumber:[NSNumber numberWithInt:10021]]) {
            [self setQuestionError];
        }
    }];
}


@end
