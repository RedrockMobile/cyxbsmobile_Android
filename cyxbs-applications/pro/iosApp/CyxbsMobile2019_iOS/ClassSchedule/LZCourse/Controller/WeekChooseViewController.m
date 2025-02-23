//
//  WeekChooseViewController.m
//  Demo
//
//  Created by 李展 on 2016/11/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "WeekChooseViewController.h"
#import "WeekChooseButton.h"
@interface WeekChooseViewController ()
@property (nonatomic, strong) NSMutableArray *weekArray;
@property (nonatomic, strong) NSMutableArray <WeekChooseButton *> *btnArray;
@end

@implementation WeekChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"周数编辑";
    self.btnArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    NSArray *weekNameArray = @[@"第1周",@"第2周",@"第3周",@"第4周",@"第5周",@"第6周",@"第7周",@"第8周",@"第9周",@"第10周",@"第11周",@"第12周",@"第13周",@"第14周",@"第15周",@"第16周",@"第17周",@"第18周",@"第19周",@"第20周"];
    for (int i = 0; i<5; i++) {
        for (int j = 0; j<4; j++) {
            CGFloat blankWidth = (SCREEN_WIDTH-34-240)/3;
            WeekChooseButton *btn = [[WeekChooseButton alloc]initWithFrame:CGRectMake(17+j*(blankWidth+60), 16+HEADERHEIGHT+(60+25)*i, 60, 60)];
            //瞎jb算的,后面看到的人饶命= =
            btn.tag = i*4+j+1;
            [btn setTitle:weekNameArray[i*4+j] forState:UIControlStateNormal];
            if ([self.weekArray containsObject:@(btn.tag)]) {
                btn.selected = YES;
            }
            [self.btnArray addObject:btn];
            [self.view addSubview:btn];
        }
    }
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"remind_image_confirm"] style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithTimeArray:(NSArray *)weekArray{
    self = [self init];
    if (self) {
        self.weekArray = weekArray.mutableCopy;
    }
    return self;
}

- (void)save{
    self.weekArray = [NSMutableArray array];
    for (WeekChooseButton *btn in self.btnArray) {
        if (btn.selected == YES) {
            [self.weekArray addObject:@(btn.tag)];
        }
    }
    if([self.delegate respondsToSelector:@selector(saveWeeks:)]){
        [self.delegate saveWeeks:self.weekArray.copy];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
