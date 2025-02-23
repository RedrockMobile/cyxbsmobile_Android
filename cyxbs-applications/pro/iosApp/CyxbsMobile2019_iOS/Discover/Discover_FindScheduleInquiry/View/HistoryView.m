//
//  HistoryView.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/20.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "HistoryView.h"
#import "DLTimeSelectedButton.h"
#define SPLIT 7//item间距
#define LINESPLIT 10//行间距
/**最多九条历史记录*/
#define MAXLEN 9
@interface HistoryView()<DLTimeSelectedButtonDelegate>
@property (nonatomic, strong)UIButton *clearHistoryItemBtn;
@property (nonatomic, strong)UILabel *historyLabel;
@end

@implementation HistoryView
- (instancetype)initWithUserDefaultKey:(NSString*)key
{
    self = [super init];
    if (self) {
        self.buttonArray = [[NSMutableArray alloc] init];
        self.UserDefaultKey = key;
        
        //添加显示“历史记录”四个字的label
        [self addHistoryLabel];
        //添加清除历史记录的按钮
        [self addClearHistoryItemBtn];
        
        [self addHistoryBtnsFromUserDefaults];
        
        [self historyBtnAddConstraints];
        
    }
    return self;
}

- (void)addHistoryBtnsFromUserDefaults{
    self.dataArray = [[NSUserDefaults.standardUserDefaults objectForKey:self.UserDefaultKey] mutableCopy];
    if(self.dataArray==nil){
        self.dataArray = [[NSMutableArray alloc] init];
        [NSUserDefaults.standardUserDefaults setObject:self.dataArray forKey:self.UserDefaultKey];
    }
    
    for (NSString *text in self.dataArray) {
        DLTimeSelectedButton *button = [[DLTimeSelectedButton alloc]init];
        
        button.delegate = self;
        
        [button setTitle:text forState:UIControlStateNormal];
        
        [button addTarget:self.btnClickedDelegate action:@selector(touchHistoryButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        [self.buttonArray addObject:button];
    }
    
}

- (void)historyBtnAddConstraints {
    if(self.buttonArray.count==0)return;
    __block int k = 0;
    [self.buttonArray[0] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.historyLabel.mas_bottom).offset(LINESPLIT);
            make.left.equalTo(self);
    }];
    __block float lastBtnW,lastBtnX;
    for (int i = 1; i < self.buttonArray.count; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self layoutIfNeeded];
            lastBtnW = self.buttonArray[i-1].frame.size.width;
            lastBtnX = self.buttonArray[i-1].frame.origin.x;
            if(lastBtnX + lastBtnW*2 > self.width) {
                k++;
                [self.buttonArray[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.historyLabel.mas_bottom).offset(k*MAIN_SCREEN_W*0.1147+LINESPLIT);
                    make.left.equalTo(self);
                }];
            }else {
                [self.buttonArray[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(SPLIT+lastBtnW+lastBtnX);
                    make.top.equalTo(self.historyLabel.mas_bottom).offset(k*MAIN_SCREEN_W*0.1147+LINESPLIT);
                }];
            }
            });
    }
}

- (void)addHistoryBtnWithString:(NSString*)string reLayout:(BOOL)is{
    if([string isEqualToString:[self.dataArray firstObject]]){return;}
    
    DLTimeSelectedButton *btn = [[DLTimeSelectedButton alloc]init];
    [btn setTitle:string forState:UIControlStateNormal];
    [btn addTarget:self.btnClickedDelegate action:@selector(touchHistoryButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.delegate = self;
    
    for (int i=0; i<self.buttonArray.count; i++) {
        if([self.buttonArray[i].titleLabel.text isEqualToString:string]){
            [self.buttonArray[i] removeFromSuperview];
            [self.buttonArray removeObject:self.buttonArray[i]];
            [self.dataArray removeObject:string];
            break;
        }
    }
    [self.buttonArray insertObject:btn atIndex:0];
    [self.dataArray insertObject:string atIndex:0];
    
    if(self.buttonArray.count>MAXLEN){
        UIButton *lastBtn = [self.buttonArray lastObject];
        [lastBtn removeFromSuperview];
        [self.dataArray removeLastObject];
        [self.buttonArray removeLastObject];
    }
    
    btn.frame = CGRectMake(-100, 0, 0, 0);
    [self addSubview:btn];
    
    if(is==YES){
        [self historyBtnAddConstraints];
    }
    //储存搜索记录
    [self write:string intoDataArrayWithUserDefaultKey:self.UserDefaultKey];
    self.clearHistoryItemBtn.enabled = YES;
}

- (void)deleteButtonWithBtn:(UIButton *)btn{
    [self.buttonArray removeObject:btn];
    [self.dataArray removeObject:btn.titleLabel.text];
    [self remove:btn.titleLabel.text fromDataArrayWithUserDefaultKey:self.UserDefaultKey];
    [btn removeFromSuperview];
    [self historyBtnAddConstraints];
    if(self.buttonArray.count==0){
        self.clearHistoryItemBtn.enabled = NO;
    }
}

//把str写入key对应的那个缓存数组，再把数组放回去（在原有缓存里加上str），实现记录搜索记录的方法
- (void)write:(NSString*)str intoDataArrayWithUserDefaultKey:(NSString*)key{
    
    //写入缓存
    NSUserDefaults *defa = NSUserDefaults.standardUserDefaults;
    
    //这里取出的是一个数组，内部是部分搜索历史记录，从缓存取出来后要mutableCopy一下，不然会崩
    NSMutableArray *array = [[defa objectForKey:key] mutableCopy];
    
    //现在array不可能是nil
    
    //判断是否和以前的搜索内容一样，如果一样就移除旧的历史记录
    for (NSString *historyStr in array) {
        if ([historyStr isEqualToString:str]) {
            [array removeObject:str];
            break;
        }
    }
    
    //加到数组的第一个，这样可以把最新的历史记录显示在最上面
    [array insertObject:str atIndex:0];

    //限制最多缓存MAXLEN个历史记录
    if(array.count>MAXLEN){
        [array removeLastObject];
    }
    
    //加上重新放回去
    [defa setObject:array forKey:key];
}

- (void)remove:(NSString*)str fromDataArrayWithUserDefaultKey:(NSString*)key{
    NSUserDefaults *defa = NSUserDefaults.standardUserDefaults;
    
    NSMutableArray *array = [[defa objectForKey:key] mutableCopy];
    
    [array removeObject:str];
    [defa setObject:array forKey:key];
}

//添加清除历史记录的按钮
- (void)addClearHistoryItemBtn{
    UIButton *btn = [[UIButton alloc] init];
    [self addSubview:btn];
    self.clearHistoryItemBtn = btn;
    [btn setBackgroundImage:[UIImage imageNamed:@"草稿箱垃圾桶"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clearHistoryItemBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //拿到存放历史记录的缓存数组
    NSArray *array = [NSUserDefaults.standardUserDefaults objectForKey:self.UserDefaultKey];
    //如果没有历史记录，那就让按钮失效
    if(array.count==0)btn.enabled = NO;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.historyLabel);
        make.centerX.equalTo(self).offset(0.4307*MAIN_SCREEN_W);
        make.width.height.mas_equalTo(0.0533*MAIN_SCREEN_W);
        make.height.mas_equalTo(0.05931*MAIN_SCREEN_W);
    }];
}

//点击清除历史记录按钮后调用
- (void)clearHistoryItemBtnClicked{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"删除搜索记录" message:@"是否确定删除记录" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAC = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *deleteAC = [UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        //1.从缓存去除记录
        [NSUserDefaults.standardUserDefaults setObject:[@[] mutableCopy] forKey:self.UserDefaultKey];
        
        //2.去除控件上的记录
        [self removeHistoryBtn];
        
        //3.让按钮取消失效
        self.clearHistoryItemBtn.enabled = NO;
    }];
    
    [ac addAction:deleteAC];
    [ac addAction:cancelAC];
    
    [self.viewController presentViewController:ac animated:YES completion:nil];
}

//添加显示“历史记录”四个字的label
- (void)addHistoryLabel {
    UILabel *label = [[UILabel alloc]init];
    self.historyLabel = label;
    label.text = @"历史记录";
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSCSemibold size:15];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
    }];
}

//清空历史记录
- (void)removeHistoryBtn{
    for (int i=0; i<self.buttonArray.count; i++) {
        [self.buttonArray[i] removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    [self.dataArray removeAllObjects];
}


@end
