//
//  AddRemindViewController.m
//  Demo
//
//  Created by 李展 on 2016/11/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "AddRemindViewController.h"
#import "RemindTableViewCell.h"
#import "TimeChooseViewController.h"
#import "WeekChooseViewController.h"
#import "TimeChooseScrollView.h"
#import "TimeHandle.h"
#import "CoverView.h"
#import "ORWInputTextView.h"
#import "RemindNotification.h"
#import "UserDefaultTool.h"

@interface AddRemindViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,TimeChooseScrollViewDelegate,SaveDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ORWInputTextView *contentTextView;
@property (nonatomic, strong) TimeChooseScrollView *remindTimeChooseView;
@property (nonatomic, strong) CoverView *coverView;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, strong) NSNumber *idNum;
@property (nonatomic, strong) NSArray <NSNumber *> *weekArray;
@property (nonatomic, strong) NSMutableArray <NSNumber *> *timeArray;
@property (nonatomic, strong) NSMutableArray <NSMutableDictionary *> *cellDicArray;
@property (nonatomic, strong) TimeChooseViewController *timeChooseVC;
@property (nonatomic, strong) WeekChooseViewController *weekChooseVC;
@property (nonatomic, copy) NSDictionary *remind;
@property (nonatomic, assign) BOOL isEditing;

@end

@implementation AddRemindViewController
- (instancetype)initWithRemind:(NSDictionary *)remind{
    self = [self init];
    if (self) {
        self.remind = remind;
        self.isEditing = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事项编辑";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.cellDicArray = @[@{@"title":@"周数",@"img":@"remind_image_week",@"content":@""}.mutableCopy,
                          @{@"title":@"时间",@"img":@"remind_image_time",@"content":@""}.mutableCopy,
                          @{@"title":@"提醒",@"img":@"remind_image_remind",@"content":@""}.mutableCopy]
                            .mutableCopy;
    [[RemindNotification shareInstance] creatIdentifiers];
    self.titleTextField.delegate = self;
    self.titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;    //防止文字输入后下移
    self.contentTextView.delegate = self;
    self.coverView = [[CoverView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    __weak typeof(self) weakSelf = self;
    self.coverView.passTap = ^(NSSet *touches,UIEvent *event){
        [weakSelf touchesBegan:touches withEvent:event];
    };
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"remind_image_confirm"] style:UIBarButtonItemStyleDone target:self action:@selector(saveRemind)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.remindTimeChooseView = [[TimeChooseScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/12*7.f, SCREEN_WIDTH, SCREEN_HEIGHT/12*5.f)titles:@[@"不提醒",@"提前五分钟",@"提前十分钟",@"提前二十分钟",@"提前半小时",@"提前一小时"]];
    self.remindTimeChooseView.chooseDelegate = self;
    CGRect frame = self.remindTimeChooseView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    frame.size.height = 1;
    self.remindTimeChooseView.frame = frame;
    self.remindTimeChooseView.hidden = YES;
    self.isEditing = NO;
    [self loadViewWithRemind:self.remind];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadViewWithRemind:(NSDictionary *)remind{
    if (remind != nil) {
        self.isEditing = YES;
        self.idNum = remind[@"id"];
        self.titleTextField.text = remind[@"title"];
        self.contentTextView.text = remind[@"content"];
        NSArray *dateArray = remind[@"date"];
        self.timeArray = [NSMutableArray array];
        for (int i = 0; i<dateArray.count; i++) {
            self.weekArray = dateArray[i][@"week"];
            NSInteger timeCount = [dateArray[i][@"day"] integerValue]*LONGLESSON+[dateArray[i][@"class"] integerValue];
            [self.timeArray addObject:@(timeCount)];
        }
        self.time = remind[@"time"];
        NSArray *array = @[@0,@5,@10,@20,@30,@60];
        if (self.time == nil) {
            self.time = array[0];
            [self.remindTimeChooseView tapAtIndex:0];
        }
        else {
            for (int i = 0;i<array.count;i++) {
                if ([array[i] isEqual:self.time]) {
                    [self.remindTimeChooseView tapAtIndex:i];
                    break;
                }
            }
        }
        self.cellDicArray[0][@"content"] = [TimeHandle handleWeeks:self.weekArray];
        self.cellDicArray[1][@"content"] = [TimeHandle handleTimes:self.timeArray];
        self.cellDicArray[2][@"content"] = self.remindTimeChooseView.currenSelectedTitle;
        [self.tableView reloadData];
    }
    else{
        self.contentTextView.placeHolder = @"请编辑内容……";
        NSArray *weeks = @[[UserDefaultTool valueWithKey:@"nowWeek"]].mutableCopy;
        [self saveWeeks:weeks];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - textView设置

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length <= 0) {
        self.contentTextView.placeHolder = @"请编辑内容……";
    }
    else{
        self.contentTextView.placeHolder = @"";
    }
}

- (BOOL)textView:(UITextView *)textView didChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (text.length <= 0) {
        self.contentTextView.placeHolder = @"请编辑内容……";
    }
    else{
        self.contentTextView.placeHolder = @"";
    }
    return YES;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"RemindTableViewCell" owner:self options:nil][0];
    NSInteger index = indexPath.row;
    cell.titleLabel.text = self.cellDicArray[index][@"title"];
    cell.contentLabel.text = self.cellDicArray[index][@"content"];
    cell.cellImageView.image = [UIImage imageNamed:self.cellDicArray[index][@"img"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.height/self.cellDicArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titleTextField resignFirstResponder];
    [self.contentTextView resignFirstResponder];
    switch (indexPath.row) {
        case 0:
            self.weekChooseVC = [[WeekChooseViewController alloc]initWithTimeArray:self.weekArray];
            self.weekChooseVC.delegate = self;
            [self.navigationController pushViewController:self.weekChooseVC animated:YES];
            break;
        case 1:
            self.timeChooseVC = [[TimeChooseViewController alloc] initWithTimeArray:self.timeArray];
            self.timeChooseVC.delegate = self;
            [self.navigationController pushViewController:self.timeChooseVC animated:YES];
            break;
        case 2:
            [self remindChooseViewAnimated];
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.remindTimeChooseView.hidden){
        [self remindChooseViewAnimated];
    }
    [self.titleTextField resignFirstResponder];
    [self.contentTextView resignFirstResponder];
}

- (void)remindChooseViewAnimated{
    if (!self.remindTimeChooseView.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.remindTimeChooseView.frame;
            frame.origin.y = SCREEN_HEIGHT;
            frame.size.height = 1;
            self.remindTimeChooseView.frame = frame;
        }completion:^(BOOL finished) {
            self.remindTimeChooseView.hidden = YES;
            [self.remindTimeChooseView removeFromSuperview];
            [self.coverView removeFromSuperview];
        }];
    }
    else{
        [self.view.window addSubview:self.coverView];
        [self.view.window addSubview:self.remindTimeChooseView];
        self.remindTimeChooseView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.remindTimeChooseView.frame = CGRectMake(0, SCREEN_HEIGHT/12*7.f, SCREEN_WIDTH, SCREEN_HEIGHT/12*5);
        }completion:^(BOOL finished) {
            
        }];
    }

}

- (void)eventWhenTapAtIndex:(NSInteger)index{
    NSArray *array = @[@0,@5,@10,@20,@30,@60];
    self.time = array[index];
    self.cellDicArray[2][@"content"] = self.remindTimeChooseView.currenSelectedTitle;
    [self remindChooseViewAnimated];
    [self.tableView reloadData];
}

- (void)saveWeeks:(NSArray *)weekArray{
    self.cellDicArray[0][@"content"] = [TimeHandle handleWeeks:weekArray];
    self.weekArray = weekArray;
    [self.tableView reloadData];
}

- (void)saveTimes:(NSArray *)timeArray{
    self.timeArray = timeArray.mutableCopy;
    self.cellDicArray[1][@"content"] = [TimeHandle handleTimes:timeArray];
    [self.tableView reloadData];
}

- (void)saveRemind{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"哎呀" message:@"你漏了点信息哦" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    for (int i = 0; i<self.cellDicArray.count; i++) {
        if ([self.cellDicArray[i][@"content"] isEqualToString:@""]) {
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
    }
    if([self.titleTextField.text isEqualToString:@""] || self.time == nil || self.weekArray.count == 0){
        [self presentViewController: alertController animated:YES completion:nil];
        return;
    }
    else{
        [self postRemind];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)postRemind{
    NSMutableString *idString = [NSMutableString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970]*1000)];
    [idString appendString:[NSString stringWithFormat:@"%d",arc4random()%10000]];
    NSNumber *identifier = [NSNumber numberWithString:idString];
    
    NSString *stuNum = [UserDefaultTool getStuNum];
    NSString *idNum = [UserDefaultTool getIdNum];
    
    NSMutableString *weekString = [[self.cellDicArray[0][@"content"] stringByReplacingOccurrencesOfString:@"周" withString:@""] mutableCopy];
    weekString = [[weekString stringByReplacingOccurrencesOfString:@"、" withString:@","] mutableCopy];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    for (int i = 0; i<self.timeArray.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:weekString forKey:@"week"];
        [dic setValue:@(self.timeArray[i].integerValue%(LONGLESSON)) forKey:@"class"];
        [dic setValue:@(self.timeArray[i].integerValue/(LONGLESSON)) forKey:@"day"];
        [dateArray addObject:dic];
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    NSString *failurePath = [path stringByAppendingPathComponent:@"failure.plist"];
    NSMutableArray *reminds = [NSMutableArray arrayWithContentsOfFile:remindPath]?:[NSMutableArray array];
    NSMutableArray *date = [NSMutableArray array];
    for (int i = 0; i < self.timeArray.count; i++) {
        NSNumber *classNum = @(self.timeArray[i].integerValue%(LONGLESSON));
        NSNumber *dayNum = @(self.timeArray[i].integerValue/(LONGLESSON));
        NSArray *week = self.weekArray;
        NSDictionary *dateDic = @{@"class":classNum,@"day":dayNum,@"week":week};
        [date addObject:dateDic];
    }
    NSMutableDictionary *remind = [@{
                                     @"stuNum":stuNum,
                                     @"idNum":idNum,
                                     @"title":self.titleTextField.text,
                                     @"content":self.contentTextView.text,
                                     @"date":date,
                                     } mutableCopy];
    if (![self.time isEqual:@0]) {
        [remind setObject:self.time forKey:@"time"];
    } // 如果时间为0，后台返回的为null
    
    
    NSMutableDictionary *parameters = [@{
                                         @"stuNum":stuNum,
                                         @"idNum":idNum,
                                         @"date":dateArray,
                                         @"time":self.time,
                                         @"title":self.titleTextField.text,
                                         @"content":self.contentTextView.text,
                                         } mutableCopy];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dateArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];//需要转换数组才能上传
    NSMutableDictionary *jsonParameters = [@{
                                         @"stuNum":stuNum,
                                         @"idNum":idNum,
                                         @"date":jsonString,
                                         @"time":self.time,
                                         @"title":self.titleTextField.text,
                                         @"content":self.contentTextView.text,
                                         } mutableCopy];
    NSLog(@"%@",jsonParameters);
//    HttpClient *client = [HttpClient defaultClient];
    if (!_isEditing) {
        [parameters setValue:identifier forKey:@"id"];
        [jsonParameters setValue:identifier forKey:@"id"];
        [remind setValue:identifier forKey:@"id"]; //不是正在编辑的上传新的时间戳id
        [reminds addObject:remind];
        if([reminds writeToFile:remindPath atomically:YES]){
            NSNotificationCenter *center= [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"addRemind" object:identifier];
            [[RemindNotification shareInstance] addNotifictaion];
        }
        
        [HttpTool.shareTool
         request:RisingSchedule_POST_addTransaction_API
         type:HttpToolRequestTypePost
         serializer:HttpToolRequestSerializerHTTP
         bodyParameters:jsonParameters
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            
            NSLog(@"%@",object);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemindAddSuccess" object:nil];
            
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
            NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:failurePath];
            if(failureRequests == nil){
                failureRequests = [NSMutableArray array];
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:parameters forKey:@"parameters"];
            [dic setObject:@"add" forKey:@"type"];
            [failureRequests addObject:dic];
            [failureRequests writeToFile:failurePath atomically:YES]; //为了服务器与客户端同步，请求失败的存下等待下次重新请求
        }];
        
//        [client requestWithPath:ClassSchedule_POST_addRemind_API method:HttpRequestPost parameters:jsonParameters prepareExecute:^{
//
//        } progress:^(NSProgress *progress) {
//
//        } success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@",responseObject);
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"RemindAddSuccess" object:nil];
//
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//            NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:failurePath];
//            if(failureRequests == nil){
//                failureRequests = [NSMutableArray array];
//            }
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            [dic setObject:parameters forKey:@"parameters"];
//            [dic setObject:@"add" forKey:@"type"];
//            [failureRequests addObject:dic];
//            [failureRequests writeToFile:failurePath atomically:YES]; //为了服务器与客户端同步，请求失败的存下等待下次重新请求
//        }];
    }else {
        [parameters setValue:self.idNum forKey:@"id"]; //正在编辑的上传之前存在的时间戳
        [jsonParameters setValue:self.idNum forKey:@"id"];
        [remind setValue:self.idNum forKey:@"id"];
        for (NSDictionary *remindDic in reminds) {
            if ([[remindDic objectForKey:@"id"]isEqual:self.idNum]) {
                [reminds removeObject:remindDic];
                break;
            }
        }
        [reminds addObject:remind];
        if([reminds writeToFile:remindPath atomically:YES]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"editRemind" object:self.idNum];
             [[RemindNotification shareInstance] updateNotificationWithIdetifiers:self.idNum.stringValue];
        }
        
        [HttpTool.shareTool
         request:RisingSchedule_POST_editTransaction_API
         type:HttpToolRequestTypePost
         serializer:HttpToolRequestSerializerHTTP
         bodyParameters:jsonParameters
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
                    NSLog(@"%@",object);
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"RemindEditSuccess" object:nil];
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:failurePath];
                    if(failureRequests == nil){
                        failureRequests = [NSMutableArray array];
                    }
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:parameters forKey:@"parameters"];
                    [dic setObject:@"edit" forKey:@"type"];
                    [failureRequests addObject:dic];
                    [failureRequests writeToFile:failurePath atomically:YES];
        }];
        
//        [client requestWithPath:ClassSchedule_POST_editRemind_API method:HttpRequestPost parameters:jsonParameters prepareExecute:^{
//
//        } progress:^(NSProgress *progress) {
//
//        } success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@",responseObject);
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"RemindEditSuccess" object:nil];
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:failurePath];
//            if(failureRequests == nil){
//                failureRequests = [NSMutableArray array];
//            }
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            [dic setObject:parameters forKey:@"parameters"];
//            [dic setObject:@"edit" forKey:@"type"];
//            [failureRequests addObject:dic];
//            [failureRequests writeToFile:failurePath atomically:YES];
//        }];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
