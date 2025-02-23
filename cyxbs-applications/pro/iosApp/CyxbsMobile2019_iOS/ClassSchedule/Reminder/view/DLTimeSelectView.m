//
//  DLTimeSelectView.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/11.
//  Copyright © 2020 Redrock. All rights reserved.
//用两个picker选择时间的那个view

#import "DLTimeSelectView.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准

@interface DLTimeSelectView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIView *backViewOfPickerView;

@property(nonatomic,strong)NSArray *weekTextArray;

@property(nonatomic,strong)NSArray *lessonTextArray;

/// weekPicker选择的数据
@property(nonatomic,copy)NSString *weekString;

/// lessonPicker选择的数据
@property(nonatomic,copy)NSString *lessonString;

@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation DLTimeSelectView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, -300*kRateY, MAIN_SCREEN_W, 300*kRateY+MAIN_SCREEN_H);
        [self initBackViewOfPickerView];
        [self initLessonPickerAndWeekPicker];
        [self initAddButton];
        [self addGesture];
        self.weekTextArray =
        @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        self.lessonTextArray =
        @[@"一二节课",@"三四节课",@"五六节课",@"七八节课",@"九十节课",@"十一十二节课"];
        self.weekString = @"周一";
        self.lessonString = @"一二节课";
    }
    return self;
}

- (void)initBackViewOfPickerView{
    self.backViewOfPickerView = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_H, MAIN_SCREEN_W, 300*kRateY+30)];
    
    [self addSubview:self.backViewOfPickerView];
    
    if (@available(iOS 11.0, *)) {
        self.backViewOfPickerView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    } else {
         self.backViewOfPickerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    
//    self.backViewOfPickerView.backgroundColor = [UIColor colorWithRGB:23 alpha:0.5];
    
//    self.backViewOfPickerView.layer.shadowColor = [UIColor colorWithRed:83/255.0 green:105/255.0 blue:188/255.0 alpha:0.8].CGColor;
    self.backViewOfPickerView.layer.shadowOffset = CGSizeMake(0,2.5);
    self.backViewOfPickerView.layer.shadowRadius = 15;
    self.backViewOfPickerView.layer.shadowOpacity = 0.3;
    self.backViewOfPickerView.layer.cornerRadius = 16;
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {}];
    [self.backViewOfPickerView addGestureRecognizer:tgr];
}


- (void)initLessonPickerAndWeekPicker{
    //先添加处于中间的lessonPicker
    self.lessonPicker = [[UIPickerView alloc] init];
    [self.backViewOfPickerView addSubview:self.lessonPicker];
    self.lessonPicker.dataSource = self;
    self.lessonPicker.delegate = self;
    
    [self.lessonPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backViewOfPickerView);
        make.top.equalTo(self.backViewOfPickerView);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.6);
        make.width.mas_equalTo(MAIN_SCREEN_W*1.0346);
    }];
//    0.42373
    //--------------------------
    
    //再来一个view盖在左侧，把lessonPicker的一部分区域盖住
    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithRGB:23 alpha:0.5];
    [self.backViewOfPickerView addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backViewOfPickerView);
        make.top.equalTo(self.backViewOfPickerView);
        make.bottom.equalTo(self.backViewOfPickerView);
        make.width.mas_equalTo(MAIN_SCREEN_W*0.352);
    }];
    
    //然后在view上面加weekPicker，这样两个picker就不会互相干扰，又能有设计图上的效果
    self.weekPicker = [[UIPickerView alloc] init];
    [view addSubview:self.weekPicker];
    self.weekPicker.dataSource = self;
    self.weekPicker.delegate = self;
    
    [self.weekPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.top.equalTo(view);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.6);
    }];
    
}

- (void)initAddButton{
    self.addButton = [[UIButton alloc] init];
    [self.addButton setImage:[UIImage imageNamed:@"timeAddImage"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton sizeToFit];
    
    [self.backViewOfPickerView addSubview: self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.weekPicker);
        make.right.equalTo(self.backViewOfPickerView).mas_offset(-50*kRateX);
        make.width.mas_equalTo(MAIN_SCREEN_W*0.0693);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.0693);
    }];
}
- (void)addGesture{
    UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, 0, MAIN_SCREEN_W, 300*kRateY+MAIN_SCREEN_H);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
    [self addGestureRecognizer:TGR];
}

/// 点击周选择view的加号后调用这个方法
- (void)addBtnClicked{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, MAIN_SCREEN_W, 300*kRateY+MAIN_SCREEN_H);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    //调用代理方法
    NSDictionary *timeDict = @{
        @"weekString":self.weekString,
        @"lessonString":self.lessonString
    };
    if([self.delegate.timeDictArray containsObject:timeDict]){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"这个时间已经添加过了";
        [hud hide:YES afterDelay:0.8];
    }else{
        //虽然这边可以直接修改timeDictArray的元素，但是还是放到代理内部改比较好
        //,实际上只有修改timeDictArray的操作都放到了TimeSelectedBtnsView
        [self.delegate pickerDidSelectedWithDataDict:timeDict];
    }
}


//MARK:-picker的代理方法：
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if([pickerView isEqual:self.weekPicker]){
        return self.weekTextArray.count;
    }else{
        return self.lessonTextArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if([pickerView isEqual:self.weekPicker]){
        return self.weekTextArray[row];
    }else{
        return self.lessonTextArray[row];
    }
}

//实现这个方法，可以自定义picker的外观
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        if (@available(iOS 11.0, *)) {
            pickerLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#122D55" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
             pickerLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
        }
        [pickerLabel setFont: [UIFont fontWithName:PingFangSCSemibold size: 16]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if([pickerView isEqual:self.weekPicker]){
        self.weekString = self.weekTextArray[row];
    }else{
        self.lessonString = self.lessonTextArray[row];
    }
}
@end
